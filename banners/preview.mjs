// Opens the live superi.ge homepage, swaps the main banner image for each variant
// and saves a screenshot of how it looks on the site: out/site-vN.png
// Usage: NODE_PATH=$(npm root -g) node preview.mjs [v1 v2 ...]
import { createRequire } from 'node:module';
import { readdirSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import path from 'node:path';

const { chromium } = createRequire(import.meta.url)('playwright');

const dir = path.dirname(fileURLToPath(import.meta.url));
const names = process.argv.slice(2).length
  ? process.argv.slice(2)
  : readdirSync(path.join(dir, 'out')).filter(f => /^v\d+\.webp$/.test(f)).map(f => f.replace(/\.webp$/, ''));

const browser = await chromium.launch(process.env.HTTPS_PROXY ? { proxy: { server: process.env.HTTPS_PROXY } } : {});
for (const name of names) {
  const page = await browser.newPage({ viewport: { width: 1760, height: 1000 } });
  // All requests go through Playwright's Node-side fetch (it trusts NODE_EXTRA_CA_CERTS,
  // which the sandbox's TLS proxy needs); only the main banner image is replaced.
  await page.route('**/*', async route => {
    if (route.request().url().includes('superi-desktop-banner-optimized.webp'))
      return route.fulfill({ path: path.join(dir, 'out', `${name}.webp`), contentType: 'image/webp' });
    try { await route.fulfill({ response: await route.fetch({ timeout: 30000 }) }); }
    catch { await route.abort(); }
  });
  await page.goto('https://superi.ge/', { waitUntil: 'networkidle', timeout: 90000 });
  await page.waitForTimeout(1500);
  // hide the cookie notice so it doesn't cover the page
  await page.evaluate(() => {
    for (const el of document.querySelectorAll('body *:not(script):not(style):not(noscript):not(template)'))
      if (el.children.length === 0 && el.textContent.includes('Cookie ფაილებს')) {
        let box = el;
        while (box !== document.body && getComputedStyle(box).position !== 'fixed') box = box.parentElement;
        if (box !== document.body) box.style.display = 'none';
      }
  });
  await page.screenshot({ path: path.join(dir, 'out', `site-${name}.png`) });
  console.log(`out/site-${name}.png`);
  await page.close();
}
await browser.close();
