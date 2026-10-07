import sys, numpy as np
from PIL import Image
import scipy.ndimage as nd
src, out_path = sys.argv[1], sys.argv[2]
im=np.asarray(Image.open(src).convert('RGB')).astype(np.float32)
H,W,_=im.shape
L=im.mean(axis=2); mx=im.max(axis=2); mn=im.min(axis=2); sat=(mx-mn)/np.maximum(mx,1)
boxes=[(105,50,520,170),(105,180,905,450),(110,478,900,630)]   # logo, headline, icon row
inbox=np.zeros((H,W),bool)
for x0,y0,x1,y1 in boxes: inbox[y0:y1,x0:x1]=True
fg=inbox&((L<215)|(sat>0.10))
def nconv(img,known,sig,ret_w=False):
    w=nd.gaussian_filter(known.astype(np.float32),sig)
    o=np.stack([nd.gaussian_filter(img[...,c]*known,sig) for c in range(3)],-1)
    o=o/np.maximum(w[...,None],1e-6)
    return (o,w) if ret_w else o
bg0=nconv(im,~fg,18)
diff=np.abs(im-bg0).sum(axis=2)
mask=nd.binary_dilation(inbox&((diff>7)|fg),iterations=3)
out=im.copy(); known=~mask
# coarse fill: grow the known region outward until every masked pixel is covered
filled=known.copy()
for sig in (6,12,24,48,96):
    est,w=nconv(out,filled,sig,True)
    upd=mask&~filled&(w>0.02)
    out[upd]=est[upd]; filled=filled|upd
# refine: re-estimate masked pixels from true background only, keeping coarse values where support is weak
for sig in (30,15):
    est,w=nconv(out,known,sig,True)
    a=np.clip((w-0.02)/0.2,0,1)[...,None]
    out[mask]=(est*a+out*(1-a))[mask]
sm=np.stack([nd.gaussian_filter(out[...,c],1.2) for c in range(3)],-1)
m3=nd.gaussian_filter(mask.astype(np.float32),1.5)[...,None]
out=out*(1-m3)+sm*m3
rng=np.random.default_rng(3); out[mask]+=rng.normal(0,0.8,(int(mask.sum()),3))
Image.fromarray(np.clip(out,0,255).astype(np.uint8)).save(out_path)
print('masked px', int(mask.sum()))
