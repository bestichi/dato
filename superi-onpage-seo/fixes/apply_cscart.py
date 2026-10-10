#!/usr/bin/env python3
"""Apply the superi.ge on-page SEO fix pack through the CS-Cart REST API.

Dry run by default: it reads the current values from the API and prints what would change.
Nothing is written unless you pass --apply. Before every write the current object is saved
to backups/<entity>-<id>.json, and `restore` puts those values back.

Setup (CS-Cart admin): Customers → Administrators → your user → "API access" → copy the key.
Then:
    export CSCART_EMAIL="admin@example.com"
    export CSCART_API_KEY="..."
    python3 apply_cscart.py categories-meta            # dry run
    python3 apply_cscart.py categories-meta --apply    # write
    python3 apply_cscart.py category-texts --only kondicionerebi --apply
    python3 apply_cscart.py pages-meta --apply
    python3 apply_cscart.py products --apply           # names, titles, meta descriptions from products-fix.csv
    python3 apply_cscart.py products-titles --apply    # optional: title length / "| Superi.ge" suffix (2 000+ products)
    python3 apply_cscart.py restore --entity categories --id 23 --apply

Standard library only (Python 3.8+).
"""
import argparse
import base64
import csv
import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

HERE = os.path.dirname(os.path.abspath(__file__))
BACKUP_DIR = os.path.join(HERE, "backups")
LANG = "ka"


class Api:
    def __init__(self, base, email, key, delay=0.5):
        self.base = base.rstrip("/") + "/api/2.0"
        token = base64.b64encode(f"{email}:{key}".encode()).decode()
        self.headers = {"Authorization": f"Basic {token}", "Content-Type": "application/json", "Accept": "application/json"}
        self.delay = delay

    def _call(self, method, path, body=None):
        url = f"{self.base}/{path}"
        if method == "GET":
            url += ("&" if "?" in url else "?") + urllib.parse.urlencode({"lang_code": LANG})
        data = json.dumps(body, ensure_ascii=False).encode("utf-8") if body is not None else None
        req = urllib.request.Request(url, data=data, method=method, headers=self.headers)
        time.sleep(self.delay)
        try:
            with urllib.request.urlopen(req, timeout=60) as resp:
                raw = resp.read().decode("utf-8")
        except urllib.error.HTTPError as e:
            raise SystemExit(f"{method} {path} → HTTP {e.code}: {e.read().decode('utf-8', 'replace')[:500]}")
        return json.loads(raw) if raw.strip() else {}

    def get(self, entity, oid):
        return self._call("GET", f"{entity}/{oid}")

    def put(self, entity, oid, fields):
        return self._call("PUT", f"{entity}/{oid}", dict(fields, lang_code=LANG))


def read_csv(name):
    with open(os.path.join(HERE, name), encoding="utf-8-sig", newline="") as fh:
        return list(csv.DictReader(fh))


def backup(entity, oid, obj):
    os.makedirs(BACKUP_DIR, exist_ok=True)
    path = os.path.join(BACKUP_DIR, f"{entity}-{oid}.json")
    if not os.path.exists(path):  # keep the oldest copy: that is the true original
        with open(path, "w", encoding="utf-8") as fh:
            json.dump(obj, fh, ensure_ascii=False, indent=1)


def short(v, n=90):
    v = "" if v is None else str(v).replace("\n", " ")
    return v if len(v) <= n else v[: n - 1] + "…"


def run_changes(api, entity, changes, apply):
    """changes: list of (oid, label, {field: new_value})"""
    done = pending = skipped = 0
    for oid, label, fields in changes:
        cur = api.get(entity, oid)
        if not cur:
            print(f"! {entity} {oid} ({label}): not found, skipped")
            skipped += 1
            continue
        diff = {k: v for k, v in fields.items() if (cur.get(k) or "").strip() != (v or "").strip()}
        if not diff:
            print(f"= {entity} {oid} ({label}): already up to date")
            continue
        pending += 1
        print(f"~ {entity} {oid} ({label})")
        for k, v in diff.items():
            print(f"    {k}: {short(cur.get(k))!r}\n      → {short(v)!r}")
        if apply:
            backup(entity, oid, cur)
            api.put(entity, oid, diff)
            after = api.get(entity, oid)
            bad = [k for k, v in diff.items() if (after.get(k) or "").strip() != (v or "").strip()]
            if bad:
                print(f"    ! after write these fields differ: {bad} (check lang_code / field names)")
            else:
                done += 1
    print(f"\n{'applied' if apply else 'would change'}: {done if apply else pending}; skipped: {skipped}"
          + ("" if apply else "\n(dry run — nothing was written; add --apply)"))


def cmd_categories_meta(api, a):
    rows = read_csv("categories-meta.csv")
    changes = []
    for r in rows:
        slug = r["url"].rstrip("/").rsplit("/", 1)[-1]
        if a.only and slug not in a.only:
            continue
        fields = {"page_title": r["page_title_ახალი"], "meta_description": r["meta_description_ახალი"]}
        if a.rename and r["სახელი/H1_შემოთავაზება"]:
            fields["category"] = r["სახელი/H1_შემოთავაზება"]
        changes.append((int(r["category_id"]), slug, fields))
    run_changes(api, "categories", changes, a.apply)


def cmd_category_texts(api, a):
    ids = {r["url"].rstrip("/").rsplit("/", 1)[-1]: int(r["category_id"]) for r in read_csv("categories-meta.csv")}
    folder = os.path.join(HERE, "category-texts")
    changes = []
    for fn in sorted(os.listdir(folder)):
        if not fn.endswith(".html"):
            continue
        slug = fn[:-5]
        if a.only and slug not in a.only:
            continue
        if slug not in ids:
            print(f"! {slug}: no category_id in categories-meta.csv, skipped")
            continue
        html = open(os.path.join(folder, fn), encoding="utf-8").read().strip()
        changes.append((ids[slug], slug, {"description": html}))
    run_changes(api, "categories", changes, a.apply)


def cmd_pages_meta(api, a):
    changes = []
    for r in read_csv("pages-meta.csv"):
        if not str(r["ID"]).isdigit():
            continue  # homepage / dispatch-based pages are set in Design → Layouts, not via the pages API
        fields = {"page_title": r["title_ახალი"], "meta_description": r["description_ახალი"]}
        if r["H1_ახალი"] and r["ობიექტი"] == "ბლოგი":
            fields["page"] = r["H1_ახალი"]
        changes.append((int(r["ID"]), r["url"], fields))
    run_changes(api, "pages", changes, a.apply)


def cmd_products(api, a):
    changes = []
    for r in read_csv("products-fix.csv"):
        if not r.get("product_id"):
            continue
        fields = {}
        if r.get("სახელი_ახალი"):
            fields["product"] = r["სახელი_ახალი"]
        if r.get("page_title_ახალი"):
            fields["page_title"] = r["page_title_ახალი"]
        if r.get("meta_description_ახალი"):
            fields["meta_description"] = r["meta_description_ახალი"]
        if a.seo_names and r.get("seo_name_ახალი"):
            fields["seo_name"] = r["seo_name_ახალი"]
        if fields:
            changes.append((int(r["product_id"]), r["url"], fields))
    run_changes(api, "products", changes, a.apply)


def cmd_products_titles(api, a):
    changes = [(int(r["product_id"]), r["url"], {"page_title": r["page_title_ახალი"]})
               for r in read_csv("products-titles-optional.csv") if r.get("product_id") and r.get("page_title_ახალი")]
    run_changes(api, "products", changes, a.apply)


def cmd_restore(api, a):
    path = os.path.join(BACKUP_DIR, f"{a.entity}-{a.id}.json")
    obj = json.load(open(path, encoding="utf-8"))
    keep = {"categories": ["category", "description", "page_title", "meta_description"],
            "pages": ["page", "description", "page_title", "meta_description"],
            "products": ["product", "page_title", "meta_description", "seo_name"]}[a.entity]
    run_changes(api, a.entity, [(a.id, "restore", {k: obj.get(k) or "" for k in keep if k in obj})], a.apply)


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("command", choices=["categories-meta", "category-texts", "pages-meta", "products", "products-titles", "restore"])
    p.add_argument("--apply", action="store_true", help="write changes (default: dry run)")
    p.add_argument("--only", nargs="*", help="limit to these category slugs")
    p.add_argument("--rename", action="store_true", help="also rename categories (H1) where a new name is proposed")
    p.add_argument("--seo-names", action="store_true", help="also change product SEO names (URLs); check 301s first")
    p.add_argument("--entity", choices=["categories", "pages", "products"])
    p.add_argument("--id", type=int)
    p.add_argument("--base", default=os.environ.get("CSCART_URL", "https://superi.ge"))
    a = p.parse_args()
    email, key = os.environ.get("CSCART_EMAIL"), os.environ.get("CSCART_API_KEY")
    if not (email and key):
        sys.exit("Set CSCART_EMAIL and CSCART_API_KEY (see the docstring at the top of this file).")
    api = Api(a.base, email, key, delay=float(os.environ.get("CSCART_DELAY", "0.5")))
    {"categories-meta": cmd_categories_meta, "category-texts": cmd_category_texts, "pages-meta": cmd_pages_meta,
     "products": cmd_products, "products-titles": cmd_products_titles, "restore": cmd_restore}[a.command](api, a)


if __name__ == "__main__":
    main()
