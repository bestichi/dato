import cv2, numpy as np, sys, os
PAGE, OUTDIR = int(sys.argv[1]), sys.argv[2]
LO, HI = 0.50, 0.90
MM = 300/25.4
img = cv2.imread(os.path.join(OUTDIR,'rect%d.png'%PAGE)).astype(np.float32)
vm = cv2.imread(os.path.join(OUTDIR,'vmask%d.png'%PAGE), 0)
vm = cv2.erode(vm, np.ones((31,31),np.uint8))
H, W = vm.shape
# content frame (mm) - everything outside is forced white
fr = np.zeros_like(vm); fr[int(14*MM):int(278.5*MM), int(16*MM):int(196*MM)] = 255
vm = cv2.bitwise_and(vm, fr)
m = vm > 0
med = np.median(img[m], axis=0)
filled = img.copy(); filled[~m] = med
# background per channel: large median (ignores text) + blur
bg = np.stack([cv2.GaussianBlur(cv2.medianBlur(filled[...,c].astype(np.uint8), 61).astype(np.float32), (0,0), 15) for c in range(3)], axis=-1)
norm = np.clip(img / np.maximum(bg, 1), 0, 1.6)
nB, nG, nR = norm[...,0], norm[...,1], norm[...,2]
v = 0.25*nR + 0.65*nG + 0.10*nB
ink0 = v < 0.7
paper_only = m & ~cv2.dilate(ink0.astype(np.uint8), np.ones((9,9),np.uint8)).astype(bool)
print('paper-only v percentiles 1/5/50: %s   ink v median %.2f' % (np.percentile(v[paper_only],[1,5,50]).round(3), np.median(v[ink0&m])))
# smooth jaggies, then sharpen
vs = np.clip(v, 0, 1.2)
vs = vs + 1.0*(vs - cv2.GaussianBlur(vs, (0,0), 1.5))
d = np.clip((HI - vs)/(HI - LO), 0, 1) ** 0.6
# local-contrast gate: no real ink nearby -> suppress low-contrast mottling
k15 = np.ones((15,15), np.uint8)
lrange = cv2.dilate(v, k15) - cv2.erode(v, k15)
d[(lrange < 0.35) & (v > 0.6)] = 0
# thin horizontal strokes (e.g. bars of 'E', table rules) are faint in the source: boost them
if os.environ.get('BOOST','1') == '1':
    th = cv2.morphologyEx(v, cv2.MORPH_CLOSE, np.ones((7,1),np.uint8)) - v      # depth of thin horizontal dark features
    th2 = cv2.morphologyEx(v, cv2.MORPH_CLOSE, np.ones((1,7),np.uint8)) - v     # thin vertical features
    thin = np.maximum(th, th2)
    d_thin = np.clip((thin - 0.12)/(0.30 - 0.12), 0, 1) ** 0.7
    near_ink = cv2.dilate((d > 0.5).astype(np.uint8), np.ones((9,9),np.uint8)).astype(bool)
    d = np.where(near_ink & (lrange >= 0.35), np.maximum(d, d_thin), d)
d[~m] = 0
# despeckle
binm = (d > 0.4).astype(np.uint8)
n, lab, st, _ = cv2.connectedComponentsWithStats(binm, connectivity=8)
small = np.zeros(n, bool); small[1:] = st[1:, cv2.CC_STAT_AREA] < 25
d[small[lab]] = 0
# remove faint isolated blobs (texture): components whose max darkness < 0.75
mx = np.zeros(n); np.maximum.at(mx, lab[binm>0], d[binm>0])
faint = (mx < 0.45); faint[0] = False
d[faint[lab]] = 0
# ---- stamp: find disk, tint ink blue inside it (chroma-weighted) ----
gray8 = (255*(1-d)).astype(np.uint8)
s = cv2.GaussianBlur(cv2.resize(255-gray8, None, fx=0.25, fy=0.25, interpolation=cv2.INTER_AREA), (0,0), 1.5)
circles = cv2.HoughCircles(s, cv2.HOUGH_GRADIENT, dp=1, minDist=50, param1=80, param2=25, minRadius=45, maxRadius=80)
tint = np.zeros((H,W), np.float32)
c = nB - nR
w = (d > 0.2).astype(np.float32)
cs = cv2.GaussianBlur(c*w, (0,0), 4) / np.maximum(cv2.GaussianBlur(w, (0,0), 4), 1e-3)
if circles is not None:
    cx, cy, r = (circles[0][0]*4).astype(int); r = max(int(r*1.08)+20, 280)
    print('stamp disk at (%d,%d) r=%d' % (cx, cy, r))
    yy, xx = np.mgrid[0:H, 0:W]; dist = np.hypot(xx-cx, yy-cy)
    inside = dist < r
    t_in = np.clip((cs - 0.02)/(0.06-0.02), 0.45, 1.0)
    tint[inside] = t_in[inside]
    # outside: only strongly blue components (signature tail), decided per component
    binm = (d > 0.4).astype(np.uint8)
    n, lab, st, _ = cv2.connectedComponentsWithStats(binm, connectivity=8)
    sums = np.bincount(lab.ravel(), weights=(cs*binm).ravel(), minlength=n); cnt = np.bincount(lab.ravel(), weights=binm.ravel(), minlength=n)
    meanc = sums/np.maximum(cnt,1)
    near = np.zeros(n, bool); 
    # components that touch the disk neighbourhood (within 1.6 r)
    nearmask = (dist < 1.6*r)
    near_ids = np.unique(lab[nearmask & (binm>0)])
    near[near_ids] = True
    blue_comp = near & (meanc > 0.045) & (cnt > 150); blue_comp[0] = False
    tint = np.maximum(tint, np.where(blue_comp[lab] & ~inside, np.clip((meanc[lab]-0.03)/0.05, 0, 1), 0).astype(np.float32))
INK_BLUE = np.array([150, 60, 25], np.float32)   # BGR
inkcol = (1-tint[...,None])*np.zeros(3, np.float32) + tint[...,None]*INK_BLUE
out = 255 - d[...,None]*(255 - inkcol)
out = np.clip(out, 0, 255).astype(np.uint8)
out[~m] = 255
cv2.imwrite(os.path.join(OUTDIR,'page%d.png'%PAGE), out)
