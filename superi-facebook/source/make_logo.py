"""Build the Superi.ge logo pack as outlined SVGs (no font dependency).

Geometry is measured from the approved profile render (720px canvas):
S glyph box x152-496 / y185-523, dot 84px at x503 / y427.
"""
import os, sys
from fontTools.ttLib import TTFont
from fontTools.varLib import instancer
from fontTools.pens.svgPathPen import SVGPathPen
from fontTools.pens.boundsPen import BoundsPen
from fontTools.pens.transformPen import TransformPen

B = os.path.dirname(os.path.abspath(__file__))
OUT = sys.argv[1]
os.makedirs(OUT, exist_ok=True)

INK, LIME, PAPER = "#0E1110", "#8CC63F", "#F2F3EE"


def load(wght):
    f = TTFont(f"{B}/assets/unb.woff2")
    return instancer.instantiateVariableFont(f, {"wght": wght})


F900, F800, F700 = load(900), load(800), load(700)


def glyph_path(font, ch, k, dx, dy):
    """Path for one char, scaled by k, origin (baseline-left) at dx,dy, y flipped."""
    gs = font.getGlyphSet()
    name = font.getBestCmap()[ord(ch)]
    pen = SVGPathPen(gs)
    gs[name].draw(TransformPen(pen, (k, 0, 0, -k, dx, dy)))
    return pen.getCommands(), gs[name].width * k


def bounds(font, ch):
    gs = font.getGlyphSet()
    name = font.getBestCmap()[ord(ch)]
    bp = BoundsPen(gs)
    gs[name].draw(bp)
    return bp.bounds  # xMin, yMin, xMax, yMax (font units)


def text_run(font, s, k, x, baseline, tracking_em=0.0):
    upm = font["head"].unitsPerEm
    d, cur = [], x
    for i, ch in enumerate(s):
        p, adv = glyph_path(font, ch, k, cur, baseline)
        d.append(p)
        cur += adv + (tracking_em * upm * k if i < len(s) - 1 else 0)
    return " ".join(d), cur


def run_bounds(font, s, k, tracking_em=0.0):
    """Visual x-extent and y-extent (font units * k) of a text run starting at 0."""
    upm = font["head"].unitsPerEm
    gs = font.getGlyphSet()
    cmap = font.getBestCmap()
    cur, xs, ys = 0, [], []
    for i, ch in enumerate(s):
        b = bounds(font, ch)
        xs += [cur + b[0] * k, cur + b[2] * k]
        ys += [b[1] * k, b[3] * k]
        cur += gs[cmap[ord(ch)]].width * k + (tracking_em * upm * k if i < len(s) - 1 else 0)
    return min(xs), max(xs), min(ys), max(ys)


# ---------- mark: "S." ----------
# reference (720 canvas): S box w345 h338 at (152,185); dot d84 at (503,427)
def mark_group(cx, cy, size, s_fill, dot_fill):
    """S + dot whose combined box is centred on (cx, cy); size = S box height."""
    sx0, sy0, sx1, sy1 = bounds(F900, "S")
    k = size / (sy1 - sy0)
    sw = (sx1 - sx0) * k
    gap = (503 - 497) / 338 * size
    dot = 84 / 338 * size
    total_w = sw + gap + dot
    # reference group centre sits at x=369.5,y=354 on a 360 canvas centre -> keep same optical offset
    off_x = (152 + 586) / 2 - 360
    off_y = (185 + 523) / 2 - 360
    left = cx - total_w / 2 + off_x / 338 * size
    top = cy - size / 2 + off_y / 338 * size
    baseline = top + sy1 * k  # yMax maps to top
    p, _ = glyph_path(F900, "S", k, left - sx0 * k, baseline)
    dot_top = top + (427 - 185) / 338 * size
    dot_cx = left + sw + gap + dot / 2
    return (f'<path d="{p}" fill="{s_fill}"/>'
            f'<circle cx="{dot_cx:.2f}" cy="{dot_top + dot / 2:.2f}" r="{dot / 2:.2f}" fill="{dot_fill}"/>')


def svg(w, h, body, bg=None):
    rect = f'<rect width="{w}" height="{h}" fill="{bg}"/>' if bg else ""
    return f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}" width="{w}" height="{h}">{rect}{body}</svg>\n'


def write(name, content):
    open(f"{OUT}/{name}", "w").write(content)


S_REF = 338 / 720  # S height relative to canvas in the approved profile picture

# 1) profile picture (square, full-bleed lime; Facebook crops it to a circle)
write("superi-profile-lime.svg", svg(1000, 1000, mark_group(500, 500, S_REF * 1000, INK, INK), LIME))
write("superi-profile-dark.svg", svg(1000, 1000, mark_group(500, 500, S_REF * 1000, PAPER, LIME), INK))
# 2) round badge on transparent
write("superi-badge.svg", svg(1000, 1000, f'<circle cx="500" cy="500" r="500" fill="{LIME}"/>' + mark_group(500, 500, S_REF * 1000, INK, INK)))
# 3) bare mark on transparent (for dark and light backgrounds)
def bare(s_fill, dot_fill):
    sx0, sy0, sx1, sy1 = bounds(F900, "S")
    size = 800
    k = size / (sy1 - sy0)
    w = (sx1 - sx0) * k + (6 / 338 + 84 / 338) * size
    pad = 40
    W, H = w + 2 * pad, size + 2 * pad
    # centre group: undo the optical offset used for the badge
    off_x = ((152 + 586) / 2 - 360) / 338 * size
    off_y = ((185 + 523) / 2 - 360) / 338 * size
    return svg(round(W), round(H), mark_group(W / 2 - off_x, H / 2 - off_y, size, s_fill, dot_fill))
write("superi-mark-on-light.svg", bare(INK, LIME))
write("superi-mark-on-dark.svg", bare(PAPER, LIME))


# ---------- horizontal logo: badge + SUPERI + .GE chip ----------
def horizontal(word_fill):
    H = 200                      # logo height = badge diameter
    r = H / 2
    body = f'<circle cx="{r}" cy="{r}" r="{r}" fill="{LIME}"/>' + mark_group(r, r, S_REF * H, INK, INK)
    # wordmark cap height ~ 0.62 of badge, tracking -0.045em like the cover
    ux0, uy0, ux1, uy1 = bounds(F800, "S")
    cap = 0.60 * H
    k = cap / (uy1 - uy0)
    x0 = H + 0.20 * H
    xmin, xmax, ymin, ymax = run_bounds(F800, "SUPERI", k, -0.045)
    baseline = r + cap / 2
    d, _ = text_run(F800, "SUPERI", k, x0 - xmin, baseline, -0.045)
    body += f'<path d="{d}" fill="{word_fill}"/>'
    word_right = x0 + (xmax - xmin)
    # .GE chip aligned to cap top, like the cover
    ck = 0.36 * cap / (bounds(F700, "G")[3] - bounds(F700, "G")[1])
    gx0, gx1, gy0, gy1 = run_bounds(F700, ".GE", ck, 0.02)
    padx, pady = 0.11 * cap, 0.10 * cap
    chip_w = (gx1 - gx0) + 2 * padx
    chip_h = (gy1 - gy0) + 2 * pady
    chip_x = word_right + 0.09 * H
    chip_y = r - cap / 2
    body += f'<rect x="{chip_x:.2f}" y="{chip_y:.2f}" width="{chip_w:.2f}" height="{chip_h:.2f}" rx="{0.06 * cap:.2f}" fill="{LIME}"/>'
    gd, _ = text_run(F700, ".GE", ck, chip_x + padx - gx0, chip_y + pady + gy1, 0.02)
    body += f'<path d="{gd}" fill="{INK}"/>'
    W = chip_x + chip_w + 2
    return svg(round(W), H, body)


write("superi-logo-horizontal-on-dark.svg", horizontal(PAPER))
write("superi-logo-horizontal-on-light.svg", horizontal(INK))

print("ok", sorted(os.listdir(OUT)))
