// usage: node render.js file.html out.png W H [scale]
const { chromium } = require('playwright');
(async () => {
  const jobs = JSON.parse(process.argv[2]);
  const browser = await chromium.launch();
  for (const j of jobs) {
    const page = await browser.newPage({ viewport: { width: j.w, height: j.h }, deviceScaleFactor: j.scale || 1 });
    await page.goto('file://' + j.html);
    await page.evaluate(() => document.fonts.ready);
    await page.waitForTimeout(150);
    await page.screenshot({ path: j.out, clip: { x: 0, y: 0, width: j.w, height: j.h } });
    await page.close();
    console.log('rendered', j.out);
  }
  await browser.close();
})();
