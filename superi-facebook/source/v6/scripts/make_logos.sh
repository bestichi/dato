#!/bin/sh
# Superi.ge logo pack: SVG sources -> PNG renders (Chrome, transparent) -> favicon.ico
D=/tmp/claude-0/-home-user-dato/6fdbe81a-df64-5cba-80c4-f4ac98dc935c/scratchpad/v5/final
R="node $D/src/render_t.js"
export NODE_PATH=$(npm root -g)
python3 -I $D/src/logo_build.py || exit 1
$R $D/logo/logo-badge.svg $D/logo/logo-badge-1080.png 1080 1080 0
for s in on-dark on-light; do
  WH=$(python3 -I -c "import re;t=open('$D/logo/logo-horizontal-$s.svg').read();m=re.search(r'width=\"(\d+)\" height=\"(\d+)\"',t);print(m.group(1),m.group(2))")
  $R $D/logo/logo-horizontal-$s.svg $D/logo/logo-horizontal-$s.png $WH 1
done
for n in 16 32 48 512; do $R $D/work/fav/fav-$n.svg $D/work/fav/fav-$n.png $n $n 1; done
python3 -I -c "
from PIL import Image
D='$D'
ims={n: Image.open(f'{D}/work/fav/fav-{n}.png').convert('RGBA') for n in (16,32,48,512)}
ims[512].save(f'{D}/logo/favicon-512.png', optimize=True)
ims[48].save(f'{D}/logo/favicon.ico', format='ICO', sizes=[(16,16),(32,32),(48,48)], append_images=[ims[16], ims[32]])
ico=Image.open(f'{D}/logo/favicon.ico'); print('ico sizes', sorted(ico.info.get('sizes', [])))
"
cp $D/logo/logo-badge-1080.png $D/logo-badge-1080.png
