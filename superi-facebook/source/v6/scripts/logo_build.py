"""Write the Superi.ge logo pack (outlined SVG sources; PNGs are rendered by make_logos.sh).

logo/logo-badge.svg                      1080 square, lime field, ink S. (Facebook crops it to a circle)
logo/logo-horizontal-on-dark.svg         lime disc + ink S., paper wordmark, lime full stop, transparent
logo/logo-horizontal-on-light.svg        lime disc + ink S., ink wordmark, lime full stop, transparent
logo/logo-symbol.svg / -lime.svg / -paper.svg   the S. symbol alone
work/fav/fav-{16,32,48,512}.svg          favicon masters (pixel-fitted S. per size)
"""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from logo import INK, LIME, PAPER, badge_svg, lockup, symbol_svg, svgdoc
from letters import s_shape, Shape
from geo import circle

D = '/tmp/claude-0/-home-user-dato/6fdbe81a-df64-5cba-80c4-f4ac98dc935c/scratchpad/v5/final'
os.makedirs(D + '/logo', exist_ok=True); os.makedirs(D + '/work/fav', exist_ok=True)

# 1) profile badge
BADGE_RATIO = 0.50
svg, box = badge_svg(1080, BADGE_RATIO)
open(D + '/logo/logo-badge.svg', 'w').write(svg)
print('badge S. box', [round(v) for v in box])

# 2) horizontal lockups (transparent). x-height 150 px -> 1690 px wide PNG at 1x
XH, P = 150, 60
for scheme, main in (('on-dark', PAPER), ('on-light', INK)):
    body, w, h = lockup(XH, P, P, main=main, dot=LIME)
    W, H = round(w + 2 * P), round(h + 2 * P)
    open(D + f'/logo/logo-horizontal-{scheme}.svg', 'w').write(svgdoc(W, H, body, f'Superi.ge logo ({scheme})'))
    print(scheme, W, H)

# 3) symbol alone
for name, col in (('', INK), ('-lime', LIME), ('-paper', PAPER)):
    g, tw = symbol_svg(12, 12, 100, fill=col)
    open(D + f'/logo/logo-symbol{name}.svg', 'w').write(svgdoc(tw + 24, 124, g, 'Superi.ge symbol'))


# 4) favicons: per-size integer metrics so bars and counters land on whole pixels
def fav_svg(n, W, H, w, gap, x0, y0, radius):
    s = s_shape(W, H, w, x0, y0)
    dot = Shape().add(circle(x0 + W + gap + w / 2, y0 + H - w / 2, w / 2))
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{n}" height="{n}" viewBox="0 0 {n} {n}">'
            f'<rect width="{n}" height="{n}" rx="{radius}" fill="{LIME}"/>'
            f'<path d="{s.d()}" fill="{INK}"/><path d="{dot.d()}" fill="{INK}"/></svg>\n')

FAV = {16: (9, 10, 2, 1, 2, 3, 3),         # W, H, stroke, gap, x0, y0, corner radius
       32: (18, 21, 5, 2, 4, 5, 6),
       48: (27, 29, 7, 3, 6, 9, 9),
       512: (270, 307, 74, 28, 70, 102, 96)}
for n, (W, H, w, gap, x0, y0, rr) in FAV.items():
    open(D + f'/work/fav/fav-{n}.svg', 'w').write(fav_svg(n, W, H, w, gap, x0, y0, rr))
    print('fav', n, 'S.', W + gap + w, 'x', H, 'stroke', w, 'counter', (H - 3 * w) / 2)
