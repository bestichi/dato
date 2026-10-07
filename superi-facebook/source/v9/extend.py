"""Extend a wide banner band to a 960x540 (16:9) canvas.
Top: continue the ceiling by repeating the edge rows (vertical elements just continue upward).
Bottom: glossy-floor reflection with blur that grows with distance from the seam (no visible seam)."""
import sys, numpy as np
from PIL import Image
import scipy.ndimage as nd
src, out_path, top = sys.argv[1], sys.argv[2], int(sys.argv[3])
b = Image.open(src).convert('RGB')
W, H = 960, 540
h = round(b.height * W / b.width); bot = H - top - h
band = np.asarray(b.resize((W, h), Image.LANCZOS)).astype(np.float32)
c = np.zeros((H, W, 3), np.float32); c[top:top + h] = band
# top: edge rows repeated, blurred horizontally a little more the higher we go, lightened toward the top
edge = band[:3].mean(axis=0)
for i in range(top):                    # i = distance from seam
    d = (i + 1) / top
    row = np.stack([nd.gaussian_filter1d(edge[:, ch], 1 + 6 * d) for ch in range(3)], -1)
    c[top - 1 - i] = row * (1 - 0.25 * d) + np.array([246, 247, 247]) * 0.25 * d
# bottom: mirror with progressive blur and fade
mir = band[::-1][:bot]
levels = [mir] + [np.stack([nd.gaussian_filter(mir[..., ch], s) for ch in range(3)], -1) for s in (1.5, 3, 5, 8)]
for i in range(bot):
    d = i / max(bot - 1, 1)
    k = d * (len(levels) - 1); lo = int(k); hi = min(lo + 1, len(levels) - 1); t = k - lo
    row = levels[lo][i] * (1 - t) + levels[hi][i] * t
    f = 0.15 + 0.55 * d
    c[top + h + i] = row * (1 - f) + np.array([238, 240, 240]) * f
Image.fromarray(np.clip(c, 0, 255).astype(np.uint8)).save(out_path)
print('band', h, 'top', top, 'bottom', bot)
