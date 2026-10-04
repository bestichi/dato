"""Cut a product photo out of its plain (white or light) background -> transparent PNG.

Usage: python3 cutout.py input.jpg output.png [--tol 18] [--holes 400] [--max 900]

--tol    how far (0-255) a pixel may differ from the background colour and still count as background
--holes  also clear enclosed background-coloured areas larger than this many pixels
         (e.g. the gap inside a scooter frame); 0 = off
--max    longest side of the saved image
Requires: pip install pillow numpy scipy
"""
import argparse

import numpy as np
from PIL import Image
from scipy import ndimage

ap = argparse.ArgumentParser()
ap.add_argument('src')
ap.add_argument('dst')
ap.add_argument('--tol', type=float, default=18)
ap.add_argument('--holes', type=int, default=0)
ap.add_argument('--max', type=int, default=900)
a = ap.parse_args()

im = Image.open(a.src).convert('RGBA')
rgba = np.asarray(im).astype(np.float32)
rgb, alpha_in = rgba[..., :3], rgba[..., 3]

if alpha_in.min() < 255:
    # already transparent: only trim
    alpha = alpha_in
else:
    border = np.concatenate([rgb[:3].reshape(-1, 3), rgb[-3:].reshape(-1, 3),
                             rgb[:, :3].reshape(-1, 3), rgb[:, -3:].reshape(-1, 3)])
    bg = np.median(border, axis=0)
    dist = np.abs(rgb - bg).max(axis=2)

    cand = dist < a.tol
    labels, _ = ndimage.label(cand, structure=np.ones((3, 3)))
    edge = np.unique(np.concatenate([labels[0], labels[-1], labels[:, 0], labels[:, -1]]))
    bgmask = np.isin(labels, edge[edge > 0])
    if a.holes:
        sizes = np.bincount(labels.ravel())
        big = np.nonzero(sizes > a.holes)[0]
        bgmask |= np.isin(labels, big[big > 0])

    # soft, decontaminated edge on the foreground pixels touching the background
    band = ndimage.binary_dilation(bgmask, iterations=2) & ~bgmask
    alpha = np.where(bgmask, 0.0, 255.0)
    lo, hi = a.tol * 0.6, 90.0
    ab = np.clip((dist - lo) / (hi - lo), 0, 1)
    alpha[band] = ab[band] * 255
    k = np.where(band, np.maximum(ab, 1e-3), 1.0)[..., None]
    rgb = np.clip(bg + (rgb - bg) / k, 0, 255)

out = Image.fromarray(np.dstack([rgb, alpha]).astype(np.uint8), 'RGBA')
box = Image.fromarray((alpha > 10).astype(np.uint8) * 255).getbbox()
out = out.crop(box)
out.thumbnail((a.max, a.max), Image.LANCZOS)
out.save(a.dst, optimize=True)
print(a.dst, out.size)
