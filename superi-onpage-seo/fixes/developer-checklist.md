# დეველოპერის ჩეკლისტი (CS-Cart + UniTheme2)

აქ არის ის ცვლილებები, რომლებიც თემის პარამეტრებს, შაბლონებს ან სერვერის კონფიგურაციას ეხება. კონტენტის ცვლილებები (title, description, ტექსტები) ცალკე ფაილებშია, იხ. [README.md](README.md).

ყველა ცვლილებამდე გააკეთეთ შაბლონების და ბაზის backup.

---

## P1

### 1. მენიუ: `javascript:void(0)` → ნამდვილი ბმულები

Mega menu-ს ზედა დონის 8 პუნქტს და 5 „სრულად“ ბმულს ახლა `href="javascript:void(0)"` აქვს. ამიტომ Google ზედა კატეგორიებზე ვერ გადადის.

| მენიუს პუნქტი | URL |
|---|---|
| ტექნიკა | https://superi.ge/teqnika/ |
| საბავშვო პროდუქცია | https://superi.ge/sabavshvo-produqtsia/ |
| სახლი და სილამაზე | https://superi.ge/sakhli-da-dekori/ |
| სპორტი და დასვენება | https://superi.ge/sporti/ |
| ბაღი და ეზო | https://superi.ge/baghi-da-ezo/ |
| სამშენებლო ხელსაწყოები | https://superi.ge/samsheneblo-khelsatskoebi/ |
| ცხოველთა სამყარო | https://superi.ge/tskhovelta-samkaro/ |
| ავეჯი | https://superi.ge/aveji/ |
| „სრულად“ (5 ცალი) | შესაბამისი მშობელი კატეგორიის URL |

**სად:** Design → Menus (ან UniTheme2-ის mega menu). თითოეულ ზედა პუნქტს მიუთითეთ კატეგორიის URL.

თუ შაბლონი URL-იან პუნქტზე ქვემენიუს აღარ ხსნის, შეცვალეთ ქცევა: desktop-ზე ქვემენიუ hover-ზე გაიხსნას, მობილურზე კი პირველ შეხებაზე. ორივე შემთხვევაში ელემენტი `<a href="...">` უნდა დარჩეს.

**შემოწმება:** `curl -s https://superi.ge/ | grep -c 'javascript:void(0)'` → 0 (ან მხოლოდ ღილაკები, რომლებიც ბმულები არ არის).

### 2. მთავარი გვერდი: პროდუქტები HTML-ში, სათაურები H2-ით

- **AJAX ჩატვირთვა.** მთავარ გვერდზე 20 ბლოკი `cm-ut2-block-loader`-ით იტვირთება (`dispatch=block_manager.render`) და საწყის HTML-ში პროდუქტები არ არის. პირველი პროდუქტების ბლოკისთვის („ფასდაკლებული / პოპულარული / გაყიდვადი“ ტაბები) AJAX/lazy ჩატვირთვა გამორთეთ: UniTheme2-ის ბლოკის პარამეტრები ან abt__ut2 → Settings → ბლოკების lazy load. დანარჩენები შეიძლება lazy დარჩეს.
- **სათაურები.** `div.ty-mainbox-title` (მაგ. „ჩვენ გირჩევთ“) და ტაბების სათაურები გახადეთ `<h2 class="ty-mainbox-title">`. CSS კლასი იგივე რჩება, ამიტომ დიზაინი არ შეიცვლება.
- **H1 და SEO ტექსტი:** მზა HTML ბლოკი [homepage.md](homepage.md)-შია.

### 3. „ფასდაკლებული“ → ინდექსირებადი გვერდი

ახლა: `index.php?dispatch=products.on_sale` + `<meta name="robots" content="noindex, follow">`.

1. Website → SEO → **SEO rules** → ახალი წესი: dispatch `products.on_sale`, SEO name `fasdaklebebi`. URL იქნება `https://superi.ge/fasdaklebebi/`.
2. მოძებნეთ, საიდან მოდის `noindex` ამ dispatch-ზე (SEO add-on-ის პარამეტრი ან თემის `meta.tpl`) და ამ გვერდისთვის მოხსენით. ძიების და ფილტრების `noindex` უნდა დარჩეს.
3. Title, H1 და description: [pages-meta.csv](pages-meta.csv). მენიუში „ფასდაკლებული“ ახალ URL-ზე გადაიყვანეთ.
4. robots.txt-ში `products.on_sale` დაბლოკილი არ არის, ასე რომ იქ ცვლილება არ სჭირდება.

### 4. ფილტრების SEO გვერდები

ყველაზე დიდი ზრდის რეზერვია. ფილტრების კომბინაციები (`features_hash`) ახლა `noindex`-ზეა და robots.txt-ში დაბლოკილია. ეს სწორია, მაგრამ ამის გამო „Samsung ტელევიზორი“ ან „ინვერტორული კონდიციონერი“ ტიპის ძიებებზე გვერდი არ გვაქვს.

- დააყენეთ ფილტრების SEO მოდული, რომელიც თავსებადია UniTheme2-თან და თქვენს CS-Cart ვერსიასთან. მაგალითად, AlexBranding-ს (UniTheme2-ის ავტორს) აქვს SEO for filters add-on. ყიდვამდე თავსებადობა გადაამოწმეთ.
- მოდულმა უნდა შექმნას სტატიკური URL (`/televizorebi/samsung/`) საკუთარი title-ით, H1-ით, ტექსტით და self-canonical-ით, და დაამატოს ეს გვერდები sitemap-ში.
- დანარჩენი კომბინაციები `noindex`-ზე დარჩეს.
- პირველი 20–30 გვერდის სია: მთავარი ანგარიში, სექცია 6.

---

## P2

### 5. სიჩქარე (LCP)

Lighthouse mobile: მთავარი გვერდის LCP 3.5 წმ-ია, `/televizorebi/`-ის 4.9 წმ.

- **მთავარი ბანერი.** მობილურზე LCP ელემენტია `div.ut2-a__bg-banner` CSS `background-image`-ით.
  - პირველი სლაიდი გადააკეთეთ `<picture>`-ად: `<source media="(max-width: 767px)" srcset="…mobile.webp">` და `<img src="…desktop.webp" fetchpriority="high" width="…" height="…" alt="…">`, `loading="lazy"`-ის გარეშე.
- **Preload-ები.** ახლა `<head>`-ში ორი preload არის:
  - `superi_logo_z18q-9x.png` (`fetchpriority="high"`) — ამოიღეთ, ლოგო LCP არ არის.
  - `superi-desktop-banner-optimized.webp` — დაამატეთ `media="(min-width: 768px)"`. მობილური ბანერისთვის ცალკე preload დაამატეთ `media="(max-width: 767px)"`-ით.
- **კატეგორიის გვერდი.** LCP პირველი პროდუქტის სურათია. პირველ 2–4 ბარათს `loading="lazy"` მოუხსენით და `fetchpriority="high"` დაუმატეთ. UniTheme2-ის lazy load პარამეტრებში შეიძლება იყოს „პირველი N სურათი lazy-ის გარეშე“.
- **JS.** მთავარი bundle (`scripts-*.js`) ~1.1 MB-ია, შეკუმშვამდე. Lighthouse-ის შეფასებით ~187 KB JS არ გამოიყენება. გამორთეთ add-on-ები, რომლებსაც არ იყენებთ, და არაკრიტიკული სკრიპტები `defer`-ით ჩატვირთეთ.
- **DOM.** კატეგორიის გვერდზე 3 777 ელემენტია. Mega menu-ს ქვედა დონეები შეიძლება პირველი hover/შეხებისას ჩაიტვირთოს.

### 6. HTML cache

ახლა ყველა პასუხს აქვს `cache-control: no-store` და `cf-cache-status: DYNAMIC`. სტუმრებისთვის (sid cookie კალათის გარეშე) ჩართეთ full-page cache: LiteSpeed Cache, ან Cloudflare Cache Rule, რომელიც ტოვებს `checkout`, `profiles`, `auth`, `orders`, `wishlist` გვერდებს და მომხმარებლებს კალათით ან ავტორიზაციით. ეს TTFB-ს შეამცირებს.

### 7. Schema (JSON-LD)

**Product** (პროდუქტის გვერდი). ახლანდელი JSON-LD-ს დაუმატეთ:

```smarty
{* product JSON-LD: დამატებითი ველები; ჩასვით არსებული Product schema-ს გენერაციაში *}
"mpn": "{$product.product_code|escape:javascript}",            {* ან ცალკე feature „მოდელი“, თუ product_code შიდა SKU-ა *}
"image": ["{$product.main_pair.detailed.image_path}"{foreach $product.image_pairs|default:[] as $ip},"{$ip.detailed.image_path}"{/foreach}],
"offers": {
  "@type": "Offer",
  "itemCondition": "https://schema.org/NewCondition",
  "seller": { "@type": "Organization", "@id": "https://superi.ge/#organization", "name": "Superi.ge" },
  "hasMerchantReturnPolicy": {
    "@type": "MerchantReturnPolicy",
    "applicableCountry": "GE",
    "returnPolicyCategory": "https://schema.org/MerchantReturnFiniteReturnWindow",
    "merchantReturnDays": 14
  }
  {* price, priceCurrency, availability, priceValidUntil, url — როგორც ახლაა *}
}
```

- `gtin13` დაამატეთ მხოლოდ მაშინ, თუ EAN კოდი გაქვთ. ცარიელი ან გამოგონილი მნიშვნელობა არ ჩასვათ.
- `description`-ში სექციებს შორის ახლა სივრცე აკლია („ზოგადი ინფორმაცია• ბრენდი“). ტექსტიდან ტეგების მოშლისას `<br>`, `</p>` და `</li>` სივრცით შეცვალეთ.
- `aggregateRating` და `review` დაამატეთ მხოლოდ მაშინ, როცა product reviews ჩაირთვება და გვერდზე ნამდვილი შეფასებები გამოჩნდება.

**Organization** შიდა გვერდებზე ახლა `@id`-ის გარეშეა. დაუმატეთ `"@id": "https://superi.ge/#organization"`, რომ მთავარი გვერდის Organization-თან გაერთიანდეს.

**BlogPosting** (ბლოგის სტატია, `page_type = B`):

```smarty
{if $page.page_type == "B"}
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "headline": "{$page.page|escape:javascript}",
  "description": "{$page.meta_description|escape:javascript}",
  "datePublished": "{$page.timestamp|date_format:"%Y-%m-%d"}",
  "dateModified": "{$page.timestamp|date_format:"%Y-%m-%d"}",
  "author": { "@type": "Person", "name": "{$page.author|default:"Superi.ge"|escape:javascript}" },
  "publisher": { "@id": "https://superi.ge/#organization" },
  "image": "{$page.main_pair.icon.image_path|default:""}",
  "mainEntityOfPage": "{"pages.view?page_id=`$page.page_id`"|fn_url}"
}
</script>
{/if}
```

ველების სახელები (`author`, `main_pair`) გადაამოწმეთ თქვენი Blog add-on-ის ვერსიაში. ბლოგის გვერდებზე `og:type` გახადეთ `article`.

**Open Graph:**
- პროდუქტებზე `og:type` → `product`.
- ყველგან `og:locale` → `ka_GE`.

### 8. Sitemap

- **5 კატეგორია sitemap-ში არ არის:** `/klaviaturebi/` (ID 179, 95 პროდუქტი), `/seifebi/` (177), `/silamaze-da-movla/` (175), `/tmis-fenebi/` (176), `/graphics-cards/` (169). ხელახლა დააგენერირეთ და ავტომატური განახლება cron-ით დააყენეთ (მაგ. ღამით).
- **53 პროდუქტის URL** sitemap-შია, მაგრამ 404-ს აბრუნებს (წაშლილი ან გამორთული პროდუქტები). სია: [sitemap-dead-products.csv](sitemap-dead-products.csv). ისინი sitemap-იდან ამოიღეთ. თუ ასეთ გვერდზე გარე ბმულები ან ტრაფიკი მოდიოდა, 301 გააკეთეთ ანალოგზე ან კატეგორიაზე.
- თუ sitemap add-on იძლევა, ჩართეთ `<lastmod>` (პროდუქტის `updated_timestamp`).
- `/categories-catalog-ka/` sitemap-იდან ამოიღეთ, ან გვერდი გაასწორეთ ([pages-meta.csv](pages-meta.csv)).

### 9. Redirect chain

`http://www.superi.ge/` → `https://www.superi.ge/` → `https://superi.ge/`: ორი 301. Cloudflare-ში დააყენეთ ერთი Redirect Rule: `http(s)://www.superi.ge/*` → `https://superi.ge/$1` (301). დიდასოიანი URL-ებიც ახლა 2 გადამისამართებით მიდის.

### 10. პროდუქტის გვერდი: H2

ახლა პროდუქტის გვერდებზე H2 საერთოდ არ არის. ტაბების და ბლოკების სათაურები („პროდუქციის აღწერა“, „მახასიათებლები“, „მსგავსი“) გახადეთ `<h2>`. კლასები იგივე დატოვეთ, რომ დიზაინი არ შეიცვალოს.

### 11. Cyrillic URL-ების გასწორება

[products-fix.csv](products-fix.csv)-ში მითითებულ პროდუქტებს ახალი SEO name აქვთ (მაგ. `blaupunkt-55msg8000-...` → `blaupunkt-55mcg8000-...`). შეამოწმეთ, რომ SEO name-ის შეცვლისას CS-Cart ძველ URL-ზე 301-ს ქმნის: Website → SEO → 301 redirects. თუ არ ქმნის, redirect-ები ხელით დაამატეთ.

### 12. ბლოგის tag-ები

Tags add-on-ის ბმულები (`dispatch=tags.view`) robots.txt-ითაა დაბლოკილი. ბლოგის სტატიებიდან tag-ები წაშალეთ, ან ბლოგზე tag-ების ბლოკი გამორთეთ ([blog.md](blog.md)).

---

## როგორ შევამოწმოთ ცვლილებების შემდეგ

1. Google Search Console → URL Inspection → `https://superi.ge/` → „View crawled page“. HTML-ში უნდა ჩანდეს H1 და პროდუქტების ბმულები.
2. Rich Results Test (https://search.google.com/test/rich-results) ერთ პროდუქტზე: Product, Offer, Merchant return policy.
3. PageSpeed Insights (mobile) მთავარ გვერდზე, `/televizorebi/`-ზე და ერთ პროდუქტზე, ცვლილებამდე და მის შემდეგ.
