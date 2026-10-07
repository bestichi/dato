"""Safe-zone checks on the rendered cover: desktop band, mobile profile disc, caption extents."""
import sys
from PIL import Image
import numpy as np
D = sys.argv[1]
a = np.array(Image.open(f'{D}/cover_raw.png').convert('RGB')).astype(int)
ink = np.array([14, 17, 16])
non = np.abs(a - ink).max(2) > 12
ys, xs = np.where(non)
print('content bbox x %d..%d  y %d..%d   (safe: x 30..930, y 95..425)' % (xs.min(), xs.max(), ys.min(), ys.max()))
yy, xx = np.mgrid[0:540, 0:960]
dist = np.hypot(xx - 480, yy - 540)
ring_r = (528 + 24) / 2 / (1170 / 960)        # fb_sim profile picture incl. white ring, in cover px
inside = non & (dist < ring_r + 15)
print('mobile ring radius %.1f px (top y=%.1f); content pixels within ring+15px: %d' % (ring_r, 540 - ring_r, inside.sum()))
d_min = dist[non].min(); print('closest content to profile centre: %.1f px -> clearance %.1f px' % (d_min, d_min - ring_r))
zone = non & (dist < 225 + 0) & (np.hypot(xx - 480, yy - 570) < 225)
print('content inside zone circle (480,570) r225: %d' % (non & (np.hypot(xx - 480, yy - 570) < 225)).sum())
# caption band (below the rule) per column
band = non[272:340]
for x0 in (196, 344, 492, 640, 788):
    cols = np.where(band[:, x0 - 2:x0 + 140].any(0))[0]
    rows = np.where(band[:, x0 - 2:x0 + 140].any(1))[0]
    if len(cols): print('caption @%d: x %d..%d  y %d..%d' % (x0, x0 - 2 + cols.min(), x0 - 2 + cols.max(), 272 + rows.min(), 272 + rows.max()))
