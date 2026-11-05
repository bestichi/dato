import cv2, numpy as np, sys, os
np.set_printoptions(suppress=True, precision=3)
IMG, PAGE, OUTDIR = sys.argv[1], int(sys.argv[2]), sys.argv[3]
os.makedirs(OUTDIR, exist_ok=True)
DPI = 300; MM = DPI/25.4
A4W, A4H = int(round(210*MM)), int(round(297*MM))
TEXT_W_MM = 167.0      # checkbox column (left edge) .. right text margin
LEFT_MM = 23.0         # checkbox column left edge from paper left
TOP_MM = {1: 20.0, 2: 24.0}[PAGE]

src = cv2.imread(IMG); H0, W0 = src.shape[:2]

# ---- paper mask (green), largest component, holes filled, eroded ----
hsv = cv2.cvtColor(src, cv2.COLOR_BGR2HSV); h,s,v = cv2.split(hsv)
pm = ((h>30)&(h<95)&(s>50)&(v>40)).astype(np.uint8)*255
pm = cv2.morphologyEx(pm, cv2.MORPH_CLOSE, np.ones((15,15),np.uint8))
n, lab, st, _ = cv2.connectedComponentsWithStats(pm)
pm = (lab == 1+np.argmax(st[1:,cv2.CC_STAT_AREA])).astype(np.uint8)*255
ff = pm.copy(); mask = np.zeros((H0+2,W0+2),np.uint8); cv2.floodFill(ff, mask, (0,0), 255)
# pixels not reached by flood from (0,0) that are 0 are holes -> fill
holes = (ff==0); pm[holes]=255
if pm[0,0]==255:  # corner was paper: flood from each corner that is background
    pass
paper = pm
valid = cv2.erode(paper, np.ones((21,21),np.uint8))
cv2.imwrite(os.path.join(OUTDIR,'paper%d.png'%PAGE), paper)

def ink_mask(bgr, vmask, thr=200):
    g = cv2.cvtColor(bgr, cv2.COLOR_BGR2GRAY)
    bg = cv2.medianBlur(g, 51)
    norm = np.clip(g.astype(np.float32)/np.maximum(bg,1)*255, 0, 255).astype(np.uint8)
    m = (norm < thr).astype(np.uint8)*255
    m[vmask==0] = 0
    return m

# ---- step 1: rotation from horizontal rules ----
ink = ink_mask(src, valid)
inkd = cv2.dilate(ink, np.ones((3,1),np.uint8))
hor = cv2.morphologyEx(inkd, cv2.MORPH_OPEN, cv2.getStructuringElement(cv2.MORPH_RECT,(60,1)))
hor = cv2.dilate(hor, np.ones((5,15),np.uint8))
n, lab, st, cen = cv2.connectedComponentsWithStats(hor)
slopes = []
for i in range(1, n):
    x,y,w,hh,a = st[i]
    if w < 250: continue
    ys, xs = np.where((lab==i)&(ink>0))
    if len(xs) < 50: continue
    k,b = np.polyfit(xs, ys, 1); slopes.append((w, k))
slopes = np.array(slopes)
k_mean = np.average(slopes[:,1], weights=slopes[:,0])
ang = np.degrees(np.arctan(k_mean))
print('rules:', len(slopes), 'mean angle %.2f deg (std %.2f)' % (ang, np.degrees(np.arctan(slopes[:,1])).std()))
R = cv2.getRotationMatrix2D((W0/2, H0/2), ang, 1.0)
R3 = np.vstack([R, [0,0,1]])
rot = cv2.warpAffine(src, R, (W0, H0), flags=cv2.INTER_LINEAR)
valid_r = cv2.warpAffine(valid, R, (W0, H0), flags=cv2.INTER_NEAREST)

# ---- step 2: keystone from checkbox column (left) and justified right margin ----
ink_r = ink_mask(rot, valid_r)
# checkboxes: hollow or filled squares in left 25%
n, lab, st, cen = cv2.connectedComponentsWithStats(ink_r)
cb = []
for i in range(1,n):
    x,y,w,hh,a = st[i]
    if not (11<=w<=28 and 11<=hh<=28 and abs(w-hh)<=5 and x < W0*0.25): continue
    m = (lab[y:y+hh, x:x+w]==i)
    top=m[:2].mean(); bot=m[-2:].mean(); lef=m[:,:2].mean(); rig=m[:,-2:].mean()
    inner=m[4:-4,4:-4].mean() if w>8 and hh>8 else 1
    if min(top,bot,lef,rig) >= 0.55 and (inner <= 0.2 or inner >= 0.85):
        cb.append((x, y+hh/2))
cb = np.array(cb)
def ransac_line(pts, thr, iters=400):
    # pts: (t, x) fit x = a + b*t ; returns a,b,inliers
    rng = np.random.default_rng(0); best=None
    for _ in range(iters):
        i,j = rng.choice(len(pts), 2, replace=False)
        if abs(pts[i,0]-pts[j,0]) < 50: continue
        b = (pts[j,1]-pts[i,1])/(pts[j,0]-pts[i,0]); a = pts[i,1]-b*pts[i,0]
        res = np.abs(pts[:,1]-(a+b*pts[:,0])); inl = res < thr
        score = inl.sum() + 0.001*(pts[inl,0].max()-pts[inl,0].min())
        if best is None or score > best[0]: best=(score, inl)
    inl = best[1]; b,a = np.polyfit(pts[inl,0], pts[inl,1], 1)
    return a, b, pts[inl]
aL, bL, sel = ransac_line(cb[:,[1,0]], 3.5)
print('checkbox column: %d/%d boxes, x=%.1f+%.4f*y (%.2f deg), y range %d..%d' % (len(sel), len(cb), aL, bL, np.degrees(np.arctan(bL)), sel[:,0].min(), sel[:,0].max()))
# text lines (stricter ink, specks removed)
ink_t = ink_mask(rot, valid_r, thr=165)
ink_t = cv2.morphologyEx(ink_t, cv2.MORPH_OPEN, np.ones((2,2),np.uint8))
prof = (ink_t > 0).sum(axis=1); rows = prof > 4
bands=[]; y=0
while y < H0:
    if rows[y]:
        y0=y
        while y<H0 and rows[y]: y+=1
        if 5 <= y-y0 <= 60: bands.append((y0,y))
    else: y+=1
Rr=[]; wide=[]
for y0,y1 in bands:
    cols = (ink_t[y0:y1]>0).sum(axis=0); xs = np.where(cols>=2)[0]
    if len(xs)==0: continue
    if xs.max()-xs.min() > 0.3*W0: wide.append((y0,y1))
    Rr.append(((y0+y1)/2, xs.max()))
Rr=np.array(Rr); Rr = Rr[Rr[:,1] > W0*0.6]
aR, bR, sel = ransac_line(Rr, 6)
print('right margin: %d/%d lines, x=%.1f+%.4f*y (%.2f deg), y range %d..%d' % (len(sel), len(Rr), aR, bR, np.degrees(np.arctan(bR)), sel[:,0].min(), sel[:,0].max()))
yt, yb = wide[0][0], wide[-1][1]
print('text bands: %d (wide %d), y %d..%d' % (len(bands), len(wide), yt, yb))
TL=(aL+bL*yt, yt); TR=(aR+bR*yt, yt); BL=(aL+bL*yb, yb); BR=(aR+bR*yb, yb)
wt=TR[0]-TL[0]; wb=BR[0]-BL[0]; w=(wt+wb)/2
print('block width top %.1f bottom %.1f' % (wt, wb))
xc=(TL[0]+TR[0]+BL[0]+BR[0])/4
K = cv2.getPerspectiveTransform(np.float32([TL,TR,BL,BR]), np.float32([[xc-w/2,yt],[xc+w/2,yt],[xc-w/2,yb],[xc+w/2,yb]]))
Hk = K @ R3
pxmm = w/TEXT_W_MM; S = MM/pxmm
A = np.array([[S,0,LEFT_MM*MM - S*(xc-w/2)],[0,S,TOP_MM*MM - S*yt],[0,0,1]])
Hf = A @ Hk
print('source %.2f px/mm (%.0f dpi), upscale x%.2f' % (pxmm, pxmm*25.4, S))
page = cv2.warpPerspective(src, Hf, (A4W,A4H), flags=cv2.INTER_CUBIC)
vmask = cv2.warpPerspective(paper, Hf, (A4W,A4H), flags=cv2.INTER_NEAREST)
np.save(os.path.join(OUTDIR,'H%d.npy'%PAGE), Hf)
cv2.imwrite(os.path.join(OUTDIR,'rect%d.png'%PAGE), page)
cv2.imwrite(os.path.join(OUTDIR,'vmask%d.png'%PAGE), vmask)
dbg = rot.copy()
for (x,yc) in cb: cv2.circle(dbg,(int(x),int(yc)),5,(0,0,255),-1)
for (yc,x) in Rr: cv2.circle(dbg,(int(x),int(yc)),4,(255,0,0),-1)
cv2.line(dbg,(int(aL),0),(int(aL+bL*H0),H0),(0,255,255),2)
cv2.line(dbg,(int(aR),0),(int(aR+bR*H0),H0),(0,255,255),2)
cv2.imwrite(os.path.join(OUTDIR,'dbg%d.jpg'%PAGE), cv2.resize(dbg,None,fx=0.6,fy=0.6))
