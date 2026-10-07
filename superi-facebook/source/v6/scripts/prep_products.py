"""Prepare product cut-outs for the final cover (sources in prod_src/).
fridge_lg_instaview: crop to the cabinet (drops the stray white bracket on the right edge
and the grey floor/plinth gradient under the doors) and decontaminate the edge."""
import sys
sys.path.insert(0, '/tmp/claude-0/-home-user-dato/6fdbe81a-df64-5cba-80c4-f4ac98dc935c/scratchpad/pylib')
from PIL import Image
import numpy as np

POOL = '/tmp/claude-0/-home-user-dato/6fdbe81a-df64-5cba-80c4-f4ac98dc935c/scratchpad/v5/pool'
D = '/tmp/claude-0/-home-user-dato/6fdbe81a-df64-5cba-80c4-f4ac98dc935c/scratchpad/v5/final'

im = Image.open(f'{POOL}/fridge_lg_instaview.png').convert('RGBA')
im = im.crop((112, 67, 562, 976))           # cabinet only: x 112..561, y 67..975
A = np.array(im).astype(np.float32)
a = A[:, :, 3]
a[a < 24] = 0                                 # kill faint halo
A[:, :, 3] = a
out = Image.fromarray(A.clip(0, 255).astype(np.uint8), 'RGBA')
bb = out.split()[3].point(lambda v: 255 if v > 0 else 0).getbbox()
out = out.crop(bb)
out.save(f'{D}/prod_src/fridge_clean.png')
print('fridge_clean', out.size)
