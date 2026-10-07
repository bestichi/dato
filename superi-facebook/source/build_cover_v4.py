"""Render the 960x540 cover and pre-sharpen it.

Facebook serves the page cover at 960px wide and the browser stretches it
(to 1250 CSS px, x1.25 on 125% Windows scaling = 1562px), so the cover is
drawn natively at 960px and given a light unsharp mask to survive that
stretch. Run from this folder:  python3 build_cover_v4.py
"""
import os, subprocess
from PIL import Image, ImageFilter

here = os.path.dirname(os.path.abspath(__file__))
os.makedirs(f"{here}/out", exist_ok=True)
raw, final = f"{here}/out/cover_v4_raw.png", f"{here}/out/cover-960x540.png"
subprocess.run(["node", f"{here}/render_dsf.js", f"{here}/cover_a_v4_960.html", raw, "960", "540", "1"], check=True)
Image.open(raw).convert("RGB").filter(ImageFilter.UnsharpMask(radius=1.0, percent=90, threshold=1)).save(final, optimize=True)
print("saved", final)
