"""Superi.ge logo system: constructed S. symbol + constructed 'superi.ge' wordmark (all outlines)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from letters import mark_shapes, wordmark, WM, X, MARK

INK, LIME, PAPER, DEEP = '#0E1110', '#8CC63F', '#F2F3EE', '#24562A'

# lockup proportions, all relative to the wordmark x-height
LOCK = dict(disc=40 / 18,      # disc diameter / x-height  (40 px disc at 18 px x-height on the cover)
            gap=12 / 18,       # disc -> wordmark gap  (0.3 disc)
            glyph=0.58,        # S height / disc diameter
            glyph_dx=0.0)      # optical shift of the S. inside the disc (fraction of disc)


def symbol_svg(x, y, height, fill=INK, dot_fill=None):
    """S. symbol, top-left at (x,y), S height = height px. Returns (svg, width)."""
    s, dot, tw, th = mark_shapes()
    k = height / th
    out = f'<path d="{s.d(x, y, k)}" fill="{fill}"/><path d="{dot.d(x, y, k)}" fill="{dot_fill or fill}"/>'
    return out, tw * k


def disc_mark(d, cx, cy, disc=LIME, glyph=INK, ratio=None, dx=None):
    ratio = LOCK['glyph'] if ratio is None else ratio
    dx = LOCK['glyph_dx'] if dx is None else dx
    s, dot, tw, th = mark_shapes()
    gh = d * ratio; k = gh / th
    x = cx - tw * k / 2 + dx * d; y = cy - gh / 2
    return (f'<circle cx="{cx:.3f}" cy="{cy:.3f}" r="{d/2:.3f}" fill="{disc}"/>'
            f'<path d="{s.d(x, y, k)}" fill="{glyph}"/><path d="{dot.d(x, y, k)}" fill="{glyph}"/>')


def wordmark_svg(x, top, xh, main=PAPER, dot=LIME):
    """Wordmark with x-height line at y=top, x-height xh px. Returns (svg, width)."""
    m, p, w = wordmark()
    k = xh / X
    return (f'<path d="{m.d(x, top, k)}" fill="{main}"/><path d="{p.d(x, top, k)}" fill="{dot}"/>'), w * k


def lockup(xh, x=0.0, y=0.0, main=PAPER, dot=LIME, disc=LIME, glyph=INK, **kw):
    """Horizontal lockup; xh = wordmark x-height in px. Returns (svg, width, height)."""
    L = dict(LOCK); L.update(kw)
    d = L['disc'] * xh
    svg = disc_mark(d, x + d / 2, y + d / 2, disc=disc, glyph=glyph, ratio=L['glyph'], dx=L['glyph_dx'])
    wm, ww = wordmark_svg(x + d + L['gap'] * xh, y + d / 2 - xh / 2, xh, main=main, dot=dot)
    return svg + wm, d + L['gap'] * xh + ww, d


def badge_svg(S=1080, ratio=0.48, dx=-0.0, bg=LIME, fg=INK):
    """Square profile badge (Facebook crops it to a circle). ratio = S height / badge size."""
    s, dot, tw, th = mark_shapes()
    gh = S * ratio; k = gh / th
    x = S / 2 - tw * k / 2 + dx * S; y = S / 2 - gh / 2
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{S}" height="{S}" viewBox="0 0 {S} {S}">'
            f'<title>Superi.ge</title><rect width="{S}" height="{S}" fill="{bg}"/>'
            f'<path d="{s.d(x, y, k)}" fill="{fg}"/><path d="{dot.d(x, y, k)}" fill="{fg}"/></svg>\n'), (x, y, tw * k, gh)


def svgdoc(w, h, body, title='Superi.ge'):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w:.0f}" height="{h:.0f}" viewBox="0 0 {w:.0f} {h:.0f}">'
            f'<title>{title}</title>{body}</svg>\n')
