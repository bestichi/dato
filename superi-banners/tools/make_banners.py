#!/usr/bin/env python3
"""Alta-style subcategory banners for superi.ge.

Style (keep it identical for every category):
  * 800x800 PNG, lavender card #F2EEFB with rounded corners (radius 8%), transparent outside
  * product cut out of its photo (BiRefNet) and scaled to the maximum box: 92% wide, 90% tall, centered
  * soft lavender contact shadow under the product
  * no text: the site prints the subcategory name under the image

usage:
  python3 make_banners.py ../<category>/banners.json [--only SUBSTR ...]

banners.json:
  {"category_url": "https://superi.ge/<category>/",
   "items": [{"file": "01-name", "label": "...", "url": "https://superi.ge/<sub>/",
              "src": "https://superi.ge/images/detailed/...", "sr": false}]}
  "sr": true runs 2x EDSR super-resolution first (for photos where the product is under ~700px).
  Optional per item: "scale" (<1 shrinks the product), "dy" (vertical offset, px),
  "solid": true (fill the whole outline, for products whose body is nearly the background colour).
  "src" may also be a file next to banners.json; a PNG with transparency is used as its own mask.
  Several products in one banner: replace "src"/"sr" with "parts", drawn back to front:
    "parts": [{"src": "...", "sr": false, "h": 1.0, "x": 0.0, "y": 0.0}, ...]
  h = height, x = horizontal centre, y = bottom above the floor; all in units of the same length.

Downloads, models and masks are cached in $SUPERI_CACHE (default ~/.cache/superi-banners).
"""
import argparse
import json
import os
import subprocess
import sys
import urllib.parse
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFilter

S = 800
RADIUS = 0.08
BG = (242, 238, 251)
MAX_W, MAX_H = 0.92, 0.90
SHADOW_RGB, SHADOW_ALPHA = (92, 74, 140), 0.16
SEG_PAD = 0.12   # white margin added around the photo before segmentation (keeps edge-touching products whole)

BASE = Path('.')   # folder of the banners.json being rendered
CACHE = Path(os.environ.get('SUPERI_CACHE', Path.home() / '.cache' / 'superi-banners'))
MODELS = {
    'birefnet': 'https://github.com/danielgatis/rembg/releases/download/v0.0.0/BiRefNet-general-epoch_244.onnx',
    'edsr': 'https://raw.githubusercontent.com/Saafke/EDSR_Tensorflow/master/models/EDSR_x2.pb',
}
UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Safari/537.36'


def fetch(url, dest):
    dest.parent.mkdir(parents=True, exist_ok=True)
    url = urllib.parse.quote(url, safe=':/?&=%,')
    subprocess.run(['curl', '-sS', '-fL', '--retry', '3', '-A', UA, '-o', str(dest), url], check=True)


def model(key):
    path = CACHE / 'models' / Path(MODELS[key]).name
    if not path.exists():
        print(f'downloading model {path.name} ...', flush=True)
        fetch(MODELS[key], path)
    return path


def load_rgb(path):
    im = Image.open(path)
    if im.mode in ('RGBA', 'LA', 'P'):
        im = im.convert('RGBA')
        bg = Image.new('RGBA', im.size, (255, 255, 255, 255))
        bg.alpha_composite(im)
        im = bg
    return im.convert('RGB')


def super_res(src, dst):
    import cv2  # opencv-contrib-python-headless
    sr = cv2.dnn_superres.DnnSuperResImpl_create()
    sr.readModel(str(model('edsr')))
    sr.setModel('edsr', 2)
    bgr = cv2.cvtColor(np.asarray(load_rgb(src)), cv2.COLOR_RGB2BGR)
    cv2.imwrite(str(dst), sr.upsample(bgr))


def mask_worker(src, dst):
    """Soft alpha mask with BiRefNet (runs in its own process: onnxruntime keeps memory otherwise)."""
    import onnxruntime as ort
    so = ort.SessionOptions()
    so.enable_cpu_mem_arena = False
    so.enable_mem_pattern = False
    sess = ort.InferenceSession(str(model('birefnet')), sess_options=so, providers=['CPUExecutionProvider'])
    im = load_rgb(src)
    side = int(max(im.size) * (1 + 2 * SEG_PAD))
    canvas = Image.new('RGB', (side, side), (255, 255, 255))
    ox, oy = (side - im.width) // 2, (side - im.height) // 2
    canvas.paste(im, (ox, oy))
    x = np.asarray(canvas.resize((1024, 1024), Image.Resampling.LANCZOS), dtype=np.float32) / 255.0
    x = (x - np.array((0.485, 0.456, 0.406), np.float32)) / np.array((0.229, 0.224, 0.225), np.float32)
    out = sess.run(None, {sess.get_inputs()[0].name: x.transpose(2, 0, 1)[None].astype(np.float32)})[0]
    pred = 1 / (1 + np.exp(-np.squeeze(out[:, 0])))
    pred = (pred - pred.min()) / (pred.max() - pred.min() + 1e-8)
    m = Image.fromarray((pred * 255).astype('uint8'), 'L').resize((side, side), Image.Resampling.LANCZOS)
    m.crop((ox, oy, ox + im.width, oy + im.height)).save(dst)


def solid_fill(rgb, a):
    """Fill the product's outline completely: convex hull of the mask plus every pixel that is not background-white.
    For appliances whose body is nearly the colour of the photo background (cream hob, white panels)."""
    import cv2
    pts = np.argwhere((a > 0.5) | (np.abs(rgb - 255.0).sum(axis=2) > 24))[:, ::-1].astype(np.int32)
    ss = 4
    hull = cv2.convexHull(pts * ss + ss // 2)
    big = np.zeros((a.shape[0] * ss, a.shape[1] * ss), np.uint8)
    cv2.fillConvexPoly(big, hull, 255, lineType=cv2.LINE_AA)
    filled = np.asarray(Image.fromarray(big).resize((a.shape[1], a.shape[0]), Image.Resampling.LANCZOS), dtype=np.float32) / 255.0
    return np.maximum(a, filled)


def cutout(src, mask_path, solid=False):
    rgb = np.asarray(load_rgb(src), dtype=np.float32)
    a = np.asarray(Image.open(mask_path), dtype=np.float32) / 255.0
    a = np.clip((a - 0.04) / 0.92, 0, 1)                      # drop faint haze, keep soft edges
    if solid:
        a = solid_fill(rgb, a)
    am = np.maximum(a, 1e-3)[..., None]
    fg = (rgb - (1 - am) * 255.0) / am                         # remove the white background from edge pixels
    fg = np.where(a[..., None] > 0.02, np.clip(fg, 0, 255), rgb)
    im = Image.fromarray(np.dstack([fg, a * 255.0]).astype(np.uint8), 'RGBA')
    ys, xs = np.where(a > 0.08)
    return im.crop((xs.min(), ys.min(), xs.max() + 1, ys.max() + 1))


def resize_premultiplied(im, w, h):
    a = np.asarray(im, dtype=np.float32) / 255.0
    pm = np.dstack([a[..., :3] * a[..., 3:4], a[..., 3:4]])
    ch = [np.asarray(Image.fromarray((pm[..., i] * 255).round().astype(np.uint8), 'L')
                     .resize((w, h), Image.Resampling.LANCZOS), dtype=np.float32) / 255.0 for i in range(4)]
    pm2 = np.dstack(ch)
    al = pm2[..., 3:4]
    rgb = np.where(al > 1e-4, pm2[..., :3] / np.maximum(al, 1e-4), 0)
    return Image.fromarray(np.dstack([np.clip(rgb, 0, 1) * 255, al * 255]).round().astype(np.uint8), 'RGBA')


def render(prod, out_path, scale=1.0, dy=0):
    w, h = prod.size
    k = min(MAX_W * S / w, MAX_H * S / h) * scale
    nw, nh = max(1, round(w * k)), max(1, round(h * k))
    prod = resize_premultiplied(prod, nw, nh)
    x, y = (S - nw) // 2, (S - nh) // 2 + dy
    card = Image.new('RGBA', (S, S), BG + (255,))

    # soft contact shadow under the product's footprint
    a = np.asarray(prod.split()[3], dtype=np.float32) / 255.0
    bottom = np.where(a.max(axis=1) > 0.5)[0].max()
    cols = np.where(a[max(0, bottom - int(nh * 0.06)):bottom + 1].max(axis=0) > 0.5)[0]
    fw = float(cols.max() - cols.min()) if len(cols) else nw * 0.6
    cx = x + ((cols.min() + cols.max()) / 2 if len(cols) else nw / 2)
    ew, eh = fw * 1.04, max(10.0, fw * 0.075)
    cy = y + bottom - eh * 0.15
    sh = Image.new('L', (S, S), 0)
    ImageDraw.Draw(sh).ellipse((cx - ew / 2, cy - eh / 2, cx + ew / 2, cy + eh / 2), fill=255)
    sh = sh.filter(ImageFilter.GaussianBlur(float(eh * 0.55)))
    shadow = Image.new('RGBA', (S, S), SHADOW_RGB + (0,))
    shadow.putalpha(sh.point(lambda v: int(v * SHADOW_ALPHA)))
    card.alpha_composite(shadow)

    card.alpha_composite(prod, (x, y))
    corners = Image.new('L', (S * 4, S * 4), 0)
    ImageDraw.Draw(corners).rounded_rectangle((0, 0, S * 4 - 1, S * 4 - 1), round(S * RADIUS) * 4, fill=255)
    card.putalpha(corners.resize((S, S), Image.Resampling.LANCZOS))
    card.save(out_path, optimize=True)
    return nw, nh, k


def prepare(url, sr, work):
    """Download (+ optional super-resolution) and segment one photo; returns (photo, mask) paths."""
    work.mkdir(parents=True, exist_ok=True)
    if not url.startswith('http'):
        # local file next to banners.json, e.g. a studio render with a transparent background
        src = (BASE / url).resolve()
        im = Image.open(src)
        if im.mode in ('RGBA', 'LA') and im.getextrema()[-1][0] < 255:
            mask = work / 'mask.png'
            im.getchannel('A').save(mask)
            return src, mask
    else:
        # the cache folder is per banner: if its photo URL changed, drop the old photo, upscale and mask
        stamp = work / 'source.txt'
        key = f'{url}\nsr={bool(sr)}'
        if not stamp.exists() or stamp.read_text() != key:
            for old in work.iterdir():
                old.unlink()
            stamp.write_text(key)
        src = work / ('src' + (Path(urllib.parse.urlparse(url).path).suffix or '.img'))
        if not src.exists():
            fetch(url, src)
    if sr:
        up = work / 'sr.png'
        if not up.exists():
            print(f'  super-resolution {work.name} ...', flush=True)
            super_res(src, up)
        src = up
    mask = work / 'mask.png'
    if not mask.exists():
        print(f'  segmentation {work.name} ...', flush=True)
        subprocess.run([sys.executable, __file__, '--mask-worker', str(src), str(mask)], check=True)
    return src, mask


def compose_group(parts, unit=1000):
    """Arrange several cut-outs on one floor; later parts are in front and cast a soft shadow on earlier ones."""
    import hashlib
    placed = []
    for pt in parts:
        key = hashlib.sha1((pt['src'] + ('#sr' if pt.get('sr') else '')).encode()).hexdigest()[:16]
        cut = cutout(*prepare(pt['src'], pt.get('sr', False), CACHE / 'work' / '_parts' / key))
        h = round(pt['h'] * unit)
        w = round(cut.width * h / cut.height)
        placed.append((resize_premultiplied(cut, w, h), round(pt.get('x', 0) * unit - w / 2), round(-pt.get('y', 0) * unit - h)))
    x0 = min(x for _, x, _ in placed) - 60
    y0 = min(y for _, _, y in placed) - 60
    x1 = max(x + im.width for im, x, _ in placed) + 60
    y1 = max(y + im.height for im, _, y in placed) + 60
    canvas = Image.new('RGBA', (x1 - x0, y1 - y0), (0, 0, 0, 0))
    for i, (im, x, y) in enumerate(placed):
        if i:
            sh = Image.new('RGBA', canvas.size, (40, 30, 70, 0))
            a = Image.new('L', canvas.size, 0)
            a.paste(im.split()[3].point(lambda v: int(v * 0.22)), (x - x0 - 6, y - y0 + 8))
            sh.putalpha(a.filter(ImageFilter.GaussianBlur(14)))
            canvas.alpha_composite(sh)
        canvas.alpha_composite(im, (x - x0, y - y0))
    al = np.asarray(canvas.split()[3])
    ys, xs = np.where(al > 20)
    return canvas.crop((xs.min(), ys.min(), xs.max() + 1, ys.max() + 1))


def main():
    if len(sys.argv) == 4 and sys.argv[1] == '--mask-worker':
        return mask_worker(sys.argv[2], sys.argv[3])
    ap = argparse.ArgumentParser()
    ap.add_argument('config')
    ap.add_argument('--only', nargs='*', default=[])
    args = ap.parse_args()
    cfg_path = Path(args.config).resolve()
    cfg = json.loads(cfg_path.read_text(encoding='utf-8'))
    out_dir = cfg_path.parent
    global BASE
    BASE = out_dir
    for it in cfg['items']:
        name = it['file']
        if args.only and not any(o in name for o in args.only):
            continue
        if 'parts' in it:
            prod = compose_group(it['parts'])
        else:
            prod = cutout(*prepare(it['src'], it.get('sr', False), CACHE / 'work' / out_dir.name / name), it.get('solid', False))
        nw, nh, k = render(prod, out_dir / f'{name}.png', it.get('scale', 1.0), it.get('dy', 0))
        print(f'{name}.png  product {nw}x{nh}px  source x{k:.2f}' + ('  (upscaled, consider "sr": true)' if k > 1.05 else ''),
              flush=True)


if __name__ == '__main__':
    main()
