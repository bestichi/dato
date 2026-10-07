"""Simulate how Facebook shows a 960x540 cover and check the safe zones.

usage: python3 fb_sim.py <variant_dir>
reads  <variant_dir>/cover-960x540.png (and logo-badge-1080.png if present)
writes <variant_dir>/sim_desktop.png  (what a 1250px-wide cover looks like on a 125%-scaled screen: 960 -> JPEG -> x1.627 stretch, 2.7:1 crop)
       <variant_dir>/sim_mobile.png   (phone mock: full 16:9 cover, big centred profile picture overlapping the bottom)
       <variant_dir>/sim_zones.png    (cover with the safe zones drawn on top)
"""
import io, os, sys
from PIL import Image, ImageDraw

d = sys.argv[1]
cov = Image.open(os.path.join(d, 'cover-960x540.png')).convert('RGB')
assert cov.size == (960, 540), f'cover must be 960x540, got {cov.size}'
b = io.BytesIO(); cov.save(b, 'JPEG', quality=90, subsampling=2)
served = Image.open(io.BytesIO(b.getvalue())).convert('RGB')

# desktop: 2.7:1 window (960x356) positioned at y=80 (measured on the real page), stretched to 1562px
desk = served.crop((0, 80, 960, 436)).resize((1562, 579), Image.BILINEAR)
desk.save(os.path.join(d, 'sim_desktop.png'))

# mobile: 390px phone width, DPR 3 -> render at 1170px wide
W = 1170; cw, ch = W, round(W * 540 / 960)
phone = Image.new('RGB', (W, ch + 900), (255, 255, 255))
phone.paste(served.resize((cw, ch), Image.BILINEAR), (0, 0))
pp_d = 528  # 176 css px * 3
badge_p = os.path.join(d, 'logo-badge-1080.png')
badge = Image.open(badge_p).convert('RGBA').resize((pp_d, pp_d), Image.LANCZOS) if os.path.exists(badge_p) else Image.new('RGBA', (pp_d, pp_d), (140, 198, 63, 255))
m = Image.new('L', (pp_d, pp_d), 0); ImageDraw.Draw(m).ellipse((0, 0, pp_d - 1, pp_d - 1), fill=255)
ring = Image.new('L', (pp_d + 24, pp_d + 24), 0); ImageDraw.Draw(ring).ellipse((0, 0, pp_d + 23, pp_d + 23), fill=255)
x0 = (W - pp_d) // 2; y0 = ch - pp_d // 2
phone.paste((255, 255, 255), (x0 - 12, y0 - 12), ring)
phone.paste(badge.convert('RGB'), (x0, y0), m)
phone.resize((W // 3, (ch + 900) // 3), Image.LANCZOS).save(os.path.join(d, 'sim_mobile.png'))

# zones on the 960x540 canvas
z = cov.copy().convert('RGBA'); ov = Image.new('RGBA', z.size, (0, 0, 0, 0)); g = ImageDraw.Draw(ov)
g.rectangle((0, 0, 959, 79), fill=(255, 59, 107, 90)); g.rectangle((0, 437, 959, 539), fill=(255, 59, 107, 90))   # cropped on desktop
g.rectangle((30, 95, 930, 425), outline=(59, 176, 255, 255), width=2)                                         # keep important things inside
r = 225; g.ellipse((480 - r, 540 - r + 30, 480 + r, 540 + r + 30), fill=(255, 200, 0, 90), outline=(255, 200, 0, 255), width=2)  # mobile profile picture
z = Image.alpha_composite(z, ov); z.convert('RGB').save(os.path.join(d, 'sim_zones.png'))
print('ok', d)
