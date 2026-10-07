// Local preview only: loads superi.ge in headless Chromium and swaps the header logo in the DOM.
const { chromium } = require('playwright');
const fs = require('fs');
const svg = fs.readFileSync('logo-horizontal-on-dark.svg');
const dataUrl = 'data:image/svg+xml;base64,' + svg.toString('base64');
const fav = 'data:image/png;base64,' + fs.readFileSync('favicon-512.png').toString('base64');
async function shoot(b, name, vp, dsf) {
  const p = await b.newPage({ viewport: vp, deviceScaleFactor: dsf });
  await p.goto('https://superi.ge/', { waitUntil: 'networkidle', timeout: 90000 });
  await p.waitForTimeout(1200);
  // hide cookie banner and floating whatsapp button for a clean shot
  await p.evaluate(() => {
    // hide only the fixed-position cookie notice (the smallest fixed element containing 'Cookie')
    [...document.querySelectorAll('body *')].filter(e => getComputedStyle(e).position === 'fixed' && /Cookie/.test(e.textContent || '') && e.getBoundingClientRect().height < 400)
      .forEach(e => e.style.display = 'none');
  });
  await p.screenshot({ path: `${name}_before.png` });
  const info = await p.evaluate(({ dataUrl, fav }) => {
    const out = [];
    document.querySelectorAll('img').forEach(i => {
      if (/superi_logo/.test(i.currentSrc || i.src)) {
        const r = i.getBoundingClientRect();
        const pic = i.closest('picture'); if (pic) pic.querySelectorAll('source').forEach(s => s.remove());
        i.removeAttribute('srcset'); i.src = dataUrl;
        const h = Math.round(r.height * 0.86);
        i.style.height = h + 'px'; i.style.width = 'auto'; i.style.maxWidth = 'none'; i.style.objectFit = 'contain';
        out.push({ w: r.width, h: r.height, newH: h });
      }
    });
    document.querySelectorAll('link[rel*="icon"]').forEach(l => l.href = fav);
    return out;
  }, { dataUrl, fav });
  await p.waitForTimeout(600);
  await p.screenshot({ path: `${name}_after.png` });
  console.log(name, JSON.stringify(info));
  await p.close();
}
(async () => {
  const proxy = process.env.HTTPS_PROXY || process.env.https_proxy;
  const b = await chromium.launch({ proxy: proxy ? { server: proxy } : undefined });
  await shoot(b, 'desktop', { width: 1440, height: 900 }, 1);
  await shoot(b, 'mobile', { width: 390, height: 844 }, 3);
  await b.close();
})();
