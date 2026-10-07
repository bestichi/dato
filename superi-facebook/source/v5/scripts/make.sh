#!/bin/sh
# Superi.ge final cover: build -> render (DSF 1) -> sharpen -> Facebook simulation
D=/tmp/claude-0/-home-user-dato/6fdbe81a-df64-5cba-80c4-f4ac98dc935c/scratchpad/v5/final
K=/tmp/claude-0/-home-user-dato/6fdbe81a-df64-5cba-80c4-f4ac98dc935c/scratchpad/v5/kit
export PYTHONPATH=/tmp/claude-0/-home-user-dato/6fdbe81a-df64-5cba-80c4-f4ac98dc935c/scratchpad/pylib
python3 $D/src/build_cover.py || exit 1
cd $D && NODE_PATH=$(npm root -g) node $K/render.js $D/cover.html $D/cover_raw.png 960 540 1 || exit 1
python3 -I -c "
from PIL import Image, ImageFilter
im=Image.open('$D/cover_raw.png').convert('RGB'); assert im.size==(960,540)
im.filter(ImageFilter.UnsharpMask(radius=1.0, percent=90, threshold=1)).save('$D/cover-960x540.png', optimize=True)"
python3 -I $K/fb_sim.py $D
