// usage: node render_svg.js '[{"svg":"/abs/a.svg","out":"/abs/a.png","w":1000}]'  (height from viewBox ratio)
const { chromium } = require('playwright');
const fs = require('fs');
(async () => {
  const jobs = JSON.parse(process.argv[2]);
  const browser = await chromium.launch();
  for (const j of jobs) {
    const src = fs.readFileSync(j.svg, 'utf8');
    const [, , vw, vh] = src.match(/viewBox="([^"]+)"/)[1].split(/\s+/).map(Number);
    const w = j.w, h = Math.round(w * vh / vw);
    const page = await browser.newPage({ viewport: { width: w, height: h } });
    await page.setContent(`<html><body style="margin:0;background:transparent">${src.replace(/width="[^"]+" height="[^"]+"/, `width="${w}" height="${h}"`)}</body></html>`);
    await page.screenshot({ path: j.out, omitBackground: true, clip: { x: 0, y: 0, width: w, height: h } });
    await page.close();
    console.log('rendered', j.out, w + 'x' + h);
  }
  await browser.close();
})();
