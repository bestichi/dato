// node render_t.js <abs html|svg> <abs out.png> w h [transparent=1] [dsf=1]
const { chromium } = require('playwright');
(async () => {
  const [src, out, w, h, tr, dsf] = process.argv.slice(2);
  const b = await chromium.launch();
  const p = await b.newPage({ viewport: { width: +w, height: +h }, deviceScaleFactor: +(dsf || 1) });
  await p.goto('file://' + src); await p.evaluate(() => document.fonts && document.fonts.ready); await p.waitForTimeout(120);
  await p.screenshot({ path: out, omitBackground: tr === '1' }); await b.close(); console.log('ok', out);
})();
