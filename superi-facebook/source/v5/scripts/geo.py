"""Tiny vector-geometry kit for the Superi.ge identity.

Every shape is a closed contour made of straight lines and true circular arcs, written
as SVG path data (filled, nonzero).  Contours are normalised so that solid parts run
one way and holes run the other way, so overlapping parts of one glyph union cleanly
inside a single <path> (no anti-aliasing seams).

Coordinates: y grows downwards (SVG).  Angles in degrees, 0 = +x, 90 = +y (down).
"""
import math


def _pt(cx, cy, r, a):
    t = math.radians(a)
    return cx + r * math.cos(t), cy + r * math.sin(t)


class Contour:
    def __init__(self, x, y):
        self.start = (x, y)
        self.segs = []          # ('L', x, y) | ('A', cx, cy, r, a0, a1)
        self.cur = (x, y)

    def L(self, x, y):
        self.segs.append(('L', x, y)); self.cur = (x, y); return self

    def A(self, cx, cy, r, a0, a1):
        """Arc on circle (cx,cy,r) from angle a0 to a1 (a1<a0 runs anticlockwise on screen)."""
        self.segs.append(('A', cx, cy, r, a0, a1)); self.cur = _pt(cx, cy, r, a1); return self

    # -- sampling (for area / orientation checks)
    def poly(self, step=3.0):
        pts = [self.start]
        for s in self.segs:
            if s[0] == 'L':
                pts.append((s[1], s[2]))
            else:
                _, cx, cy, r, a0, a1 = s
                n = max(2, int(abs(a1 - a0) / step))
                for i in range(1, n + 1):
                    pts.append(_pt(cx, cy, r, a0 + (a1 - a0) * i / n))
        return pts

    def area(self):
        p = self.poly(); a = 0.0
        for (x0, y0), (x1, y1) in zip(p, p[1:] + p[:1]):
            a += x0 * y1 - x1 * y0
        return a / 2

    def reversed(self):
        pts = [self.start]; cur = self.start
        for s in self.segs:
            cur = (s[1], s[2]) if s[0] == 'L' else _pt(s[1], s[2], s[3], s[5])
            pts.append(cur)
        c = Contour(*pts[-1])
        for i in range(len(self.segs) - 1, -1, -1):
            s = self.segs[i]; tgt = pts[i]
            if s[0] == 'L':
                c.L(*tgt)
            else:
                c.A(s[1], s[2], s[3], s[5], s[4])
        return c

    def d(self, tx=0.0, ty=0.0, k=1.0, nd=3):
        f = lambda v: (f"{v:.{nd}f}").rstrip('0').rstrip('.') if '.' in f"{v:.{nd}f}" else f"{v:.{nd}f}"
        X = lambda x: f(tx + k * x); Y = lambda y: f(ty + k * y)
        out = [f"M{X(self.start[0])} {Y(self.start[1])}"]
        cur = self.start
        for s in self.segs:
            if s[0] == 'L':
                if abs(s[1] - cur[0]) < 1e-9 and abs(s[2] - cur[1]) < 1e-9:
                    continue
                out.append(f"L{X(s[1])} {Y(s[2])}"); cur = (s[1], s[2])
            else:
                _, cx, cy, r, a0, a1 = s
                sweep = 1 if a1 > a0 else 0
                span = abs(a1 - a0)
                # split arcs >= 359 deg into two halves (SVG cannot draw a full circle in one arc)
                parts = [(a0, a1)] if span < 359 else [(a0, (a0 + a1) / 2), ((a0 + a1) / 2, a1)]
                for b0, b1 in parts:
                    ex, ey = _pt(cx, cy, r, b1)
                    large = 1 if abs(b1 - b0) > 180 else 0
                    out.append(f"A{f(k*r)} {f(k*r)} 0 {large} {sweep} {X(ex)} {Y(ey)}")
                    cur = (ex, ey)
        out.append('Z')
        return ''.join(out)


class Shape:
    """A union of solid contours minus holes (holes only cut their own glyph's solids)."""
    def __init__(self):
        self.solids, self.holes = [], []

    def add(self, c):
        self.solids.append(c if c.area() > 0 else c.reversed()); return self

    def hole(self, c):
        self.holes.append(c if c.area() < 0 else c.reversed()); return self

    def extend(self, other, dx=0.0):
        self.solids += [moved(c, dx) for c in other.solids]
        self.holes += [moved(c, dx) for c in other.holes]
        return self

    def d(self, tx=0.0, ty=0.0, k=1.0):
        return ''.join(c.d(tx, ty, k) for c in self.solids + self.holes)


def moved(c, dx=0.0, dy=0.0):
    n = Contour(c.start[0] + dx, c.start[1] + dy)
    for s in c.segs:
        if s[0] == 'L':
            n.L(s[1] + dx, s[2] + dy)
        else:
            n.A(s[1] + dx, s[2] + dy, s[3], s[4], s[5])
    return n


# ---------------------------------------------------------------- primitives
def rect(x0, y0, x1, y1):
    return Contour(x0, y0).L(x1, y0).L(x1, y1).L(x0, y1)


def circle(cx, cy, r):
    return Contour(cx + r, cy).A(cx, cy, r, 0, 360)


def ring(cx, cy, ro, ri):
    s = Shape(); s.add(circle(cx, cy, ro)); s.hole(circle(cx, cy, ri)); return s


def annulus_sector(cx, cy, ro, ri, a0, a1):
    """Band between radii ri..ro from angle a0 to a1 (radial ends)."""
    x0, y0 = _pt(cx, cy, ro, a0)
    c = Contour(x0, y0).A(cx, cy, ro, a0, a1)
    c.L(*_pt(cx, cy, ri, a1)).A(cx, cy, ri, a1, a0)
    return c
