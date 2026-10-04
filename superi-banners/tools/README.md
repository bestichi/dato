# Banner tools

`make_banners.py` turns a category's `banners.json` into the 800×800 banners next to it:
download the photo from superi.ge → optional 2× EDSR super-resolution (`"sr": true`) →
background mask with BiRefNet (photo padded with 12% white first) → card render.
Style constants live at the top of the script; keep them unchanged so every category matches.

```sh
pip install pillow numpy onnxruntime opencv-contrib-python-headless
python3 make_banners.py ../<category>/banners.json            # all items
python3 make_banners.py ../<category>/banners.json --only 03  # re-render some
```

Models download on first use into `$SUPERI_CACHE/models` (default `~/.cache/superi-banners`):
BiRefNet-general (MIT, ~1 GB, from the rembg GitHub release) and EDSR x2 (~38 MB).
Segmentation needs ~8 GB RAM and ~40 s per photo on CPU; it runs one photo per process.

The script prints the source scale for each banner. Above ~1.05 the photo is being enlarged:
set `"sr": true` for that item or pick a bigger photo of the product from its superi.ge page.

`preview_on_site.js` screenshots the live category page with the new banners swapped in
(matched by subcategory URL), optionally with `../subcategory-grid.css` applied:

```sh
NODE_PATH=$(npm root -g) node preview_on_site.js ../<category>/banners.json ../subcategory-grid.css 1920
```
