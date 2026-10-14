#!/usr/bin/env python3
"""Update category page titles / meta descriptions on superi.ge via the CS-Cart REST API.

Credentials come from the environment (never from the command line or the repo):
  SUPERI_API_EMAIL  - email of the CS-Cart administrator that has API access
  SUPERI_API_KEY    - that administrator's API key

Usage:
  python3 apply_titles.py              # dry run: show current vs new values, change nothing
  python3 apply_titles.py --apply      # back up current values, update, verify on the live site
  python3 apply_titles.py --rollback backups/titles-YYYYmmdd-HHMMSS.json
"""
import base64
import datetime
import json
import os
import re
import ssl
import sys
import urllib.error
import urllib.request

BASE = "https://superi.ge"
SUFFIX = " | Superi.ge"
HERE = os.path.dirname(os.path.abspath(__file__))
BACKUP_DIR = os.path.join(HERE, "backups")
# Cloudflare on superi.ge rejects the default Python-urllib signature (error 1010).
UA = "Mozilla/5.0 (compatible; superi-seo-tools/1.0)"

# category_id, public URL slug, new page title, new meta description (None = leave as is)
CHANGES = [
    (30, "gazis-gamatboblebi", "გაზის გამათბობელი 20–130 კვადრატი — ფასები | Superi.ge",
     "გაზის გამათბობელი 30, 60, 80, 100 და 120 კვადრატისთვის — Fujiyama, Gilan, Tam-Kera, Karma, AKOG. "
     "✓ ნაწილ-ნაწილ გადახდა ✓ მიწოდება მთელ საქართველოში."),
    (148, "gazqurebi", "გაზქურა — გაზქურები საუკეთესო ფასად | Superi.ge", None),
    (73, "auzebi", "აუზი — აუზები და აქსესუარები საუკეთესო ფასად | Superi.ge", None),
    (68, "mikrotalghuri-ghumelebi", "მიკროტალღური ღუმელი — ღუმელები საუკეთესო ფასად | Superi.ge", None),
    (25, "macivrebi", "მაცივარი — მაცივრები საუკეთესო ფასად | Superi.ge", None),
    (50, "eleqtro-chaidnebi", "ელექტრო ჩაიდანი — ჩაიდნები საუკეთესო ფასად | Superi.ge", None),
    (27, "tabletebi", "ტაბლეტი — ტაბლეტები საუკეთესო ფასად | Superi.ge", None),
    (33, "noutbuqebi", "ნოუთბუქი — ნოუთბუქები საუკეთესო ფასად | Superi.ge", None),
]


def ssl_context():
    for var in ("SSL_CERT_FILE", "REQUESTS_CA_BUNDLE"):
        if os.environ.get(var) and os.path.exists(os.environ[var]):
            return ssl.create_default_context(cafile=os.environ[var])
    if os.path.exists("/root/.ccr/ca-bundle.crt"):
        return ssl.create_default_context(cafile="/root/.ccr/ca-bundle.crt")
    return ssl.create_default_context()


CTX = ssl_context()


def api(method, path, body=None):
    email, key = os.environ.get("SUPERI_API_EMAIL"), os.environ.get("SUPERI_API_KEY")
    headers = {"Content-Type": "application/json", "Accept": "application/json", "User-Agent": UA}
    if email and key:
        headers["Authorization"] = "Basic " + base64.b64encode(f"{email}:{key}".encode()).decode()
    data = json.dumps(body, ensure_ascii=False).encode() if body is not None else None
    req = urllib.request.Request(BASE + "/api/" + path, data=data, method=method, headers=headers)
    try:
        with urllib.request.urlopen(req, context=CTX, timeout=60) as r:
            return json.loads(r.read().decode() or "{}")
    except urllib.error.HTTPError as e:
        msg = e.read().decode(errors="replace")[:300]
        if e.code == 401:
            sys.exit("401 Unauthorized: set SUPERI_API_EMAIL and SUPERI_API_KEY "
                     "(administrator with API access enabled).")
        sys.exit(f"{method} /api/{path} -> HTTP {e.code}: {msg}")


def public_title(slug):
    req = urllib.request.Request(f"{BASE}/{slug}/?nocache={datetime.datetime.now().timestamp()}",
                                 headers={"User-Agent": UA})
    with urllib.request.urlopen(req, context=CTX, timeout=60) as r:
        html = r.read().decode("utf-8", "replace")
    m = re.search(r"<title[^>]*>(.*?)</title>", html, re.S)
    return m.group(1).strip() if m else ""


def current(cat_id):
    c = api("GET", f"categories/{cat_id}")
    return {"page_title": c.get("page_title", ""), "meta_description": c.get("meta_description", ""),
            "category": c.get("category", "")}


def update(cat_id, fields):
    api("PUT", f"categories/{cat_id}", fields)
    after = current(cat_id)
    for k, v in fields.items():
        if after.get(k) != v:
            sys.exit(f"category {cat_id}: {k} did not save (got {after.get(k)!r})")


def main():
    args = sys.argv[1:]
    if args[:1] == ["--rollback"]:
        backup = json.load(open(args[1], encoding="utf-8"))
        for row in backup:
            update(row["category_id"], {"page_title": row["page_title"],
                                        "meta_description": row["meta_description"]})
            print(f"restored {row['slug']}: {public_title(row['slug'])}")
        return

    apply = args[:1] == ["--apply"]
    backup = []
    for cat_id, slug, title, meta in CHANGES:
        cur = current(cat_id)
        backup.append({"category_id": cat_id, "slug": slug, **cur})
        print(f"\n[{cat_id}] /{slug}/  ({cur['category']})")
        print(f"  page_title now : {cur['page_title']!r}")
        print(f"  page_title new : {title!r}")
        if meta is not None:
            print(f"  meta now       : {cur['meta_description']!r}")
            print(f"  meta new       : {meta!r}")
    if not apply:
        print("\nDry run only. Re-run with --apply to write these changes.")
        return

    os.makedirs(BACKUP_DIR, exist_ok=True)
    path = os.path.join(BACKUP_DIR, datetime.datetime.now().strftime("titles-%Y%m%d-%H%M%S.json"))
    json.dump(backup, open(path, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print(f"\nBackup written: {path}")

    for cat_id, slug, title, meta in CHANGES:
        fields = {"page_title": title}
        if meta is not None:
            fields["meta_description"] = meta
        update(cat_id, fields)
        live = public_title(slug)
        # If the store appends its own suffix, drop ours so it is not shown twice.
        if live.count("Superi.ge") > 1 and title.endswith(SUFFIX):
            update(cat_id, {"page_title": title[: -len(SUFFIX)]})
            live = public_title(slug)
        print(f"  ok /{slug}/ -> live title: {live}")


if __name__ == "__main__":
    main()
