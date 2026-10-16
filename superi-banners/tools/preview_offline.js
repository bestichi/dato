// Preview a banners.json on a saved superi.ge category page with the site's real stylesheet (no live site needed).
// usage: node preview_offline.js <saved_page.html> <site.css> <banners.json> <grid.css> <out.png> [width]
const { chromium } = require('playwright');
const fs = require('fs'), path = require('path');
const [pageFile, siteCss, cfgPath, gridCss, out, vw = '1920'] = process.argv.slice(2);
const cfg = JSON.parse(fs.readFileSync(cfgPath, 'utf8'));
const dir = path.dirname(path.resolve(cfgPath));
const esc = s => s.replace(/&/g, '&amp;').replace(/</g, '&lt;');
const lis = cfg.items.map(it => {
  const uri = 'data:image/png;base64,' + fs.readFileSync(path.join(dir, it.file + '.png')).toString('base64');
  return `<li class="ty-subcategories__item cat-img"> <a href="${it.url}"> <img class="ty-pict ty-subcategories-img cm-image" alt="" src="${uri}" width="300" height="300"> <span >${esc(it.label)}</span> </a> </li>`;
}).join(' ');
let html = fs.readFileSync(pageFile, 'utf8');
html = html.replace(/(<ul class="subcategories clearfix">)[\s\S]*?(<\/ul>)/, `$1 ${lis} $2`);
html = html.replace('</head>', `<style>${fs.readFileSync(gridCss, 'utf8')}</style></head>`);
(async () => {
  const browser = await chromium.launch({ channel: 'chromium' });
  const page = await browser.newPage({ viewport: { width: +vw, height: 1000 } });
  await page.route('**/*', r => {
    const u = r.request().url();
    if (u === 'https://superi.ge/__preview__/') return r.fulfill({ status: 200, contentType: 'text/html; charset=utf-8', body: html });
    if (/standalone\.[0-9a-f]+\.css/.test(u)) return r.fulfill({ status: 200, contentType: 'text/css', body: fs.readFileSync(siteCss, 'utf8') });
    return r.abort();
  });
  await page.goto('https://superi.ge/__preview__/', { waitUntil: 'domcontentloaded' });
  await page.evaluate(() => document.querySelectorAll('body *').forEach(el => {
    if (getComputedStyle(el).position === 'fixed') el.style.display = 'none'; }));
  await page.waitForTimeout(800);
  await (await page.$('ul.subcategories')).screenshot({ path: out });
  console.log('saved', out);
  await browser.close();
})().catch(e => { console.error(String(e).split('\n')[0]); process.exit(1); });
