#!/usr/bin/env python3
"""Daily Google Merchant Center feed for superi.ge.

Reads the CS-Cart "GOOGLE" data-feed export (CSV, ';'-separated, UTF-8) and applies the same
cleaning as the hand-made feed: only Status=A products, Google product categories, brands,
GTIN/MPN, cleaned titles and descriptions, full-size images and sale prices. The result is
written as a tab-separated file that Merchant Center fetches on a schedule.

Usage:
    python3 superi_feed.py --csv /path/products_GOOGLE.csv --out /path/to/public/google-feed

Needs only the Python 3.8+ standard library. catmap.py, brands.py and
google_taxonomy_2021-09-21.tsv must sit next to this file.

The previous feed in --out is read before it is replaced: brands, GTINs and extra images found
earlier are carried forward. If the new export looks broken (not UTF-8, unreadable Georgian
text, or far fewer products than yesterday) nothing is overwritten and the exit code is 2.
"""
import argparse, csv, datetime, hashlib, html, os, re, sys
from collections import Counter
from html.parser import HTMLParser
from urllib.parse import quote

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from catmap import gpc_for, leaf_of, CAT  # noqa: E402
from brands import canon, build_brand_index, detect_from_title, STORE_BRAND, BAD_SITE  # noqa: E402

FEED_NAME = 'superi_google_merchant_feed.tsv'
REPORT_NAME = 'superi_google_merchant_feed_report.txt'
COLS = ['id', 'title', 'description', 'link', 'image_link', 'additional_image_link', 'availability', 'price',
        'sale_price', 'condition', 'brand', 'gtin', 'mpn', 'identifier_exists', 'google_product_category',
        'product_type']
GEO = re.compile('[Ⴀ-ჿ]')

# ---------------------------------------------------------------- titles
TYPO = [
    ('ტელევზორი', 'ტელევიზორი'), ('ტელევევიზორი', 'ტელევიზორი'), ('აკუმუალტორი', 'აკუმულატორი'),
    ('ორქტლის', 'ორთქლის'), ('საშორბით', 'საშრობით'), ('წვენასწური', 'წვენსაწური'), ('ხორსაკეპი', 'ხორცსაკეპი'),
    ('ჩასასენებელი', 'ჩასაშენებელი'), ('ჩასაშნებელი', 'ჩასაშენებელი'), ('ჩასაშენეებლი', 'ჩასაშენებელი'),
    ('მიკროტალღუღი', 'მიკროტალღური'), ('ნუთბუქი', 'ნოუთბუქი'), ('იმფრაწითელი გამთბობელი', 'ინფრაწითელი გამათბობელი'),
    ('ინვენტორული', 'ინვერტორული'), ('საუნდაბარი', 'საუნდბარი'), ('დისპენერი', 'დისპენსერი'),
    ('სარეცხის მანქანა', 'სარეცხი მანქანა'), ('მობილური ტელეფონ ', 'მობილური ტელეფონი '),
    ('ავერლოკის', 'ოვერლოკის'), ('Vaсuum', 'Vacuum'), ('WORLF', 'WORLD'), ('BRAAKOUT', 'BREAKOUT'),
    ('GREYl', 'GREY'), ('VacuumCleaner', 'Vacuum Cleaner'), ('სტაციონალური', 'სტაციონარული'),
]
JUNK_PREFIX = re.compile(r'^(?:(?:Notebook|Network Active|Router|Kitchen Machine|Asustek|TP-Link)\s*/\s*)+', re.I)
TYPE_WORDS = ('ვენტილატორი', 'სკუტერი', 'პრინტერი', 'ფოტოაპარატი', 'დრონი', 'ბარათი', 'სავარძელი', 'უთო',
              'საწური', 'წვენსაწური', 'ჩოფერი', 'კომბაინი', 'აპარატი', 'რადიატორი', 'ყურსასმენი', 'ტელეფონი',
              'მაუსი', 'კლავიატურა', 'მონიტორი', 'ნოუთბუქი', 'პროექტორი', 'კომპრესორი', 'გაზონსაკრეჭი',
              'საათი', 'ტაბლეტი', 'მტვერსასრუტი', 'დამტენი', 'ტელევიზორი', 'როუტერი', 'მაცივარი', 'ჩანთა',
              'კომპიუტერი', 'სისტემა', 'ლეპტოპი', 'ტაბი', 'ჩაიდანი', 'მიქსერი', 'ბლენდერი', 'ტოსტერი',
              'ბილიკი', 'სტაილერი', 'კონდიციონერი', 'პროცესორი', 'მანქანა', 'გამათბობელი', 'გამაცხელებელი',
              'სეტი', 'საჭრელი')
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
    'AirPods-ის ქეისები': 'AirPods-ის ქეისი', 'სმარტ საათები': 'სმარტ საათი', 'დინამიკები': 'დინამიკი',
    'მობილურის ქეისები': 'მობილურის ქეისი', 'მეხსიერება SSD/HDD': 'SSD დისკი',
}
PREFIX_OVERRIDE = [(l, re.compile(p, re.I), t) for l, p, t in [
    ('მაუსები', r'keyboard|კლავიატურ', 'კლავიატურა და მაუსი'),
    ('კლავიატურები', r'combo|mouse|\bset\b|\bmk\d|km-\d', 'კლავიატურა და მაუსი'),
    ('მტვერსასრუტები', r'window', 'ფანჯრის საწმენდი რობოტი'),
    ('მტვერსასრუტები', r'robot', 'რობოტი მტვერსასრუტი'),
    ('SMART WATCHES', r'kids', 'ბავშვის სმარტ საათი'),
    ('სმარტ საათები', r'kids', 'ბავშვის სმარტ საათი'),
    ('მეხსიერება SSD/HDD', r'\bhdd\b|hard drive', 'მყარი დისკი'),
    ('მეხსიერება SSD/HDD', r'flash', 'ფლეშ მეხსიერება'),
    ('როუტერები', r'mobile wi-?fi', 'მობილური როუტერი'),
    ('GAMING მაგიდა-სავარძლები', r'playseat|cockpit|simulator|racing', 'სარბოლო სიმულატორის სავარძელი'),
    ('თმის უთო/სტაილერი', r'airstrait|straightener', 'თმის გასასწორებელი'),
    ('კონსოლები და აქსესუარები', r'legion go', 'პორტატული სათამაშო კონსოლი'),
    ('კონსოლები და აქსესუარები', r'quest', 'ვირტუალური რეალობის სათვალე'),
    ('კონსოლები და აქსესუარები', r'playstation 5|ps5|xbox', 'სათამაშო კონსოლი'),
]]


def clean_title(raw, leaf, gtin):
    t = html.unescape(raw).replace(' ', ' ').replace('\t', ' ')
    t = JUNK_PREFIX.sub('', t.strip())
    for a, b in TYPO:
        t = t.replace(a, b)
    if gtin:
        t = re.sub(r'\s*\(\s*0*' + gtin.lstrip('0') + r'\s*\)', '', t)
    t = re.sub(r'\s*[|·]\s*', ' ', t)
    t = re.sub(r'\s*,\s*', ', ', t)
    t = re.sub(r'\(\s*\)', '', t)
    t = re.sub(r'\s+', ' ', t).strip(' ,.-|:/')
    if not GEO.search(t):
        typ = next((ty for l, rx, ty in PREFIX_OVERRIDE if l == leaf and rx.search(t)), None) or PREFIX_TYPE.get(leaf)
        if typ:
            t = typ + ' ' + t
    elif not GEO.match(t):
        m = re.match(r'^(.*?[A-Za-z0-9\)\]"”\'’.%+]),?\s+([Ⴀ-ჿ][Ⴀ-ჿ\s\-]*)$', t)
        if m and any(w in m.group(2) for w in TYPE_WORDS):
            t = m.group(2).strip() + ' ' + m.group(1).strip()
    t = re.sub(r'\s+', ' ', t).strip()
    if len(t) > 150:
        t = t[:150].rsplit(' ', 1)[0].rstrip(' ,.-|:/')
    return t


def brand_case_in_title(t, brand):
    if not brand or brand == STORE_BRAND:
        return t
    m = re.search(r'(?<![A-Za-z0-9])' + re.escape(brand) + r'(?![A-Za-z0-9])', t, re.I)
    if m and m.group(0) != brand and m.group(0).isupper():
        t = t[:m.start()] + brand + t[m.end():]
    return t

# ---------------------------------------------------------------- descriptions (HTML -> plain text)
PROMO = re.compile(r'(უფასო მიწოდებ\w*|free shipping|ფასდაკლებ\w*|აქცია\w*|განვადებ\w*)', re.I)
BLOCK, BR, LIST, HEND, HHEAD = ' ', '\x01', '\x03', '\x02', '\x04'


class _Text(HTMLParser):
    SKIP = {'script', 'style', 'iframe', 'video', 'object', 'embed', 'noscript'}

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.out, self.skip = [], 0

    def handle_starttag(self, tag, attrs):
        if tag in self.SKIP:
            self.skip += 1
        elif self.skip:
            return
        elif tag == 'br':
            self.out.append(BR)
        elif tag in ('ul', 'ol'):
            self.out.append(LIST)
        elif tag == 'li':
            self.out.append(' • ')

    def handle_startendtag(self, tag, attrs):
        self.handle_starttag(tag, attrs)

    def handle_endtag(self, tag):
        if tag in self.SKIP:
            self.skip = max(0, self.skip - 1)
            return
        if self.skip:
            return
        if tag in ('strong', 'b'):
            self.out.append(HEND)
        elif re.fullmatch(r'h[1-6]', tag):
            self.out.append(HHEAD + BLOCK)
        elif tag in ('p', 'div', 'ul', 'ol', 'table'):
            self.out.append(' ' + BLOCK + ' ')
        elif tag in ('td', 'th'):
            self.out.append(' ')
        elif tag == 'tr':
            self.out.append('; ')

    def handle_data(self, data):
        if not self.skip:
            self.out.append(' ' + data)


def _heading_colon(m):
    text = m.group(1)
    if not text.strip() or text.rstrip().endswith((':', '.', '!', '?', '•')):
        return text
    return text.rstrip() + ':'


def clean_desc(raw):
    if not raw.strip():
        return ''
    p = _Text()
    try:
        p.feed(raw)
        p.close()
    except Exception:
        return re.sub(r'\s+', ' ', re.sub(r'<[^>]+>', ' ', html.unescape(raw))).strip()
    text = ''.join(p.out).replace(' ', ' ')
    # "<strong>Heading<br></strong>": treat the line break as coming after the heading
    text = re.sub(BR + r'(\s*)' + HEND, HEND + BR, text)
    # <strong>/<b> text directly followed by <br>, a list or the end of a block reads as a heading
    text = re.sub(r'([^' + HEND + BR + LIST + BLOCK + HHEAD + r']*?)' + HEND + r'(?=\s*(?:' + BR + '|' + LIST + '|' + BLOCK + r'|$))',
                  _heading_colon, text)
    text = re.sub(r'([^' + HEND + BR + LIST + BLOCK + HHEAD + r']*?)' + HHEAD, _heading_colon, text)
    text = text.replace(HEND, '').replace(BR, ' ').replace(LIST, '').replace(HHEAD, '')
    text = re.sub(r'https?://\S+|www\.\S+', '', text)
    text = re.sub(r'[\r\n\t]+', ' ', text)
    text = re.sub(r'\s*' + BLOCK + r'[\s' + BLOCK + r']*', BLOCK, text).strip(BLOCK + ' ')
    text = re.sub(r'([.:;!?])' + BLOCK, r'\1 ', text)
    text = text.replace(BLOCK, '. ')
    text = re.sub(r'\s+([:;,.])', r'\1', text)
    text = re.sub(r'(\s*•\s*){2,}', ' • ', text)
    text = re.sub(r'\s*;\s*(;\s*)+', '; ', text)
    text = re.sub(r'\s+', ' ', text).strip(' ;')
    return text.lstrip('•.;: ')


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
    tot = sum(x * (3 if i % 2 == 0 else 1) for i, x in enumerate(d[:-1][::-1]))
    if (10 - tot % 10) % 10 != d[-1]:
        return False
    if len(s) == 8:
        return s[0] not in '02' and len(set(s)) > 1
    s13 = s.zfill(13) if len(s) <= 13 else s[1:]
    if s13[0] == '2' or s13[:2] in ('02', '04', '05', '98', '99') or s13.startswith('00000'):
        return False
    return len(set(s)) > 1


def find_gtin(code, title, desc_html, known):
    cands = [known] if known else []
    if re.fullmatch(r'\d{12,14}', code or ''):
        cands.append(code)
    cands += re.findall(r'\((\d{8}|\d{12,14})\)', title)
    cands += [m.group(1) for m in re.finditer(
        r'(?:EAN|GTIN|UPC|შტრიხ[\w-]*|მოდელი|არტიკული|კოდი)[^0-9]{0,25}(\d{8}|\d{12,14})(?!\d)', desc_html, re.I)]
    return next((c for c in cands if gtin_ok(c)), '')


MODEL_RE = re.compile(r'მოდელი\s*:\s*([^<•\n]{2,60})')
MFR_RE = re.compile(r'(?:მწარმოებლის კოდი|Part Number|MPN|P/N)\s*:\s*([A-Za-z0-9][A-Za-z0-9\-./+ ]{2,40}?)\s*(?:<|•|$)', re.I)
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
    if GEO.search(v) or not re.search(r'\d', v) or not re.search(r'[A-Za-z]', v) or len(v) > 40 or len(v.split()) > 3:
        return ''
    norm = lambda s: re.sub(r'[\s\-_/.]', '', s.lower())
    return v if norm(v) in norm(title) else ''

# ---------------------------------------------------------------- helpers
CLEAN_IMG = re.compile(r'\.(jpe?g|png|gif|webp|bmp)\.webp$', re.I)


def enc_url(u):
    return quote(u.strip(), safe=":/?&=%#@+;~-._!$'()*[]")


def full_size_image(u):
    """CS-Cart exports a 550x550 thumbnail; Google prefers the original upload."""
    u = u.strip()
    m = re.match(r'^(https://superi\.ge/images/)thumbnails/\d+/\d+/(detailed/.+)$', u)
    if not m:
        return u
    p = m.group(2)
    if CLEAN_IMG.search(p):
        p = p[:-5]
    return m.group(1) + p


def fmt_price(v):
    return f'{v:.2f} GEL'


# broad Google categories for site sections, used only when a brand-new leaf category is not mapped yet
PARENT_GPC = {
    'სამზარეულოს ტექნიკა': 730, 'საყოფაცხოვრებო ტექნიკა': 604, 'წვრილი საყოფაცხოვრებო ტექნიკა': 604,
    'კლიმატური ტექნიკა': 1626, 'სილამაზე და მოვლა': 2915, 'TV-ფოტო-ვიდეო': 222,
    'ნოუთბუქები, კომპიუტერები, მონიტორები': 278, 'ტელეფონები, ტაბლეტები, ელექტრონული წიგნები': 222,
    'საოფისე და ქსელური მოწყობილობები': 222, 'ტექნიკა': 222, 'სახლი და დეკორი': 536, 'ავეჯი': 436,
    'ბაღი და ეზო': 689, 'სამშენებლო ხელსაწყოები': 632, 'სპორტი და დასვენება': 988, 'საბავშვო პროდუქცია': 537,
    'ავტოსამყარო': 5613, 'ცხოველთა სამყარო': 1, 'წიგნები': 783,
}


def gpc_with_fallback(category, text):
    g = gpc_for(category, text)
    if g:
        return g, True
    for part in reversed([p.strip() for p in category.split('///') if p.strip()][:-1]):
        if part in PARENT_GPC:
            return PARENT_GPC[part], False
    return None, False

# ---------------------------------------------------------------- read inputs
def read_export(path):
    raw = open(path, 'rb').read()
    try:
        text = raw.decode('utf-8-sig')
    except UnicodeDecodeError:
        raise SystemExit('ERROR: export is not UTF-8. Export it from CS-Cart again without opening it in Excel.')
    rows = list(csv.DictReader(text.splitlines(), delimiter=';'))
    need = {'Product code', 'Price', 'Status', 'Product name', 'Description', 'Product URL', 'Image URL',
            'List price', 'Category'}
    if not rows or not need <= set(rows[0]):
        raise SystemExit('ERROR: unexpected columns in export: %s' % (list(rows[0]) if rows else 'empty file'))
    names = [r['Product name'] for r in rows]
    if sum('???' in n for n in names) > len(names) * 0.2:
        raise SystemExit('ERROR: Georgian text in the export is unreadable (???). Export it again.')
    return rows


def read_state(path):
    """Brands, GTINs and extra images from the previous feed, keyed by product link."""
    state = {}
    if not os.path.exists(path):
        return state
    with open(path, encoding='utf-8') as f:
        lines = f.read().split('\n')
    head = lines[0].split('\t')
    if head[:len(COLS)] != COLS:
        return state
    ix = {k: i for i, k in enumerate(head)}
    for line in lines[1:]:
        if not line:
            continue
        r = line.split('\t')
        if len(r) != len(head):
            continue
        state[r[ix['link']]] = {
            'brand': '' if r[ix['brand']] == STORE_BRAND else r[ix['brand']],
            'gtin': r[ix['gtin']],
            'images': [r[ix['image_link']]] + [u for u in r[ix['additional_image_link']].split(',') if u],
        }
    return state

# ---------------------------------------------------------------- build
def build(rows, state, tax):
    active, order = {}, []
    for r in rows:
        if r['Status'].strip() != 'A':
            continue
        u = r['Product URL'].strip()
        if u not in active:
            active[u] = r
            order.append(u)
        elif not CLEAN_IMG.search(active[u]['Image URL']) and CLEAN_IMG.search(r['Image URL']):
            active[u] = r
    rows = [active[u] for u in order]

    code_count = Counter(r['Product code'].strip() for r in rows)
    known = {canon(s['brand']) for s in state.values()}
    index = [(rx, b) for rx, b in build_brand_index(known) if b not in ('OZ', 'Oz', 'UD', 'Karma')]

    feed, skipped, unmapped = [], [], Counter()
    seen_ids = set()
    stats = Counter()
    for r in rows:
        url, code, name = r['Product URL'].strip(), r['Product code'].strip(), r['Product name'].strip()
        cat = r['Category'].strip()
        leaf = leaf_of(cat)
        st = state.get(url, {})
        try:
            price_now = float(r['Price'] or 0)
        except ValueError:
            price_now = 0.0
        if not name:
            skipped.append((code, name, url, 'დასახელება ცარიელია'))
            continue
        if price_now <= 0:
            skipped.append((code, name, url, 'ფასი 0'))
            continue

        gtin = find_gtin(code, name, r['Description'], st.get('gtin', ''))
        raw_sb = st.get('brand', '')
        sb = '' if raw_sb.split('|')[0].strip().lower() in BAD_SITE else canon(raw_sb)
        uname = html.unescape(name)
        tb = detect_from_title(uname, index)
        if sb and tb and sb != tb:
            sb_rx = re.compile(r'(?<![A-Za-z0-9])' + re.sub(r'(\\ |\\-|-| )', r'[\\s\\-]*', re.escape(sb))
                               + r'(?![A-Za-z0-9])', re.I)
            if detect_from_title(uname, []) == tb:
                brand = tb
            elif sb_rx.search(name) or sb.lower().startswith(tb.lower()):
                brand = sb
            else:
                brand = tb
        else:
            brand = sb or tb or STORE_BRAND
        stats['store_brand' if brand == STORE_BRAND else 'branded'] += 1

        title = brand_case_in_title(clean_title(name, leaf, gtin), brand)
        mpn = ''
        if brand != STORE_BRAND:
            mpn = find_mpn(r['Description'], name) or mpn_from_title(title, brand)
            if mpn == gtin:
                mpn = ''

        desc = clean_desc(r['Description'])
        if PROMO.search(desc):
            desc = re.sub(r'\s+', ' ', PROMO.sub('', desc)).strip()
        if len(desc) < 30 or desc.lower() == title.lower():
            pt = ' > '.join(p.strip() for p in cat.split('///') if p.strip())
            desc = f'{title}. ბრენდი: {brand}. კატეგორია: {pt}.'
        desc = clip(desc).lstrip('"')

        pid = code
        if not pid or code_count[code] > 1 or not re.fullmatch(r'[A-Za-z0-9._\-]{1,50}', pid) or pid in seen_ids:
            pid = (re.sub(r'[^A-Za-z0-9._\-]', '', code) or 'SG') + '-' + hashlib.md5(url.encode()).hexdigest()[:6]
        seen_ids.add(pid)

        img_csv = r['Image URL'].strip()
        main_img = enc_url(full_size_image(img_csv)) if img_csv else ''
        extra = []
        for u in st.get('images', []):
            u = enc_url(u)
            if u and u != main_img and u not in extra:
                extra.append(u)
        if not main_img and extra:
            main_img, extra = extra[0], extra[1:]
        if not main_img:
            skipped.append((code, name, url, 'სურათი არ აქვს'))
            continue
        extra = extra[:10]

        try:
            list_price = float(r['List price'] or 0)
        except ValueError:
            list_price = 0.0
        price, sale = (list_price, price_now) if list_price > price_now + 0.009 else (price_now, None)

        gpc, exact = gpc_with_fallback(cat, title + ' ' + name)
        if not exact:
            unmapped[cat] += 1
        if gpc is not None and gpc not in tax:
            gpc = None

        ident = '' if (gtin or (brand != STORE_BRAND and mpn)) else 'no'
        row = {
            'id': pid, 'title': title, 'description': desc, 'link': url, 'image_link': main_img,
            'additional_image_link': ','.join(extra), 'availability': 'in_stock', 'price': fmt_price(price),
            'sale_price': fmt_price(sale) if sale is not None else '', 'condition': 'new', 'brand': brand,
            'gtin': gtin, 'mpn': mpn, 'identifier_exists': ident,
            'google_product_category': str(gpc) if gpc else '',
            'product_type': ' > '.join(p.strip() for p in cat.split('///') if p.strip()),
        }
        problem = validate(row)
        if problem:
            skipped.append((code, name, url, problem))
            continue
        feed.append(row)
    return feed, skipped, unmapped, stats


def validate(r):
    for k in COLS:
        v = r[k]
        if any(ch in v for ch in '\t\r\n'):
            r[k] = re.sub(r'[\t\r\n]+', ' ', v)
    for k in ('id', 'title', 'description', 'link', 'image_link', 'price', 'brand'):
        if not r[k]:
            return 'ცარიელი ველი: ' + k
    if len(r['id']) > 50 or len(r['title']) > 150 or len(r['description']) > 5000:
        return 'ველი ძალიან გრძელია'
    if not r['link'].startswith('https://'):
        return 'არასწორი ბმული'
    if not re.match(r'https://\S+\.(jpe?g|png|webp|gif|bmp|tiff?)$', r['image_link'], re.I):
        return 'არასწორი სურათის ბმული'
    if r['sale_price'] and float(r['sale_price'].split()[0]) >= float(r['price'].split()[0]):
        r['sale_price'] = ''
    return ''

# ---------------------------------------------------------------- main
def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--csv', required=True, help='CS-Cart data-feed export (products_GOOGLE.csv)')
    ap.add_argument('--out', required=True, help='folder Merchant Center fetches the feed from')
    ap.add_argument('--min-ratio', type=float, default=0.7,
                    help='refuse to publish if the feed shrinks below this share of the previous one')
    args = ap.parse_args()

    os.makedirs(args.out, exist_ok=True)
    feed_path = os.path.join(args.out, FEED_NAME)
    tax = set()
    with open(os.path.join(HERE, 'google_taxonomy_2021-09-21.tsv'), encoding='utf-8') as f:
        for line in f:
            tax.add(int(line.split('\t', 1)[0]))

    rows = read_export(args.csv)
    state = read_state(feed_path)
    feed, skipped, unmapped, stats = build(rows, state, tax)

    if state and len(feed) < len(state) * args.min_ratio:
        print(f'ERROR: only {len(feed)} products vs {len(state)} yesterday; feed not replaced.', file=sys.stderr)
        sys.exit(2)

    tmp = feed_path + '.tmp'
    with open(tmp, 'w', encoding='utf-8', newline='') as f:
        f.write('\t'.join(COLS) + '\n')
        for r in feed:
            f.write('\t'.join(r[k] for k in COLS) + '\n')
    os.replace(tmp, feed_path)

    now = datetime.datetime.now().strftime('%Y-%m-%d %H:%M')
    new = sum(1 for r in feed if r['link'] not in state) if state else len(feed)
    with open(os.path.join(args.out, REPORT_NAME), 'w', encoding='utf-8') as f:
        f.write(f'Superi.ge Google feed — {now}\n')
        f.write(f'პროდუქტები ფიდში: {len(feed)} (ახალი: {new}, წინა ფიდში იყო: {len(state)})\n')
        f.write(f'ბრენდით: {stats["branded"]}, ბრენდის გარეშე (Superi): {stats["store_brand"]}\n')
        f.write(f'ამოღებული პროდუქტები: {len(skipped)}\n')
        for code, name, url, why in skipped:
            f.write(f'  - {code} | {name} | {url} | {why}\n')
        f.write(f'კატეგორიები Google-ის მიბმის გარეშე (საჭიროებს დამატებას catmap.py-ში): {len(unmapped)}\n')
        for cat, n in unmapped.most_common():
            f.write(f'  - {cat} ({n})\n')
    print(f'{now} feed={len(feed)} new={new} skipped={len(skipped)} unmapped_categories={len(unmapped)}')


if __name__ == '__main__':
    main()
