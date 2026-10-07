import json, os, html

B = os.path.dirname(os.path.abspath(__file__))
os.makedirs(f"{B}/posts", exist_ok=True)
os.makedirs(f"{B}/out/posts", exist_ok=True)

FOOT_DELIVERY = '<div class="foot"><span>🚚 უფასო მიწოდება თბილისში 100₾-ზე მეტ შენაძენზე</span><b>superi.ge</b></div>'
FOOT_PLAIN = '<div class="foot"><span>📞 032 2 04 44 44</span><b>superi.ge</b></div>'


def fmt(p):
    p = int(p)
    if p < 1000:
        return str(p)
    return f'{p // 1000}<span style="margin-left:.22em"></span>{p % 1000:03d}'


def page(body, cls="", extra_css=""):
    return f"""<!doctype html><html><head><meta charset="utf-8">
<link rel="stylesheet" href="../base.css"><link rel="stylesheet" href="../posts.css">
<style>{extra_css}</style></head><body class="{cls}">{body}</body></html>"""


def top(cat):
    # the client's own logo (kept by request): dark-text version on light/lime posts, white-text version on dark posts
    return (f'<div class="top"><div class="brand"><img class="lg-dark" src="../assets/logo_current_dark.png">'
            f'<img class="lg-light" src="../assets/logo_current_light.png"></div><div class="cat">{cat}</div></div>')


# ---------- templates ----------
def t_deal(d):
    css = """
.card{margin:30px 60px 0;height:790px;background:#fff;border-radius:40px;position:relative;display:flex;align-items:center;justify-content:center;padding:70px}
.card img{max-width:100%;max-height:100%;object-fit:contain}
.card .badge{position:absolute;right:34px;top:34px;width:184px;height:184px;font-size:46px}
.hook{position:absolute;left:40px;top:40px;background:var(--ink);color:var(--paper);border-radius:14px;padding:10px 18px;font-size:24px;font-weight:700}
.info{padding:34px 64px 0}
.name{font-size:40px;font-weight:700;line-height:1.22;letter-spacing:-.005em}
.spec{font-size:25px;color:#4A524C;margin-top:10px;font-weight:500}
.row{display:flex;align-items:baseline;gap:26px;margin-top:22px}
.row .price{font-size:104px}
.row .old{font-size:40px}
"""
    body = f"""{top(d['cat'])}
<div class="card"><img src="../assets/{d['img']}"><div class="badge">{d['disc']}</div>{f'<div class="hook">{d["hook"]}</div>' if d.get('hook') else ''}</div>
<div class="info"><div class="name">{d['name']}</div><div class="spec">{d['spec']}</div>
<div class="row"><div class="price">{fmt(d['price'])}₾</div><div class="old">{fmt(d['old'])}₾</div></div></div>
{FOOT_DELIVERY}"""
    return page(body, extra_css=css)


def t_multi(d):
    css = """
.head{padding:40px 60px 0}
.h1{font-size:76px;font-weight:850;line-height:1.08;letter-spacing:-.01em}
.h1 em{font-style:normal;color:var(--deep)}
.h2{font-size:30px;color:#4A524C;margin-top:14px;font-weight:500}
.list{padding:34px 60px 0;display:flex;flex-direction:column;gap:22px}
.it{display:flex;background:#fff;border-radius:32px;height:262px;overflow:hidden;position:relative}
.it .pic{width:300px;flex:none;display:flex;align-items:center;justify-content:center;padding:26px}
.it .pic img{max-width:100%;max-height:100%;object-fit:contain}
.it .tx{padding:34px 150px 30px 10px;display:flex;flex-direction:column;justify-content:center;gap:16px}
.it .nm{font-size:30px;font-weight:700;line-height:1.25}
.it .pr{display:flex;align-items:baseline;gap:18px}
.it .price{font-size:58px}
.it .old{font-size:28px}
.it .badge{position:absolute;right:26px;top:26px;width:108px;height:108px;font-size:26px}
"""
    items = "".join(f"""<div class="it"><div class="pic"><img src="../assets/{i['img']}"></div>
<div class="tx"><div class="nm">{i['name']}</div><div class="pr"><div class="price">{fmt(i['price'])}₾</div><div class="old">{fmt(i['old'])}₾</div></div></div>
<div class="badge">{i['disc']}</div></div>""" for i in d['items'])
    body = f"""{top(d['cat'])}<div class="head"><div class="h1">{d['h1']}</div><div class="h2">{d['h2']}</div></div>
<div class="list">{items}</div>{FOOT_DELIVERY}"""
    return page(body, extra_css=css)


def t_tips(d):
    css = """
body{background:var(--ink);color:var(--paper)}
.head{padding:56px 60px 0}
.eb{display:inline-block;background:var(--lime);color:var(--ink);font-weight:700;font-size:26px;border-radius:10px;padding:8px 16px}
.h1{font-size:68px;font-weight:850;line-height:1.12;margin-top:26px;letter-spacing:-.01em}
.h1 em{font-style:normal;color:var(--lime)}
.list{padding:44px 60px 0;display:flex;flex-direction:column;gap:0}
.tp{display:flex;gap:30px;padding:28px 0;border-top:1px solid rgba(242,243,238,.16)}
.tp .n{font-family:"UNB";font-weight:800;font-size:40px;color:var(--lime);width:62px;flex:none;line-height:1.1}
.tp .t{font-size:31px;line-height:1.38;color:#DDE2DC}
.tp .t b{color:var(--paper);font-weight:700}
"""
    items = "".join(f'<div class="tp"><div class="n">{n:02d}</div><div class="t">{t}</div></div>' for n, t in enumerate(d['tips'], 1))
    body = f"""{top(d['cat'])}<div class="head"><div class="eb">{d['eb']}</div><div class="h1">{d['h1']}</div></div>
<div class="list">{items}</div>{FOOT_PLAIN}"""
    return page(body, cls="dark", extra_css=css)


def t_poll(d):
    css = """
body{background:var(--lime)}
.head{padding:44px 60px 0}
.h1{font-size:70px;font-weight:850;line-height:1.1;letter-spacing:-.01em}
.h2{font-size:30px;margin-top:16px;font-weight:600;color:#1F3A16}
.grid{padding:36px 60px 0;display:grid;grid-template-columns:1fr 1fr;gap:22px}
.o{background:#fff;border-radius:34px;height:390px;position:relative;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:70px 30px 30px}
.o img{max-width:100%;max-height:210px;object-fit:contain}
.o .l{position:absolute;left:24px;top:22px;width:70px;height:70px;border-radius:50%;background:var(--ink);color:var(--lime);font-family:"UNB";font-weight:900;font-size:34px;display:flex;align-items:center;justify-content:center}
.o .c{margin-top:22px;font-size:30px;font-weight:700}
"""
    opts = "".join(f'<div class="o"><div class="l">{o["l"]}</div><img src="../assets/{o["img"]}"><div class="c">{o["c"]}</div></div>' for o in d['opts'])
    body = f"""{top(d['cat'])}<div class="head"><div class="h1">{d['h1']}</div><div class="h2">{d['h2']}</div></div>
<div class="grid">{opts}</div><div class="foot"><span>👇 დაწერე ასო კომენტარში</span><b>superi.ge</b></div>"""
    return page(body, cls="limebg", extra_css=css)


def t_brand(d):
    css = """
body{background:var(--ink);color:var(--paper)}
.hero{padding:70px 60px 0;position:relative}
.eb{color:var(--lime);font-size:28px;font-weight:600;letter-spacing:.05em}
.hlogo{height:56px;display:block;margin-bottom:34px}
.tg{font-size:58px;font-weight:800;line-height:1.18;margin-top:18px}
.tg em{font-style:normal;color:var(--lime)}
.cards{padding:44px 60px 0;display:grid;grid-template-columns:1fr 1fr;gap:18px}
.c{background:var(--ink2);border:1px solid rgba(242,243,238,.10);border-radius:28px;padding:28px 28px 30px;min-height:196px}
.c .i{font-size:40px}
.c b{display:block;font-size:29px;margin-top:12px;font-weight:700}
.c span{display:block;font-size:23px;color:#AEB6AF;margin-top:6px;line-height:1.35}
.strip{display:flex;justify-content:space-between;align-items:flex-end;padding:30px 70px 0;height:230px}
.strip img{filter:drop-shadow(0 16px 18px rgba(0,0,0,.45))}
"""
    cards = "".join(f'<div class="c"><div class="i">{c[0]}</div><b>{c[1]}</b><span>{c[2]}</span></div>' for c in d['cards'])
    body = f"""<div class="hero"><img class="hlogo" src="../assets/logo_current_light.png"><div class="eb">ონლაინ მაღაზია · 2016 წლიდან</div>
<div class="tg">ყველაფერი შენი სახლისთვის<br><em>— ერთ სივრცეში</em></div></div>
<div class="cards">{cards}</div>
<div class="strip"><img src="../assets/c_tv2.webp" style="height:180px"><img src="../assets/coffee.webp" style="height:200px"><img src="../assets/c_chair.webp" style="height:180px"><img src="../assets/c_laptop.webp" style="height:140px"><img src="../assets/c_smeg.webp" style="height:170px"></div>
{FOOT_PLAIN}"""
    return page(body, cls="dark", extra_css=css)


def t_express(d):
    css = """
body{background:var(--ink);color:var(--paper)}
.head{padding:56px 60px 0}
.big{font-size:150px;font-weight:900;line-height:1;letter-spacing:-.02em;color:var(--lime)}
.h2{font-size:44px;font-weight:700;margin-top:18px;line-height:1.2}
.tl{margin:54px 60px 0;display:flex;align-items:stretch;gap:0}
.st{flex:1;background:var(--ink2);border:1px solid rgba(242,243,238,.12);padding:34px 30px;border-radius:30px}
.st .k{font-size:24px;color:#AEB6AF;font-weight:600}
.st .v{font-family:"UNB";font-weight:800;font-size:62px;margin-top:10px;letter-spacing:-.03em}
.st .s{font-size:26px;margin-top:8px;font-weight:600}
.arr{width:90px;display:flex;align-items:center;justify-content:center;font-size:56px;color:var(--lime)}
.st.hl{background:var(--lime);color:var(--ink);border:0}
.st.hl .k{color:#21401A}
.notes{margin:40px 60px 0;display:flex;flex-direction:column;gap:0}
.nt{display:flex;justify-content:space-between;gap:20px;padding:27px 0;border-top:1px solid rgba(242,243,238,.16);font-size:30px}
.nt span{color:#C9D0CA}
.nt b{font-weight:700;text-align:right}
"""
    body = f"""{top('მიწოდება')}<div class="head"><div class="big">დღესვე.</div><div class="h2">ექსპრეს მიწოდება თბილისში</div></div>
<div class="tl"><div class="st"><div class="k">შეუკვეთე</div><div class="v">15:00</div><div class="s">-მდე, სამუშაო დღეს</div></div>
<div class="arr">→</div><div class="st hl"><div class="k">მიიღე</div><div class="v">19–22</div><div class="s">საათში, იმავე დღეს</div></div></div>
<div class="notes">
<div class="nt"><span>ექსპრეს — 15 კგ-მდე ნივთი</span><b>10 ₾</b></div>
<div class="nt"><span>ექსპრეს — 15 კგ-ზე მეტი</span><b>30 ₾</b></div>
<div class="nt"><span>სტანდარტული, თბილისი (100₾-ზე მეტი)</span><b>უფასო</b></div>
<div class="nt"><span>შეკვეთა 12:00-მდე</span><b>მომდევნო სამუშაო დღეს</b></div>
<div class="nt"><span>რეგიონები</span><b>3–5 სამუშაო დღე</b></div>
</div>{FOOT_PLAIN}"""
    return page(body, cls="dark", extra_css=css)


T = dict(deal=t_deal, multi=t_multi, tips=t_tips, poll=t_poll, brand=t_brand, express=t_express)

posts = json.load(open(f"{B}/posts.json", encoding="utf-8"))
jobs = []
for p in posts:
    h = T[p['tpl']](p['design'])
    fn = f"{B}/posts/{p['id']}.html"
    open(fn, "w", encoding="utf-8").write(h)
    jobs.append(dict(html=fn, out=f"{B}/out/posts/{p['id']}.png", w=1080, h=1350))
json.dump(jobs, open(f"{B}/jobs.json", "w"))
print(len(jobs), "posts generated")
