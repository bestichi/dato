"""Build a Google Merchant Center product feed from the superi.ge CS-Cart export.
Usage: python3 -I build.py <active.csv> <crawl.jsonl> <taxonomy.tsv> <outdir>
"""
import csv, hashlib, html, json, re, sys, os
from collections import Counter, defaultdict
from bs4 import BeautifulSoup
import warnings
warnings.filterwarnings('ignore')

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from catmap import gpc_for, leaf_of
from brands import canon, build_brand_index, detect_from_title, STORE_BRAND, BAD_SITE, _LINE

SRC, CRAWL, TAX, OUT = sys.argv[1:5]
IMGBAD = set()
if len(sys.argv) > 5:  # optional image check results: [id, url, status, content-type, length]
    for line in open(sys.argv[5], encoding='utf-8'):
        _id, _u, _st, _ct, _len = json.loads(line)
        if _st != 200 or not str(_ct).startswith('image/'):
            IMGBAD.add(_u)
GEO = re.compile('[Ⴀ-ჿ]')

tax = {}
for line in open(TAX, encoding='utf-8'):
    i, p = line.rstrip('\n').split('\t')
    tax[int(i)] = p

rows = list(csv.DictReader(open(SRC, encoding='utf-8', newline=''), delimiter=';'))
crawl = {}
for line in open(CRAWL, encoding='utf-8'):
    r = json.loads(line)
    crawl[r['url']] = r

# ---------------------------------------------------------------- titles
TYPO = [
    ('ტელევზორი', 'ტელევიზორი'), ('ტელევევიზორი', 'ტელევიზორი'), ('აკუმუალტორი', 'აკუმულატორი'),
    ('ორქტლის', 'ორთქლის'), ('საშორბით', 'საშრობით'), ('წვენასწური', 'წვენსაწური'), ('ხორსაკეპი', 'ხორცსაკეპი'),
    ('ჩასასენებელი', 'ჩასაშენებელი'), ('ჩასაშნებელი', 'ჩასაშენებელი'), ('ჩასაშენეებლი', 'ჩასაშენებელი'),
    ('მიკროტალღუღი', 'მიკროტალღური'), ('ნუთბუქი', 'ნოუთბუქი'), ('იმფრაწითელი გამთბობელი', 'ინფრაწითელი გამათბობელი'),
    ('ინვენტორული', 'ინვერტორული'), ('საუნდაბარი', 'საუნდბარი'), ('დისპენერი', 'დისპენსერი'),
    ('სარეცხის მანქანა', 'სარეცხი მანქანა'), ('მობილური ტელეფონ ', 'მობილური ტელეფონი '),
    ('ავერლოკის', 'ოვერლოკის'), ('Vaсuum', 'Vacuum'), ('WORLF', 'WORLD'), ('BRAAKOUT', 'BREAKOUT'),
    ('ATROCIRAPTOR', 'ATROCIRAPTOR'), ('GREYl', 'GREY'), ('VacuumCleaner', 'Vacuum Cleaner'),
    ('სტაციონალური', 'სტაციონარული'), ('ტენის ამომშრობი', 'ტენის ამომშრობი'),
]
JUNK_PREFIX = re.compile(r'^(?:(?:Notebook|Network Active|Router|Kitchen Machine|Asustek|TP-Link)\s*/\s*)+', re.I)

# Georgian product-type words that may trail a Latin-first title ("Zilan ZLN2558 ვენტილატორი")
TYPE_WORDS = ('ვენტილატორი', 'სკუტერი', 'პრინტერი', 'ფოტოაპარატი', 'დრონი', 'ბარათი', 'სავარძელი', 'უთო',
              'საწური', 'წვენსაწური', 'ჩოფერი', 'კომბაინი', 'აპარატი', 'რადიატორი', 'ყურსასმენი', 'ტელეფონი',
              'მაუსი', 'კლავიატურა', 'მონიტორი', 'ნოუთბუქი', 'პროექტორი', 'კომპრესორი', 'გაზონსაკრეჭი',
              'საათი', 'ტაბლეტი', 'მტვერსასრუტი', 'დამტენი', 'ტელევიზორი', 'როუტერი', 'მაცივარი', 'ჩანთა',
              'კომპიუტერი', 'სისტემა')

# category leaf -> Georgian type to prefix when the title has no Georgian at all
PREFIX_TYPE = {
    'მობილური ტელეფონები': 'მობილური ტელეფონი', 'ყურსასმენები': 'ყურსასმენი', 'მაუსები': 'მაუსი',
    'კლავიატურები': 'კლავიატურა', 'პორტატული დამტენები': 'პორტატული დამტენი', 'მტვერსასრუტები': 'მტვერსასრუტი',
    'SMART WATCHES': 'სმარტ საათი', 'როუტერები': 'როუტერი', 'ტაბლეტები': 'ტაბლეტი', 'ნოუთბუქები': 'ნოუთბუქი',
    'GAMING მაგიდა-სავარძლები': 'გეიმინგ სავარძელი', 'სათამაშოები': 'კონსტრუქტორი', 'სკუტერები': 'ელექტრო სკუტერი',
    'დრონი': 'დრონი', 'ტელევიზორები': 'ტელევიზორი', 'ტელევიზორის აქსესუარები': 'საუნდბარი',
    'გაზის გამათბობლები': 'გაზის გამათბობელი', 'ელექტრო გამათბობლები': 'ზეთის რადიატორი',
    'კონდიციონერები': 'კონდიციონერი', 'თმის უთო/სტაილერი': 'თმის სტაილერი', 'მონობლოკები All in One': 'მონობლოკი',
    'სამზარეულოს კომბაინები': 'სამზარეულოს კომბაინი', 'ყავის აპარატები': 'ყავის აპარატი',
    'პრინტერები და მრავალფუნქციური მოწყობილობები': 'პრინტერი', 'პროექტორები და აქსესუარები': 'პროექტორის სამაგრი',
    'პროექტორი': 'პროექტორი', 'გამწოვი': 'გამწოვი', 'მაცივრები': 'მაცივარი',
}
PREFIX_OVERRIDE = [  # (leaf, regex, type)
    ('მაუსები', r'keyboard|კლავიატურ', 'კლავიატურა და მაუსი'),
    ('კლავიატურები', r'combo|mouse|\bset\b|\bmk\d|km-\d', 'კლავიატურა და მაუსი'),
    ('მტვერსასრუტები', r'window', 'ფანჯრის საწმენდი რობოტი'),
    ('მტვერსასრუტები', r'robot', 'რობოტი მტვერსასრუტი'),
    ('SMART WATCHES', r'kids', 'ბავშვის სმარტ საათი'),
    ('როუტერები', r'mobile wi-?fi', 'მობილური როუტერი'),
    ('GAMING მაგიდა-სავარძლები', r'playseat|cockpit|simulator|racing', 'სარბოლო სიმულატორის სავარძელი'),
    ('თმის უთო/სტაილერი', r'airstrait|straightener', 'თმის გასასწორებელი'),
    ('კონსოლები და აქსესუარები', r'legion go', 'პორტატული სათამაშო კონსოლი'),
    ('კონსოლები და აქსესუარები', r'quest', 'ვირტუალური რეალობის სათვალე'),
    ('კონსოლები და აქსესუარები', r'playstation 5|ps5|xbox', 'სათამაშო კონსოლი'),
]
PREFIX_OVERRIDE = [(l, re.compile(p, re.I), t) for l, p, t in PREFIX_OVERRIDE]


def clean_title(raw, leaf, gtin):
    t = html.unescape(raw).replace(' ', ' ').replace('\t', ' ')
    t = JUNK_PREFIX.sub('', t.strip())
    for a, b in TYPO:
        t = t.replace(a, b)
    if gtin:
        t = re.sub(r'\s*\(\s*' + gtin.lstrip('0') + r'\s*\)', '', t)
        t = re.sub(r'\s*\(\s*0*' + gtin.lstrip('0') + r'\s*\)', '', t)
    t = re.sub(r'\s*[|·]\s*', ' ', t)
    t = re.sub(r'\s*,\s*', ', ', t)
    t = re.sub(r'\(\s*\)', '', t)
    t = re.sub(r'\s+', ' ', t).strip(' ,.-|:/')
    if not GEO.search(t):
        typ = None
        for l, rx, ty in PREFIX_OVERRIDE:
            if l == leaf and rx.search(t):
                typ = ty
                break
        typ = typ or PREFIX_TYPE.get(leaf)
        if typ:
            t = typ + ' ' + t
    elif not GEO.match(t):
        # Latin-first title with a trailing Georgian product type -> move type to the front
        m = re.match(r'^(.*?[A-Za-z0-9\)\]"”\'’.%+])\s+([Ⴀ-ჿ][Ⴀ-ჿ\s\-]*)$', t)
        if m and any(w in m.group(2) for w in TYPE_WORDS):
            t = m.group(2).strip() + ' ' + m.group(1).strip()
    t = re.sub(r'\s+', ' ', t).strip()
    if len(t) > 150:
        t = t[:150].rsplit(' ', 1)[0].rstrip(' ,.-|:/')
    return t


def brand_case_in_title(t, brand):
    if not brand or brand == STORE_BRAND:
        return t
    rx = re.compile(r'(?<![A-Za-z0-9])' + re.escape(brand) + r'(?![A-Za-z0-9])', re.I)
    m = rx.search(t)
    if m and m.group(0) != brand and m.group(0).isupper():
        t = t[:m.start()] + brand + t[m.end():]
    return t

# ---------------------------------------------------------------- descriptions
PROMO = re.compile(r'(უფასო მიწოდებ\w*|free shipping|ფასდაკლებ\w*|აქცია\w*|განვადებ\w*)', re.I)


def clean_desc(raw):
    if not raw.strip():
        return ''
    soup = BeautifulSoup(raw, 'lxml')
    for tag in soup(['script', 'style', 'iframe', 'img', 'video', 'object', 'embed']):
        tag.decompose()
    for tag in soup.find_all(['strong', 'b', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6']):
        txt = tag.get_text(' ', strip=True)
        nxt = tag.next_sibling
        while nxt is not None and isinstance(nxt, str) and not nxt.strip():
            nxt = nxt.next_sibling
        heading = tag.name.startswith('h') or (getattr(nxt, 'name', None) in ('br', 'ul', 'ol', None))
        if txt and heading and not txt.endswith((':', '.', '!', '?')):
            tag.append(':')
    for blk in soup.find_all(['p', 'div', 'ul', 'ol', 'table', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6']):
        blk.append(' \u2029 ')
    for br in soup.find_all('br'):
        br.replace_with(' ')
    for li in soup.find_all('li'):
        li.insert_before(' • ')
    for td in soup.find_all(['td', 'th']):
        td.append(' ')
    for tr in soup.find_all('tr'):
        tr.append('; ')
    text = soup.get_text(' ')
    text = html.unescape(text).replace(' ', ' ')
    text = re.sub(r'https?://\S+|www\.\S+', '', text)
    text = re.sub(r'[\r\n\t]+', ' ', text)
    text = re.sub(r'\s*\u2029[\s\u2029]*', '\u2029', text).strip('\u2029 ')
    text = re.sub(r'([.:;!?])\u2029', r'\1 ', text)
    text = text.replace('\u2029', '. ')
    text = re.sub(r'\s+([:;,.])', r'\1', text)
    text = re.sub(r'([:;,])(?=\S)', r'\1 ', text) if False else text
    text = re.sub(r'(\s*•\s*){2,}', ' • ', text)
    text = re.sub(r'\s*;\s*(;\s*)+', '; ', text)
    text = re.sub(r'\s+', ' ', text).strip(' ;')
    return text


def clip(text, n=5000):
    if len(text) <= n:
        return text
    cut = text[:n]
    for sep in ('. ', ' • ', '; ', ' '):
        i = cut.rfind(sep)
        if i > n * 0.6:
            return cut[:i].rstrip(' •;')
    return cut

# ---------------------------------------------------------------- identifiers
def gtin_ok(s):
    if not re.fullmatch(r'\d{8}|\d{12,14}', s or ''):
        return False
    d = [int(c) for c in s]
    chk = d[-1]
    body = d[:-1][::-1]
    tot = sum(x * (3 if i % 2 == 0 else 1) for i, x in enumerate(body))
    if (10 - tot % 10) % 10 != chk:
        return False
    if len(s) == 8:
        return s[0] not in '02' and len(set(s)) > 1
    s13 = s.zfill(13) if len(s) <= 13 else s[1:]
    # GS1 restricted-circulation (02x, 04x, 2xx), coupons (05x, 98x, 99x) and padding-only numbers
    if s13[0] == '2' or s13[:2] in ('02', '04', '05') or s13[:2] in ('98', '99') or s13.startswith('00000'):
        return False
    if len(set(s)) == 1:
        return False
    return True


def find_gtin(code, title, desc_html, ld_gtin):
    cands = []
    if ld_gtin:
        cands.append(str(ld_gtin).strip())
    if re.fullmatch(r'\d{12,14}', code or ''):
        cands.append(code)
    for m in re.finditer(r'\((\d{8}|\d{12,14})\)', title):
        cands.append(m.group(1))
    for m in re.finditer(r'(?:EAN|GTIN|UPC|შტრიხ[\w-]*|მოდელი|არტიკული|კოდი)[^0-9]{0,25}(\d{8}|\d{12,14})(?!\d)', desc_html, re.I):
        cands.append(m.group(1))
    for c in cands:
        if gtin_ok(c):
            return c
    return ''


MODEL_RE = re.compile(r'მოდელი\s*:\s*([^<•\n]{2,60})')


UNIT_TOKEN = re.compile(r'^\(?\d+([.,]\d+)?(GB|TB|MB|W|KW|L|ML|KG|G|MAH|V|HZ|CM|MM|M|HP|PCS|BAR|PA|LM|"|\'\')\)?$|^\d+/\d+(GB|TB)?$|GB/', re.I)


def mpn_from_title(title, brand):
    m = re.search(r'(?<![A-Za-z0-9])' + re.escape(brand) + r'\s+(\S+)', title, re.I)
    if not m:
        return ''
    tok = m.group(1).strip(',;()')
    if (re.fullmatch(r'[A-Za-z0-9][A-Za-z0-9\-./+]{3,39}', tok) and re.search(r'\d', tok)
            and re.search(r'[A-Za-z]', tok) and not UNIT_TOKEN.search(tok)):
        return tok
    return ''


MFR_RE = re.compile(r'(?:მწარმოებლის კოდი|Part Number|MPN|P/N)\s*:\s*([A-Za-z0-9][A-Za-z0-9\-./+ ]{2,40}?)\s*(?:<|•|$)', re.I)


def find_mpn(desc_html, title):
    mm = MFR_RE.search(desc_html)
    if mm:
        v = html.unescape(mm.group(1)).strip(' .;,')
        if re.search(r'\d', v) and re.search(r'[A-Za-z]', v) and len(v.split()) <= 2:
            return v
    m = MODEL_RE.search(desc_html)
    if not m:
        return ''
    v = html.unescape(m.group(1)).replace(' ', ' ').strip(' .;,')
    if GEO.search(v) or not re.search(r'\d', v) or not re.search(r'[A-Za-z]', v) or len(v) > 40:
        return ''
    if len(v.split()) > 3:
        return ''
    norm = lambda s: re.sub(r'[\s\-_/.]', '', s.lower())
    if norm(v) not in norm(title):
        return ''
    return v

# ---------------------------------------------------------------- main
def enc_url(u):
    from urllib.parse import quote
    return quote(u.strip(), safe=":/?&=%#@+;~-._!$'()*[]")


def fmt_price(v):
    return f'{v:.2f} GEL'


def url_slug(u):
    return u.rstrip('/').rsplit('/', 1)[-1]


code_count = Counter(r['Product code'].strip() for r in rows)
all_site_brands = {canon(c.get('ld_brand', '')) for c in crawl.values()}
brand_index = [(rx, b) for rx, b in build_brand_index(all_site_brands)
               if rx.pattern.lower().find('oz') < 0 or len(b) > 2]
brand_index = [(rx, b) for rx, b in brand_index if b not in ('OZ', 'Oz', 'UD', 'LEO', 'Karma')]

feed, skipped, review = [], [], []
seen_ids = set()
stats = Counter()
for r in rows:
    url = r['Product URL'].strip()
    c = crawl.get(url, {})
    code = r['Product code'].strip()
    name = r['Product name'].strip()
    cat = r['Category'].strip()
    leaf = leaf_of(cat)
    reason = None
    if not c:
        reason = 'გვერდი ვერ შემოწმდა'
    elif c.get('status') != 200:
        reason = f'გვერდი არ იხსნება (HTTP {c.get("status")})'
    elif not c.get('has_product_ld'):
        reason = 'გვერდზე პროდუქტის მონაცემები არ არის'
    if not name:
        reason = reason or 'დასახელება ცარიელია'
    try:
        csv_price = float(r['Price'] or 0)
    except ValueError:
        csv_price = 0.0
    site_price = None
    if c.get('ld_price') not in (None, ''):
        try:
            site_price = float(c['ld_price'])
        except (TypeError, ValueError):
            site_price = None
    price_now = site_price if site_price is not None else csv_price
    if not reason and price_now <= 0:
        reason = 'ფასი 0'
    if reason:
        skipped.append({'Product code': code, 'Product name': name, 'Product URL': url, 'მიზეზი': reason})
        continue

    # identifiers
    gtin = find_gtin(code, name, r['Description'], c.get('ld_gtin', ''))
    # brand
    raw_sb = (c.get('ld_brand') or '').strip()
    sb = '' if raw_sb.split('|')[0].strip().lower() in BAD_SITE else canon(raw_sb)
    tb = detect_from_title(html.unescape(name), brand_index)
    brand_src = ''
    if sb and tb and sb != tb:
        sb_rx = re.compile(r'(?<![A-Za-z0-9])' + re.sub(r'(\\ |\\-|-| )', r'[\\s\\-]*', re.escape(sb)) + r'(?![A-Za-z0-9])', re.I)
        if detect_from_title(html.unescape(name), []) == tb:
            brand, brand_src = tb, 'title-line'      # Amazfit, Mibro, Segway ... more specific than site value
        elif sb_rx.search(name) or sb.lower().startswith(tb.lower()):
            brand, brand_src = sb, 'site'            # site brand confirmed by the title
        else:
            brand, brand_src = tb, 'title-fix'       # site brand contradicts the title -> trust the title
        review.append((code, name, raw_sb, sb, tb, brand))
    elif sb:
        brand, brand_src = sb, 'site'
    elif tb:
        brand, brand_src = tb, 'title'
    else:
        brand, brand_src = STORE_BRAND, 'store'
    stats['brand_' + brand_src] += 1

    title = clean_title(name, leaf, gtin)
    title = brand_case_in_title(title, brand)
    mpn = ''
    if brand != STORE_BRAND:
        mpn = find_mpn(r['Description'], name) or mpn_from_title(title, brand)
        if mpn and gtin and mpn == gtin:
            mpn = ''

    desc = clean_desc(r['Description'])
    if PROMO.search(desc):
        stats['desc_promo_removed'] += 1
        desc = PROMO.sub('', desc)
        desc = re.sub(r'\s+', ' ', desc).strip()
    if len(desc) < 30 or desc.strip().lower() == title.lower():
        pt = ' > '.join(p.strip() for p in cat.split('///') if p.strip())
        desc = f'{title}. ბრენდი: {brand}. კატეგორია: {pt}.'
        stats['desc_generated'] += 1
    desc = clip(desc)

    # id
    pid = code
    if not pid or code_count[code] > 1 or not re.fullmatch(r'[A-Za-z0-9._\-]{1,50}', pid) or pid in seen_ids:
        pid = (re.sub(r'[^A-Za-z0-9._\-]', '', code) or 'SG') + '-' + hashlib.md5(url.encode()).hexdigest()[:6]
        stats['id_rebuilt'] += 1
    seen_ids.add(pid)

    # images
    main_img = c.get('ld_image') or c.get('og_image') or r['Image URL'].strip()
    if isinstance(main_img, list):
        main_img = main_img[0] if main_img else ''
    main_img = enc_url(main_img)
    extra = []
    for u in c.get('images', []):
        u = enc_url(u)
        if u != main_img and u not in extra:
            extra.append(u)
    extra = extra[:10]
    if main_img in IMGBAD:
        alt = [u for u in extra if u not in IMGBAD]
        if alt:
            main_img, extra = alt[0], alt[1:]
            stats['image_replaced'] += 1
        else:
            skipped.append({'Product code': code, 'Product name': name, 'Product URL': url,
                            'მიზეზი': 'მთავარი სურათი არ იხსნება'})
            continue

    # prices
    try:
        list_price = float(r['List price'] or 0)
    except ValueError:
        list_price = 0.0
    if site_price is not None and abs(site_price - csv_price) > 0.009:
        stats['price_from_site'] += 1
    if list_price > price_now + 0.009:
        price, sale = list_price, price_now
    else:
        price, sale = price_now, None

    avail_raw = (c.get('ld_avail') or '').rsplit('/', 1)[-1].lower()
    avail = {'instock': 'in_stock', 'outofstock': 'out_of_stock', 'preorder': 'preorder',
             'backorder': 'backorder', 'soldout': 'out_of_stock', 'discontinued': 'out_of_stock'}.get(avail_raw, 'in_stock')

    gpc = gpc_for(cat, title + ' ' + name)
    if gpc not in tax:
        raise SystemExit(f'unknown GPC {gpc} for {cat} / {name}')

    link = c.get('final_url') or url
    product_type = ' > '.join(p.strip() for p in cat.split('///') if p.strip())

    if gtin:
        ident = ''
    elif brand != STORE_BRAND and mpn:
        ident = ''
    else:
        ident = 'no'
    feed.append({
        'id': pid, 'title': title, 'description': desc, 'link': link, 'image_link': main_img,
        'additional_image_link': ','.join(extra), 'availability': avail, 'price': fmt_price(price),
        'sale_price': fmt_price(sale) if sale is not None else '', 'condition': 'new', 'brand': brand,
        'gtin': gtin, 'mpn': mpn, 'identifier_exists': ident, 'google_product_category': str(gpc),
        'product_type': product_type,
        # review-only (not uploaded)
        '_gpc_path': tax[gpc], '_orig_name': name, '_orig_code': code, '_brand_src': brand_src,
    })

os.makedirs(OUT, exist_ok=True)
json.dump({'feed': feed, 'skipped': skipped, 'review': review, 'stats': stats},
          open(os.path.join(OUT, 'feed.json'), 'w', encoding='utf-8'), ensure_ascii=False)
print('feed', len(feed), 'skipped', len(skipped), dict(stats))
print('brand disagreements', len(review))
