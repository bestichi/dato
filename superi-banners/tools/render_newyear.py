"""Studio product renders for the New Year subcategories that have no clean product photo on superi.ge.

usage: <python with bpy 4.2> render_newyear.py baubles|garland <out.png> [samples]
  baubles  three glossy Christmas baubles (deep red, champagne gold, pearl) with gold caps
  garland  a festoon of warm globe string lights on a dark cable, with a soft glow added after the render
Output: RGBA PNG with a transparent background, ready for make_banners.py as a local "src".
"""
import math
import sys

import bpy
import numpy as np
from mathutils import Vector

MODE, OUT = sys.argv[1], sys.argv[2]
SAMPLES = int(sys.argv[3]) if len(sys.argv) > 3 else 160

bpy.ops.wm.read_factory_settings(use_empty=True)
scene = bpy.context.scene


def material(name, color, metallic=0.0, roughness=0.5, coat=0.0, emission=None, strength=0.0, sheen=0.0):
    m = bpy.data.materials.new(name)
    m.use_nodes = True
    b = m.node_tree.nodes['Principled BSDF']
    b.inputs['Base Color'].default_value = (*color, 1)
    b.inputs['Metallic'].default_value = metallic
    b.inputs['Roughness'].default_value = roughness
    b.inputs['Coat Weight'].default_value = coat
    b.inputs['Coat Roughness'].default_value = 0.03
    b.inputs['Sheen Weight'].default_value = sheen
    if emission:
        b.inputs['Emission Color'].default_value = (*emission, 1)
        b.inputs['Emission Strength'].default_value = strength
    return m


def sphere(name, r, loc, mat, segments=96):
    bpy.ops.mesh.primitive_uv_sphere_add(segments=segments, ring_count=segments // 2, radius=r, location=loc)
    o = bpy.context.object
    o.name = name
    bpy.ops.object.shade_smooth()
    o.data.materials.append(mat)
    return o


def cylinder(name, r, depth, loc, mat, rot=(0, 0, 0), bevel=0.0, vertices=64):
    bpy.ops.mesh.primitive_cylinder_add(vertices=vertices, radius=r, depth=depth, location=loc, rotation=rot)
    o = bpy.context.object
    o.name = name
    if bevel:
        mod = o.modifiers.new('bevel', 'BEVEL')
        mod.width = bevel
        mod.segments = 3
        mod.limit_method = 'ANGLE'
    bpy.ops.object.shade_smooth()
    o.data.materials.append(mat)
    return o


def torus(name, major, minor, loc, rot, mat):
    bpy.ops.mesh.primitive_torus_add(major_radius=major, minor_radius=minor, location=loc, rotation=rot,
                                     major_segments=48, minor_segments=16)
    o = bpy.context.object
    o.name = name
    bpy.ops.object.shade_smooth()
    o.data.materials.append(mat)
    return o


def area(loc, size, energy, target, color=(1, 1, 1)):
    bpy.ops.object.light_add(type='AREA', location=loc)
    l = bpy.context.object
    l.data.size = size
    l.data.energy = energy
    l.data.color = color
    l.rotation_euler = (target - Vector(loc)).to_track_quat('-Z', 'Y').to_euler()
    return l


def camera(loc, target, lens):
    bpy.ops.object.camera_add(location=loc)
    cam = bpy.context.object
    cam.data.lens = lens
    cam.rotation_euler = (target - Vector(loc)).to_track_quat('-Z', 'Y').to_euler()
    scene.camera = cam


def world(color, strength):
    w = bpy.data.worlds.new('world')
    scene.world = w
    w.use_nodes = True
    w.node_tree.nodes['Background'].inputs['Color'].default_value = (*color, 1)
    w.node_tree.nodes['Background'].inputs['Strength'].default_value = strength


def bauble(name, r, loc, mat, cap_mat, tilt=0.0):
    """Sphere with a ribbed metal cap and a hanging loop; tilt (radians, around y) leans the cap."""
    sphere(name, r, loc, mat)
    up = Vector((math.sin(tilt), 0, math.cos(tilt)))
    c = Vector(loc) + up * (r * 0.97)
    cap = cylinder(name + '_cap', r * 0.2, r * 0.17, c + up * (r * 0.06), cap_mat, rot=(0, tilt, 0), bevel=r * 0.012)
    ribs = cap.modifiers.new('ribs', 'DISPLACE')
    tex = bpy.data.textures.new(name + '_ribs', 'STUCCI')
    tex.noise_scale = 0.02
    ribs.texture = tex
    ribs.strength = r * 0.004
    cylinder(name + '_crown', r * 0.08, r * 0.06, c + up * (r * 0.17), cap_mat, rot=(0, tilt, 0), bevel=r * 0.01)
    torus(name + '_loop', r * 0.075, r * 0.016, c + up * (r * 0.27), (math.pi / 2, tilt, 0), cap_mat)


def build_baubles():
    red = material('red', (0.36, 0.012, 0.022), metallic=0.5, roughness=0.12, coat=1.0)
    gold = material('gold', (1.0, 0.6, 0.22), metallic=1.0, roughness=0.2)
    pearl = material('pearl', (0.98, 0.96, 0.93), metallic=0.05, roughness=0.16, coat=1.0, sheen=0.3)
    cap = material('cap', (0.95, 0.78, 0.5), metallic=1.0, roughness=0.18)
    bauble('red', 0.11, (-0.045, 0.06, 0.11), red, cap, tilt=-0.1)
    bauble('gold', 0.085, (0.12, -0.09, 0.085), gold, cap, tilt=0.25)
    bauble('pearl', 0.07, (-0.13, -0.13, 0.07), pearl, cap, tilt=-0.3)
    target = Vector((-0.01, -0.04, 0.1))
    camera((-0.3, -1.75, 0.6), target, 85)
    area((-1.1, -1.2, 1.3), 1.8, 140, target)                     # key, upper left (big soft highlight)
    area((1.4, -1.1, 0.5), 2.0, 70, target, (0.96, 0.95, 1.0))    # fill, right
    area((0.0, -1.9, 0.25), 2.5, 45, target)                      # low front fill: lifts the shadow sides
    area((0.0, 0.6, 1.8), 1.2, 40, target)                        # top
    area((1.1, 1.0, 0.35), 0.8, 70, target)                       # rim, behind right
    world((0.9, 0.88, 0.96), 0.7)


def build_garland():
    """A festoon string receding from front-left to back-right: two swags, globe bulbs on short drops."""
    cable = material('cable', (0.018, 0.022, 0.02), roughness=0.45)
    socket = material('socket', (0.025, 0.025, 0.028), roughness=0.3, metallic=0.25)
    bulb = material('bulb', (1.0, 0.8, 0.55), roughness=0.3, emission=(1.0, 0.56, 0.2), strength=7.0)

    origin = Vector((-0.55, -0.35, 0.0))
    d = Vector((1.0, 1.35, 0.0)).normalized()
    span, sag, top = 0.7, 0.28, 0.5          # two swags of `span` metres

    def at(s):
        t = (s % span) / span if s < 2 * span else 1.0
        p = origin + d * s
        return Vector((p.x, p.y, top - sag * (1 - (2 * t - 1) ** 2)))

    n = 160
    pts = [at(2 * span * i / n) for i in range(n + 1)]
    curve = bpy.data.curves.new('cable', 'CURVE')
    curve.dimensions = '3D'
    curve.bevel_depth = 0.0055
    curve.bevel_resolution = 4
    sp = curve.splines.new('POLY')
    sp.points.add(len(pts) - 1)
    for p, v in zip(sp.points, pts):
        p.co = (v.x, v.y, v.z, 1)
    o = bpy.data.objects.new('cable', curve)
    scene.collection.objects.link(o)
    o.data.materials.append(cable)

    yaw = math.atan2(d.y, d.x)
    for s in (0.0, span, 2 * span):           # hooks at the hanging points
        v = at(s)
        torus('hook', 0.014, 0.0035, (v.x, v.y, v.z + 0.016), (math.pi / 2, 0, yaw), cable)

    step = span / 7
    for k in range(1, 14):
        if k == 7:
            continue                            # no bulb right at the middle hook
        v = at(k * step)
        drop = 0.035
        cylinder('drop', 0.004, drop, (v.x, v.y, v.z - drop / 2), cable, vertices=16)
        cylinder('socket', 0.0125, 0.03, (v.x, v.y, v.z - drop - 0.013), socket, bevel=0.002)
        cylinder('ring', 0.0133, 0.005, (v.x, v.y, v.z - drop - 0.028), socket, bevel=0.001)
        sphere('bulb', 0.034, (v.x, v.y, v.z - drop - 0.03 - 0.031), bulb, segments=48)

    target = at(span) + Vector((0, 0, -0.12))
    camera((-0.5, -1.8, 0.62), target, 42)
    area((-1.0, -1.4, 1.4), 1.6, 45, target)
    area((1.2, -1.0, 0.6), 1.4, 22, target)
    world((0.85, 0.82, 0.9), 0.3)


def add_glow(path):
    """Soft warm halo around the bright bulbs: blurred light, kept under the product, with its own alpha."""
    from PIL import Image, ImageFilter
    im = Image.open(path).convert('RGBA')
    a = np.asarray(im, dtype=np.float32) / 255.0
    lum = a[..., :3].max(axis=2) * a[..., 3]
    bright = Image.fromarray((np.clip((lum - 0.72) / 0.2, 0, 1) * 255).astype(np.uint8), 'L')
    w = im.width
    halo = np.zeros(lum.shape, np.float32)
    for radius, weight in ((w * 0.009, 1.0), (w * 0.02, 0.45)):
        halo += np.asarray(bright.filter(ImageFilter.GaussianBlur(radius)), np.float32) / 255.0 * weight
    halo = np.clip(halo * 1.5, 0, 0.8)
    glow = np.zeros_like(a)
    glow[..., 0], glow[..., 1], glow[..., 2] = 1.0, 0.6, 0.22
    glow[..., 3] = halo
    # product over glow
    out_a = a[..., 3:4] + glow[..., 3:4] * (1 - a[..., 3:4])
    out_rgb = (a[..., :3] * a[..., 3:4] + glow[..., :3] * glow[..., 3:4] * (1 - a[..., 3:4])) / np.maximum(out_a, 1e-6)
    Image.fromarray((np.dstack([out_rgb, out_a]) * 255).round().astype(np.uint8), 'RGBA').save(path)


{'baubles': build_baubles, 'garland': build_garland}[MODE]()

scene.render.engine = 'CYCLES'
scene.cycles.device = 'CPU'
scene.cycles.samples = SAMPLES
scene.cycles.use_denoising = True
scene.render.film_transparent = True
scene.render.resolution_x = scene.render.resolution_y = 1600 if MODE == 'baubles' else 2000
scene.render.image_settings.file_format = 'PNG'
scene.render.image_settings.color_mode = 'RGBA'
scene.view_settings.view_transform = 'AgX'
try:
    scene.view_settings.look = 'AgX - Punchy'
except TypeError:
    pass
scene.render.filepath = OUT
bpy.ops.render.render(write_still=True)
if MODE == 'garland':
    add_glow(OUT)
print('saved', OUT)
