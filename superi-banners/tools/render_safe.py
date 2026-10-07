"""Studio product render of a modern electronic safe (superi.ge has no safe photos to cut out).

usage: <python with bpy 4.2> render_safe.py <out.png> [samples]
Output: RGBA PNG with a transparent background, ready for make_banners.py.
"""
import math
import sys

import bpy
from mathutils import Vector

OUT = sys.argv[1]
SAMPLES = int(sys.argv[2]) if len(sys.argv) > 2 else 128

bpy.ops.wm.read_factory_settings(use_empty=True)
scene = bpy.context.scene


def material(name, color, metallic=0.0, roughness=0.5, coat=0.0, emission=None, strength=0.0):
    m = bpy.data.materials.new(name)
    m.use_nodes = True
    b = m.node_tree.nodes['Principled BSDF']
    b.inputs['Base Color'].default_value = (*color, 1)
    b.inputs['Metallic'].default_value = metallic
    b.inputs['Roughness'].default_value = roughness
    b.inputs['Coat Weight'].default_value = coat
    b.inputs['Coat Roughness'].default_value = 0.04
    if emission:
        b.inputs['Emission Color'].default_value = (*emission, 1)
        b.inputs['Emission Strength'].default_value = strength
    return m


def box(name, size, loc, mat, bevel=0.0, segments=5):
    bpy.ops.mesh.primitive_cube_add(size=1, location=loc)
    o = bpy.context.object
    o.name = name
    o.scale = size
    bpy.ops.object.transform_apply(scale=True)
    if bevel:
        mod = o.modifiers.new('bevel', 'BEVEL')
        mod.width = bevel
        mod.segments = segments
        mod.limit_method = 'NONE'
    bpy.ops.object.shade_smooth()
    o.data.materials.append(mat)
    return o


def cylinder(name, r, depth, loc, rot, mat, bevel=0.0):
    bpy.ops.mesh.primitive_cylinder_add(vertices=64, radius=r, depth=depth, location=loc, rotation=rot)
    o = bpy.context.object
    o.name = name
    if bevel:
        mod = o.modifiers.new('bevel', 'BEVEL')
        mod.width = bevel
        mod.segments = 4
        mod.limit_method = 'ANGLE'
    bpy.ops.object.shade_smooth()
    o.data.materials.append(mat)
    return o


def text(body, size, loc, mat, rot=(math.pi / 2, 0, 0)):
    bpy.ops.object.text_add(location=loc, rotation=rot)
    o = bpy.context.object
    o.data.body = body
    o.data.size = size
    o.data.align_x = 'CENTER'
    o.data.align_y = 'CENTER'
    o.data.extrude = 0.0004
    o.data.materials.append(mat)
    return o


paint = material('paint', (0.26, 0.006, 0.012), metallic=0.45, roughness=0.32, coat=1.0)
gap = material('gap', (0.015, 0.004, 0.005), roughness=0.7)
chrome = material('chrome', (0.92, 0.92, 0.94), metallic=1.0, roughness=0.1)
dark_chrome = material('dark_chrome', (0.25, 0.25, 0.27), metallic=1.0, roughness=0.22)
glass = material('glass', (0.008, 0.008, 0.01), roughness=0.06, coat=1.0)
keys_mat = material('keys', (0.78, 0.78, 0.8), metallic=1.0, roughness=0.28)
ink = material('ink', (0.03, 0.03, 0.035), roughness=0.6)
lcd_bg = material('lcd_bg', (0.01, 0.03, 0.04), roughness=0.2, emission=(0.05, 0.25, 0.32), strength=0.6)
lcd_txt = material('lcd_txt', (0.1, 0.8, 1.0), emission=(0.25, 0.9, 1.0), strength=6.0)
led = material('led', (0.1, 1.0, 0.3), emission=(0.1, 1.0, 0.35), strength=8.0)
rubber = material('rubber', (0.02, 0.02, 0.02), roughness=0.8)

W, D, H = 0.40, 0.40, 0.50          # body width, depth, height (metres)
FRONT = -D / 2

box('body', (W, D, H), (0, 0, H / 2 + 0.012), paint, bevel=0.022)
for x in (-W / 2 + 0.05, W / 2 - 0.05):
    for y in (FRONT + 0.05, -FRONT - 0.05):
        cylinder('foot', 0.018, 0.014, (x, y, 0.007), (0, 0, 0), rubber, bevel=0.003)

# door: slightly smaller slab standing proud of the body, its bevel reads as the seam
DT = 0.018
door_y = FRONT - DT / 2 + 0.004
box('gap', (W - 0.024, 0.006, H - 0.024), (0, FRONT - 0.001, H / 2 + 0.012), gap, bevel=0.004)
box('door', (W - 0.036, DT, H - 0.036), (0, door_y, H / 2 + 0.012), paint, bevel=0.006)
DF = door_y - DT / 2                 # door front plane

for z in (0.12, H - 0.08):
    cylinder('hinge', 0.011, 0.07, (-W / 2 + 0.006, DF + 0.012, z), (0, 0, 0), dark_chrome, bevel=0.002)

# keypad: black glass panel with display, 12 metal keys, status LED
KX, KZ = -0.05, 0.31
box('keypad', (0.125, 0.008, 0.2), (KX, DF - 0.003, KZ), glass, bevel=0.01)
PF = DF - 0.007
box('lcd', (0.092, 0.002, 0.032), (KX, PF - 0.001, KZ + 0.066), lcd_bg, bevel=0.003)
text('8 8 8 8', 0.022, (KX, PF - 0.0025, KZ + 0.066), lcd_txt)
labels = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '*', '0', '#']
for i, lab in enumerate(labels):
    cx = KX + (i % 3 - 1) * 0.03
    cz = KZ + 0.025 - (i // 3) * 0.028
    cylinder('key', 0.0105, 0.006, (cx, PF - 0.003, cz), (math.pi / 2, 0, 0), keys_mat, bevel=0.0015)
    text(lab, 0.012, (cx, PF - 0.0062, cz), ink)
cylinder('led', 0.0028, 0.003, (KX + 0.048, PF - 0.0015, KZ + 0.088), (math.pi / 2, 0, 0), led)

# handle: chrome dial with a lever bar across it
HX, HZ = 0.105, 0.31
cylinder('dial', 0.036, 0.012, (HX, DF - 0.006, HZ), (math.pi / 2, 0, 0), chrome, bevel=0.003)
cylinder('hub', 0.014, 0.03, (HX, DF - 0.02, HZ), (math.pi / 2, 0, 0), chrome, bevel=0.002)
box('lever', (0.105, 0.014, 0.017), (HX, DF - 0.03, HZ), chrome, bevel=0.006)

# brand-free badge strip
box('strip', (0.16, 0.003, 0.006), (0, DF - 0.0015, 0.075), chrome, bevel=0.002)

# camera: three-quarter front view, slightly above, long lens like catalogue shots
target = Vector((0.0, 0.0, 0.26))
cam_loc = Vector((-0.95, -1.78, 0.68))
bpy.ops.object.camera_add(location=cam_loc)
cam = bpy.context.object
cam.data.lens = 85
cam.rotation_euler = (target - cam_loc).to_track_quat('-Z', 'Y').to_euler()
scene.camera = cam


def area(loc, size, energy, color=(1, 1, 1)):
    bpy.ops.object.light_add(type='AREA', location=loc)
    l = bpy.context.object
    l.data.size = size
    l.data.energy = energy
    l.data.color = color
    l.rotation_euler = (target - Vector(loc)).to_track_quat('-Z', 'Y').to_euler()
    return l


area((-1.3, -1.4, 1.3), 1.6, 260)                    # key, upper left
area((1.6, -1.1, 0.7), 1.8, 110, (0.95, 0.95, 1.0))  # fill, right
area((0.0, 0.2, 2.0), 1.2, 30)                       # top
area((1.4, 0.9, 0.45), 1.0, 150)                     # rim, right side behind

world = bpy.data.worlds.new('world')
scene.world = world
world.use_nodes = True
world.node_tree.nodes['Background'].inputs['Color'].default_value = (0.75, 0.74, 0.8, 1)
world.node_tree.nodes['Background'].inputs['Strength'].default_value = 0.14

scene.render.engine = 'CYCLES'
scene.cycles.device = 'CPU'
scene.cycles.samples = SAMPLES
scene.cycles.use_denoising = True
scene.render.film_transparent = True
scene.render.resolution_x = 1400
scene.render.resolution_y = 1400
scene.render.image_settings.file_format = 'PNG'
scene.render.image_settings.color_mode = 'RGBA'
scene.view_settings.view_transform = 'AgX'
try:
    scene.view_settings.look = 'AgX - Punchy'
except TypeError:
    pass
scene.render.filepath = OUT
bpy.ops.render.render(write_still=True)
print('saved', OUT)
