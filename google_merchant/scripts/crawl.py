"""Fetch superi.ge product pages and extract live product data (JSON-LD, stock, images).
Usage: python3 -I crawl.py products.csv out.jsonl [limit] [workers]
Resumable: URLs already present in out.jsonl are skipped.
"""
import csv, gzip, html, json, re, sys, time, urllib.request, urllib.error, zlib
from concurrent.futures import ThreadPoolExecutor, as_completed

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/130.0 Safari/537.36")

LD_RE = re.compile(r'<script[^>]*application/ld\+json[^>]*>(.*?)</script>', re.S)
OG_IMG_RE = re.compile(r'<meta property="og:image" content="([^"]+)"')
CANON_RE = re.compile(r'<link rel="canonical" href="([^"]+)"')
TITLE_RE = re.compile(r'<title>(.*?)</title>', re.S)
IMG_RE = re.compile(r'https://superi\.ge/images/detailed/[^"\'\s<>)]+')
STOCK_RE = re.compile(r'id="in_stock_info_\d+">\s*([^<]+)<')
OOS_RE = re.compile(r'ty-qty-out-of-stock[^>]*>\s*([^<]+)<')


def fetch(url, tries=3):
    last = None
    for i in range(tries):
        req = urllib.request.Request(url, headers={
            "User-Agent": UA, "Accept-Encoding": "gzip, deflate",
            "Accept": "text/html,application/xhtml+xml", "Accept-Language": "ka,en;q=0.8"})
        try:
            with urllib.request.urlopen(req, timeout=40) as r:
                body = r.read()
                enc = r.headers.get("Content-Encoding", "")
                if enc == "gzip":
                    body = gzip.decompress(body)
                elif enc == "deflate":
                    body = zlib.decompress(body)
                return r.status, r.geturl(), body.decode("utf-8", "replace")
        except urllib.error.HTTPError as e:
            if e.code in (429, 503) and i < tries - 1:
                time.sleep(5 * (i + 1)); last = e; continue
            return e.code, url, ""
        except Exception as e:  # network
            last = e
            time.sleep(3 * (i + 1))
    return -1, url, repr(last)


def parse(url, status, final, body):
    rec = {"url": url, "status": status, "final_url": final}
    if status != 200 or not body:
        rec["err"] = body[:200] if status == -1 else ""
        return rec
    m = TITLE_RE.search(body); rec["title"] = html.unescape(m.group(1).strip()) if m else ""
    m = CANON_RE.search(body); rec["canonical"] = m.group(1) if m else ""
    m = OG_IMG_RE.search(body); rec["og_image"] = m.group(1) if m else ""
    prod = None
    for blk in LD_RE.findall(body):
        try:
            d = json.loads(blk)
        except Exception:
            continue
        for x in (d if isinstance(d, list) else [d]):
            if isinstance(x, dict) and x.get("@type") == "Product":
                prod = x
    if prod:
        offers = prod.get("offers") or {}
        if isinstance(offers, list):
            offers = offers[0] if offers else {}
        b = prod.get("brand")
        rec.update({
            "ld_name": prod.get("name", ""),
            "ld_sku": prod.get("sku", ""),
            "ld_brand": (b.get("name", "") if isinstance(b, dict) else (b or "")),
            "ld_image": prod.get("image", ""),
            "ld_gtin": prod.get("gtin13") or prod.get("gtin") or prod.get("gtin12") or prod.get("gtin8") or "",
            "ld_mpn": prod.get("mpn", ""),
            "ld_price": offers.get("price", ""),
            "ld_currency": offers.get("priceCurrency", ""),
            "ld_avail": offers.get("availability", ""),
            "ld_condition": offers.get("itemCondition", ""),
        })
    rec["has_product_ld"] = bool(prod)
    rec["stock_text"] = sorted(set(s.strip() for s in STOCK_RE.findall(body)))[:3]
    rec["oos_text"] = sorted(set(s.strip() for s in OOS_RE.findall(body)))[:3]
    rec["add_to_cart"] = ("add_to_cart_button" in body) or ("dispatch[checkout.add" in body)
    imgs = []
    for u in IMG_RE.findall(body):
        u = u.rstrip("\\")
        if u not in imgs:
            imgs.append(u)
    rec["images"] = imgs[:15]
    return rec


def main():
    src, out = sys.argv[1], sys.argv[2]
    limit = int(sys.argv[3]) if len(sys.argv) > 3 else 0
    workers = int(sys.argv[4]) if len(sys.argv) > 4 else 6
    done = set()
    try:
        with open(out, encoding="utf-8") as f:
            for line in f:
                r = json.loads(line)
                if r.get("status") != -1:
                    done.add(r["url"])
    except FileNotFoundError:
        pass
    urls = []
    with open(src, encoding="utf-8", newline="") as f:
        for row in csv.DictReader(f, delimiter=";"):
            u = row["Product URL"].strip()
            if u and u not in done and u not in urls:
                urls.append(u)
    if limit:
        urls = urls[:limit]
    print(f"todo {len(urls)} (done {len(done)})", flush=True)
    n = 0
    with open(out, "a", encoding="utf-8") as fo, ThreadPoolExecutor(workers) as ex:
        futs = {ex.submit(fetch, u): u for u in urls}
        for fu in as_completed(futs):
            u = futs[fu]
            st, fin, body = fu.result()
            rec = parse(u, st, fin, body)
            fo.write(json.dumps(rec, ensure_ascii=False) + "\n"); fo.flush()
            n += 1
            if n % 200 == 0:
                print(n, time.strftime("%H:%M:%S"), flush=True)
    print("finished", n, flush=True)


if __name__ == "__main__":
    main()
