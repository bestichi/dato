"""Build cover.html for the Superi.ge Facebook cover (960x540, ink, Swiss grid).

6-column grid: 48px margins, 124px columns, 24px gutters -> column lines x 48/196/344/492/640/788.
Products are Lanczos-resized to their exact on-canvas pixel size (assets/) and placed 1:1.
The logo lockup is inline outlined SVG (no fonts).  Georgian text uses NG (Noto Sans Georgian).
usage: python3 build_cover.py [cfg.json] [out.html]
"""
import os, sys, json
from PIL import Image
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from logo import lockup, PAPER, LIME, INK

D = '/tmp/claude-0/-home-user-dato/6fdbe81a-df64-5cba-80c4-f4ac98dc935c/scratchpad/v5/final'
K = '/tmp/claude-0/-home-user-dato/6fdbe81a-df64-5cba-80c4-f4ac98dc935c/scratchpad/v5/kit'
cfg_p = sys.argv[1] if len(sys.argv) > 1 else os.path.join(D, 'src', 'cover_cfg.json')
out_p = sys.argv[2] if len(sys.argv) > 2 else os.path.join(D, 'cover.html')
cfg = json.load(open(cfg_p))

M, G, NC = cfg['margin'], cfg['gutter'], 6
CW = round((960 - 2 * M - (NC - 1) * G) / NC)
colx = [M + i * (CW + G) for i in range(NC)]
os.makedirs(os.path.join(D, 'assets'), exist_ok=True)

# ---------- products (exact-size Lanczos, bottom on the rule, flush-left on the column line)
prod, caps = [], []
for i, p in enumerate(cfg['products']):
    src = Image.open(os.path.join(D, 'prod_src', p['src'])).convert('RGBA')
    bw, bh = p.get('box', cfg['box'])
    k = min(bw / src.width, bh / src.height) * p.get('scale', 1.0)
    w, h = max(1, round(src.width * k)), max(1, round(src.height * k))
    fn = f"assets/p{i+1}_{os.path.splitext(p['src'])[0]}_{w}x{h}.png"
    src.resize((w, h), Image.LANCZOS).save(os.path.join(D, fn))
    x = colx[p['col']] + p.get('dx', 0)
    y = cfg['baseline'] - h + p.get('dy', 0)
    prod.append(f'<img class="abs" src="{D}/{fn}" width="{w}" height="{h}" style="left:{x}px;top:{y}px" alt="">')
    caps.append(f'<div class="cap abs" style="left:{colx[p["col"]]}px;top:{cfg["cap_y"]}px">{p["label"]}</div>')
    print(f'{p["src"]:20s} x={x} y={y} {w}x{h}')

# ---------- logo lockup (outlined SVG)
L = cfg['logo']
svg_in, lw, lh = lockup(L['xh'], 0, 0, main=PAPER, dot=LIME, glyph=L['glyph'], glyph_dx=L['glyph_dx'])
pad = 4
logo = (f'<svg class="abs" style="left:{L["x"]-pad}px;top:{L["y"]-pad}px" width="{lw+2*pad:.0f}" height="{lh+2*pad:.0f}" '
        f'viewBox="{-pad} {-pad} {lw+2*pad:.0f} {lh+2*pad:.0f}">{svg_in}</svg>')
print('lockup', round(lw, 1), 'x', round(lh, 1))

rules = ''.join(f'<div class="abs" style="left:{r[0]}px;top:{r[1]}px;width:{r[2]}px;height:{r[3]}px;background:{r[4]}"></div>'
                for r in cfg.get('rules', []))

# ---------- tagline + meta share one last baseline (grid, align-items:last baseline)
T, Mt = cfg['tag'], cfg.get('meta')
mcol = (colx[Mt['col']] - T['x']) if Mt else 0
bottom = (f'<div class="abs botrow" style="left:{T["x"]}px;top:{T["y"]}px;grid-template-columns:{mcol}px auto">'
          f'<div class="tag" style="font-size:{T["size"]}px;line-height:{T["lh"]}px">{T["html"]}</div>'
          + (f'<div class="meta" style="font-size:{Mt["size"]}px">{Mt["html"]}</div>' if Mt else '') + '</div>')

html = f'''<!doctype html><html lang="ka"><head><meta charset="utf-8"><title>Superi.ge cover</title>
<link rel="stylesheet" href="{K}/base.css">
<style>
body{{background:var(--ink);color:var(--paper)}}
.cap{{font-family:"NG";font-weight:{cfg["cap_weight"]};font-size:{cfg["cap_size"]}px;line-height:1;color:var(--paper);white-space:nowrap}}
.botrow{{display:grid;align-items:last baseline}}
.tag{{font-family:"NG";font-weight:600;color:var(--paper);white-space:nowrap}}
.meta{{font-family:"NG";font-weight:500;color:var(--paper);white-space:nowrap;line-height:1.25}}
.bdot{{display:inline-block;width:5px;height:5px;border-radius:50%;background:var(--lime);margin-left:3px;vertical-align:baseline}}
</style></head><body>
{rules}
{logo}
{''.join(prod)}
{''.join(caps)}
{bottom}
</body></html>'''
open(out_p, 'w').write(html)
print('cols', colx, 'CW', CW, '->', out_p)
