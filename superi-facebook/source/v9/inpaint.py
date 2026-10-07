"""Remove AI-rendered text/graphics from given boxes by normalized-convolution inpainting.

usage: python3 inpaint.py src.png out.png '[[x0,y0,x1,y1,"diff"|"fg"], ...]'
  fg   = mask only clearly foreground pixels (dark or saturated), dilated: keeps background detail around
  diff = mask everything that differs from the smoothed background inside the box (soft shadows, panels)
"""
import sys, json, numpy as np
from PIL import Image
import scipy.ndimage as nd

src, out_path, boxes = sys.argv[1], sys.argv[2], json.loads(sys.argv[3])
im = np.asarray(Image.open(src).convert('RGB')).astype(np.float32)
H, W, _ = im.shape
L = im.mean(axis=2); mx = im.max(axis=2); mn = im.min(axis=2); sat = (mx - mn) / np.maximum(mx, 1)
fgall = (L < 215) | (sat > 0.10)

def nconv(img, known, sig, ret_w=False):
    w = nd.gaussian_filter(known.astype(np.float32), sig)
    o = np.stack([nd.gaussian_filter(img[..., c] * known, sig) for c in range(3)], -1)
    o = o / np.maximum(w[..., None], 1e-6)
    return (o, w) if ret_w else o

mask = np.zeros((H, W), bool)
for x0, y0, x1, y1, mode in boxes:
    box = np.zeros((H, W), bool); box[y0:y1, x0:x1] = True
    if mode == 'fg':
        m = nd.binary_dilation(box & fgall, iterations=4) & nd.binary_dilation(box, iterations=4)
    else:
        bg0 = nconv(im, ~(box & fgall), 18)
        m = nd.binary_dilation(box & ((np.abs(im - bg0).sum(axis=2) > 7) | fgall), iterations=3)
    mask |= m

# pixels allowed to feed the fill: unmasked and not dark product/frame pixels
known = ~mask & (L > 120)
out = im.copy()
filled = known.copy()
for sig in (6, 12, 24, 48, 96):
    est, w = nconv(out, filled, sig, True)
    upd = mask & ~filled & (w > 0.02)
    out[upd] = est[upd]; filled |= upd
for sig in (30, 15):
    est, w = nconv(out, known, sig, True)
    a = np.clip((w - 0.02) / 0.2, 0, 1)[..., None]
    out[mask] = (est * a + out * (1 - a))[mask]
sm = np.stack([nd.gaussian_filter(out[..., c], 1.2) for c in range(3)], -1)
m3 = nd.gaussian_filter(mask.astype(np.float32), 1.5)[..., None]
out = out * (1 - m3) + sm * m3
rng = np.random.default_rng(3); out[mask] += rng.normal(0, 0.8, (int(mask.sum()), 3))
Image.fromarray(np.clip(out, 0, 255).astype(np.uint8)).save(out_path)
print('masked px', int(mask.sum()))
