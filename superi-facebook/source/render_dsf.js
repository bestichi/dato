// node render_dsf.js html out w h dsf
const { chromium } = require('playwright');
(async () => {
  const [html, out, w, h, dsf] = process.argv.slice(2);
  const b = await chromium.launch();
  const p = await b.newPage({ viewport: { width: +w, height: +h }, deviceScaleFactor: +dsf });
  await p.goto('file://' + html); await p.evaluate(() => document.fonts.ready); await p.waitForTimeout(150);
  await p.screenshot({ path: out }); await b.close(); console.log('ok', out);
})();
