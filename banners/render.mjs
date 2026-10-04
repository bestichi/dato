// Renders every banner HTML file to PNG at 3200x800 (2x of the 1600x400 layout).
// Usage: NODE_PATH=$(npm root -g) node render.mjs [v1 v2 ...]   (no args = all v*.html files)
import { createRequire } from 'node:module';
import { readdirSync } from 'node:fs';
import { fileURLToPath, pathToFileURL } from 'node:url';
import path from 'node:path';

const { chromium } = createRequire(import.meta.url)('playwright'); // CJS require honours NODE_PATH

const dir = path.dirname(fileURLToPath(import.meta.url));
const names = process.argv.slice(2).length
  ? process.argv.slice(2)
  : readdirSync(dir).filter(f => /^v\d+.*\.html$/.test(f)).map(f => f.replace(/\.html$/, ''));

const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1600, height: 400 }, deviceScaleFactor: 2 });
for (const name of names) {
  await page.goto(pathToFileURL(path.join(dir, `${name}.html`)).href);
  await page.evaluate(() => document.fonts.ready);
  await page.screenshot({ path: path.join(dir, 'out', `${name}.png`) });
  console.log(`out/${name}.png`);
}
await browser.close();
