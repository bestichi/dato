// Screenshot a superi.ge category's subcategory grid with the new banners swapped in.
// usage: NODE_PATH=$(npm root -g) node preview_on_site.js ../<category>/banners.json [css_file|-] [viewport_width] [out.png]
// Banners are matched to subcategories by link URL (banners.json "url"), not by position.
const { chromium } = require('playwright');
const fs = require('fs'), path = require('path');

const [cfgPath, cssFile = '-', vw = '1920', outArg] = process.argv.slice(2);
const cfg = JSON.parse(fs.readFileSync(cfgPath, 'utf8'));
const dir = path.dirname(path.resolve(cfgPath));
const out = outArg || path.join(dir, 'preview.png');
const norm = u => u.replace(/\/+$/, '').toLowerCase();
const banners = Object.fromEntries(cfg.items.map(it => [norm(it.url),
  'data:image/png;base64,' + fs.readFileSync(path.join(dir, it.file + '.png')).toString('base64')]));

(async () => {
  const browser = await chromium.launch({ channel: 'chromium', proxy: process.env.HTTPS_PROXY ? { server: process.env.HTTPS_PROXY } : undefined });
  const page = await browser.newPage({ viewport: { width: +vw, height: 1000 } });
  await page.goto(cfg.category_url, { waitUntil: 'domcontentloaded', timeout: 60000 });
  await page.waitForSelector('ul.subcategories li.cat-img', { timeout: 30000 });
  const missing = await page.$$eval('ul.subcategories li.cat-img', (lis, banners) => {
    const norm = u => u.replace(/\/+$/, '').toLowerCase(), miss = [];
    for (const li of lis) {
      const a = li.querySelector('a'), img = li.querySelector('img'), src = banners[norm(a.href)];
      if (src && img) { img.removeAttribute('srcset'); img.src = src; } else miss.push(a.href);
    }
    return miss;
  }, banners);
  if (missing.length) console.log('subcategories without a banner:', missing.join(' '));
  if (cssFile !== '-') await page.addStyleTag({ content: fs.readFileSync(cssFile, 'utf8') });
  await page.evaluate(() => document.querySelectorAll('body *').forEach(el => {
    if (getComputedStyle(el).position === 'fixed') el.style.display = 'none';
  }));
  await page.waitForTimeout(1200);
  await (await page.$('ul.subcategories')).screenshot({ path: out });
  console.log('saved', out);
  await browser.close();
})().catch(e => { console.error(String(e).split('\n')[0]); process.exit(1); });
