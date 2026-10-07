"""Superi.ge modernist identity: the constructed 'S.' symbol and the 'superi.ge' wordmark.

One construction for everything:
  * a single stroke weight T (the module),
  * straight bars with square-cut (axis-aligned) terminals,
  * true-circle turns and bowls,
  * round dots whose diameter equals the stroke (the S-dot, the i-dot and the full stop).

Wordmark units: x-height X = 100, baseline at y = X, x-height line at y = 0 (y down).
"""
import math
from geo import Contour, Shape, rect, circle, ring, annulus_sector

# ---------------------------------------------------------------- the S (mark + wordmark 's')

def s_shape(W, H, w, x=0.0, y=0.0):
    """Monoline S: top bar -> left half-turn -> middle bar -> right half-turn -> bottom bar.
    Box W x H, stroke w, square terminals (top bar ends right, bottom bar ends left)."""
    r = (H - w) / 4.0
    ro, ri = r + w / 2, r - w / 2
    cl, cr = x + ro, x + W - ro
    yc1, yc2 = y + w / 2 + r, y + H - w / 2 - r
    c = Contour(x + W, y)
    c.L(cl, y)
    c.A(cl, yc1, ro, -90, -270)              # outer left turn (top -> left -> bottom)
    c.L(cr, yc1 + ro)
    c.A(cr, yc2, ri, -90, 90)                # inner right turn
    c.L(x, yc2 + ri)
    c.L(x, y + H)
    c.L(cr, y + H)
    c.A(cr, yc2, ro, 90, -90)                # outer right turn
    c.L(cl, yc2 - ro)
    c.A(cl, yc1, ri, 90, 270)                # inner left turn
    c.L(x + W, y + w)
    s = Shape(); s.add(c); return s


# mark geometry (units): S box 88 x 100, stroke module 24, dot = stroke, gap = 9
MARK = dict(W=88.0, H=100.0, w=24.0, gap=9.0)


def mark_shapes(W=None, H=None, w=None, gap=None):
    W = W or MARK['W']; H = H or MARK['H']; w = w or MARK['w']; gap = MARK['gap'] if gap is None else gap
    s = s_shape(W, H, w)
    dot = Shape().add(circle(W + gap + w / 2, H - w / 2, w / 2))
    return s, dot, W + gap + w, H


# ---------------------------------------------------------------- wordmark glyphs
X = 100.0


class WM:
    def __init__(self, T=22.0, D=46.0, s_w=76.0, u_w=90.0, r_ro=44.0, r_stub=0.0,
                 e_cut=16.0, g_tail=24.0, i_gap=15.0, bowl=100.0):
        self.T, self.D = T, D
        self.s_w, self.u_w = s_w, u_w
        self.r_ro, self.r_stub = r_ro, r_stub
        self.e_cut, self.g_tail, self.i_gap = e_cut, g_tail, i_gap
        self.bowl = bowl

    # every glyph returns (Shape, advance_width); origin = left extent at x-height line
    def s(self):
        return s_shape(self.s_w, X, self.T), self.s_w

    def u(self):
        T, W = self.T, self.u_w
        ro = W / 2; ri = ro - T; cy = X - ro
        c = Contour(0, 0).L(0, cy).A(ro, cy, ro, 180, 0).L(W, 0).L(W - T, 0).L(W - T, cy)
        c.A(ro, cy, ri, 0, 180).L(T, 0)
        return Shape().add(c), W

    def p(self):
        T, D = self.T, self.D
        ro = self.bowl / 2; ri = ro - T
        sh = ring(ro, X / 2, ro, ri)
        sh.add(rect(0, 0, T, X + D))
        return sh, 2 * ro

    def e(self):
        """Ring + crossbar on the centre line.  The lower terminal is cut square (vertical),
        like the bar ends of the S; e_cut = distance of the cut right of the bowl centre."""
        T, h = self.T, self.T / 2
        ro = self.bowl / 2; ri = ro - T; cx = cy = ro
        ex = self.e_cut
        a_bar_o = math.degrees(math.asin(h / ro))
        a_bar_i = math.degrees(math.asin(h / ri))
        a_cut_o = math.degrees(math.acos(ex / ro))       # lower-right, measured downwards
        a_cut_i = math.degrees(math.acos(ex / ri))
        c = Contour(cx + math.sqrt(ro * ro - h * h), cy + h)
        c.A(cx, cy, ro, a_bar_o, a_cut_o - 360)                    # outer, the long way round
        c.L(cx + ex, cy + math.sqrt(ri * ri - ex * ex))             # square (vertical) terminal
        c.A(cx, cy, ri, a_cut_i, 180 - a_bar_i)                     # inner lower arc
        c.L(cx + math.sqrt(ro * ro - h * h), cy + h)                # crossbar underside
        hole = Contour(cx - math.sqrt(ri * ri - h * h), cy - h).L(cx + math.sqrt(ri * ri - h * h), cy - h)
        hole.A(cx, cy, ri, -a_bar_i, -180 + a_bar_i)
        sh = Shape().add(c); sh.hole(hole)
        return sh, 2 * ro

    def r(self):
        T, ro = self.T, self.r_ro
        ri = ro - T
        sh = Shape()
        sh.add(annulus_sector(ro, ro, ro, ri, 180, 270))           # quarter turn, top-left
        sh.add(rect(0, ro - 0.01, T, X))                             # stem
        if self.r_stub > 0:
            sh.add(rect(ro - 0.01, 0, ro + self.r_stub, T))          # short arm, square cut
        return sh, ro + self.r_stub

    def i(self):
        T = self.T
        sh = Shape().add(rect(0, 0, T, X)).add(circle(T / 2, -self.i_gap - T / 2, T / 2))
        return sh, T

    def dot(self):
        T = self.T
        return Shape().add(circle(T / 2, X - T / 2, T / 2)), T

    def g(self):
        T, D = self.T, self.D
        ro = self.bowl / 2; ri = ro - T
        W = 2 * ro
        tr = (X - T) / 4 + T / 2          # same turn as the 's' (outer radius)
        tri = tr - T
        yb = X + D                          # descender line (bottom of tail)
        sh = ring(ro, X / 2, ro, ri)
        sh.add(rect(W - T, 0, W, yb - tr + 0.01))                                 # stem
        sh.add(annulus_sector(W - tr, yb - tr, tr, tri, 0, 90))                   # quarter turn
        sh.add(rect(self.g_tail, yb - T, W - tr + 0.01, yb))                      # tail bar
        return sh, W

    def glyph(self, ch):
        return {'s': self.s, 'u': self.u, 'p': self.p, 'e': self.e, 'r': self.r, 'i': self.i,
                '.': self.dot, 'g': self.g}[ch]()


# side gaps between glyph extents, in x-height units (tuned by eye at 18 px and at 240 px)
GAPS = {('s', 'u'): 15, ('u', 'p'): 17, ('p', 'e'): 11, ('e', 'r'): 14, ('r', 'i'): 13,
        ('i', '.'): 12, ('.', 'g'): 11, ('g', 'e'): 11}


def wordmark(wm=None, text='superi.ge', gaps=None, track=0.0):
    """Returns (main Shape, period Shape, width) in x-height units (x-height line y=0, baseline y=100)."""
    wm = wm or WM(); gaps = gaps or GAPS
    main, per = Shape(), Shape()
    x = 0.0; prev = None
    for ch in text:
        if prev is not None:
            x += gaps.get((prev, ch), 14) + track
        sh, adv = wm.glyph(ch)
        (per if ch == '.' else main).extend(sh, x)
        x += adv; prev = ch
    return main, per, x
