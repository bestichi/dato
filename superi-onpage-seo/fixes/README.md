# Superi.ge — გასწორებების პაკეტი

აუდიტში ნაპოვნი პრობლემების მზა გასწორებები: ტექსტები, title/description-ები, იმპორტის ცხრილები და ინსტრუქციები. აუდიტის ანგარიში: [../README.md](../README.md).

ყველაფერი 2026 წლის 9–10 ოქტომბრის მონაცემებზეა აგებული. შემოწმდა ყველა 5 492 პროდუქტი, ყველა კატეგორია, 246 ბრენდი და სერვისული გვერდები.

## რა არის პაკეტში

| ფაილი | რას ასწორებს | მასშტაბი | სად იცვლება |
|---|---|---|---|
| [categories-meta.csv](categories-meta.csv) | კატეგორიების ახალი title და meta description; 20 კატეგორიისთვის სახელის/H1-ის შემოთავაზება (მაგ. „SMART WATCHES“ → „სმარტ საათები“) | 118 კატეგორია | Products → Categories → კატეგორია → SEO |
| [category-texts/](category-texts/) | კატეგორიების SEO ტექსტები (შესავალი, შერჩევის რჩევები, მიწოდება, FAQ, შიდა ბმულები) | 55 კატეგორია | Products → Categories → კატეგორია → Description (HTML რეჟიმში) |
| [homepage.md](homepage.md) | მთავარი გვერდის H1, SEO ტექსტი, meta description, სამუშაო საათები | 1 | Design → Layouts → Homepage |
| [pages-meta.csv](pages-meta.csv) | სერვისული გვერდების და ბლოგის title/description („blog“, „Delivery“, „AB: Categories“, CSS კოდი description-ში...) | 13 გვერდი | Website → Pages / Blog → SEO |
| [blog.md](blog.md) | ბლოგი: tag-ების ჩიხი-ბმულები, OLED სტატიის გავრცობა, ბმულები ნოუთბუქების სტატიაში, ავტორი | 4 სტატია | Website → Blog |
| [site-text-fixes.md](site-text-fixes.md) | მიწოდების ბლოკი ყველა პროდუქტზე („სამუშა დღეს“, preview-ბმული), ინგლისური წარწერები, footer | საიტის მასშტაბით | Add-ons → AB: Motivation block; Languages → Translations |
| [filters-cleanup.csv](filters-cleanup.csv) | ფილტრები: ბეჭდვითი შეცდომები, კირილიცა, დუბლიკატები, არასწორი მნიშვნელობები, ბრენდები ზედმეტი სივრცით | 30 ჩანაწერი | Products → Features |
| [products-fix.csv](products-fix.csv) | პროდუქტები: ქართული ტიპი სახელში (593), კირილიცა (13), ბეჭდვითი შეცდომები (10), ცუდი meta description-ები (944), URL-ები (10) | 1 518 პროდუქტი | CS-Cart import (Product code / ID) ან API |
| [products-titles-optional.csv](products-titles-optional.csv) | არასავალდებულო: 65 სიმბოლოზე გრძელი title-ები და title-ები `\| Superi.ge`-ის გარეშე | 2 007 პროდუქტი | იგივე |
| [sitemap-dead-products.csv](sitemap-dead-products.csv) | sitemap-ში მყოფი, მაგრამ 404-ის მქონე პროდუქტები | 53 URL | sitemap-ის add-on / 301 redirects |
| [brands-meta.csv](brands-meta.csv) | ბრენდის გვერდების title და description (ქართული ფორმით: „Samsung (სამსუნგი)“), სახელის სწორი ჩაწერა (SAMSUNG → Samsung) | 246 ბრენდი | Products → Features → მწარმოებელი → ბრენდი |
| [brand-texts/](brand-texts/) | ტექსტები 12 ყველაზე დიდი ბრენდის გვერდისთვის | 12 ბრენდი | იგივე → Description |
| [developer-checklist.md](developer-checklist.md) | კოდისა და თემის ცვლილებები: მენიუს ბმულები, AJAX ბლოკი, H2-ები, LCP, schema, sitemap, cache, redirect-ები, ფასდაკლებების გვერდი | 12 პუნქტი | დეველოპერი |
| [apply_cscart.py](apply_cscart.py) | სკრიპტი, რომელიც კატეგორიების, გვერდების და პროდუქტების ცვლილებებს CS-Cart API-ით შეიტანს | — | იხ. ქვემოთ |

## თანმიმდევრობა

1. **დღესვე (ადმინში, კოდის გარეშე, ~2 საათი):**
   - [site-text-fixes.md](site-text-fixes.md)-ის პირველი პუნქტი: მიწოდების ბლოკი ყველა პროდუქტზე ერთი ცვლილებით სწორდება.
   - [pages-meta.csv](pages-meta.csv) — 13 გვერდი.
   - [homepage.md](homepage.md) — H1, ტექსტი და meta.
2. **დეველოპერი (P1):** [developer-checklist.md](developer-checklist.md), პუნქტები 1–3: მენიუ, მთავარი გვერდი, ფასდაკლებების გვერდი.
3. **კონტენტი (1–2 კვირა):** [categories-meta.csv](categories-meta.csv) და [category-texts/](category-texts/). პირველ რიგში კონდიციონერები, კლიმატური ტექნიკა, გათბობის ქვაბები და მშობელი კატეგორიები.
4. **პროდუქტები:** [products-fix.csv](products-fix.csv). ჯერ გადახედეთ 30–50 ჩანაწერს (სვეტი `შემოწმებულია`), მერე დანარჩენი ერთად შეიტანეთ.
5. **ბრენდები და ფილტრები:** [brands-meta.csv](brands-meta.csv), [brand-texts/](brand-texts/), [filters-cleanup.csv](filters-cleanup.csv).
6. **დეველოპერი (P2):** სიჩქარე, schema, sitemap, cache.

## როგორ შევიტანოთ

### ხელით

ყველა CSV-ს აქვს სვეტები „ახლა“ და „ახალი“ და ID ან URL. Excel-ში ან Google Sheets-ში იხსნება (UTF-8). ტექსტის ფაილები (`.html`) პირდაპირ ჩასვით CS-Cart-ის რედაქტორში, HTML/წყაროს რეჟიმში.

### ავტომატურად, CS-Cart API-ით

საიტზე REST API ჩართულია. [apply_cscart.py](apply_cscart.py) კატეგორიების, გვერდების და პროდუქტების ცვლილებებს თავად შეიტანს:

- **dry run ნაგულისხმევად:** ჯერ აჩვენებს, რა შეიცვლება, და `--apply`-ის გარეშე არაფერს წერს;
- **backup:** ყოველი ცვლილების წინ ძველ მნიშვნელობას `backups/`-ში ინახავს;
- **დაბრუნება:** `restore`-ით ძველი მნიშვნელობები აღდგება.

```bash
# ადმინი → Customers → Administrators → მომხმარებელი → API access → გასაღები
export CSCART_EMAIL="..."   CSCART_API_KEY="..."
python3 apply_cscart.py categories-meta                  # ნახეთ, რა შეიცვლება
python3 apply_cscart.py categories-meta --apply
python3 apply_cscart.py category-texts --only kondicionerebi --apply   # ჯერ ერთი კატეგორიით
python3 apply_cscart.py pages-meta --apply
python3 apply_cscart.py products --apply
```

ბრენდები (feature variants) და Layouts-ის პარამეტრები API-ით არ შედის და ხელით იცვლება.

**API-ის უსაფრთხოება:** API-სთვის ცალკე ადმინ მომხმარებელი შექმენით მხოლოდ კატალოგის უფლებებით. სამუშაოს დასრულების შემდეგ გასაღები გააუქმეთ. გასაღები რეპოზიტორიაში ან ჩატში არ ჩაწეროთ.

## შენიშვნები

- **ტექსტების ფაქტები.** ტექსტები მხოლოდ საიტზე ნანახ ფაქტებს ეყრდნობა: ასორტიმენტს, ფილტრებს, მიწოდების და გადახდის პირობებს. ფასები განზრახ არ წერია, რადგან იცვლება. რაოდენობები („250-ზე მეტი“) ქვემოთაა დამრგვალებული.
- **ქართული ტიპი სახელში.** ტიპი კატეგორიის მიხედვით ავტომატურად შეირჩა, ამიტომ შეიტანამდე სიას თვალი გადაავლეთ.
- **URL-ების ცვლილება.** `seo_name_ახალი` (10 პროდუქტი, კირილიცით დამახინჯებული URL-ები) შეიტანეთ მხოლოდ მაშინ, როცა ძველი URL-იდან 301 გადამისამართება დარწმუნებით იმუშავებს. API სკრიპტი ამას მხოლოდ `--seo-names` ფლაგით აკეთებს.
- **რეპოზიტორია საჯაროა.** `bestichi/dato` public რეპოზიტორიაა, ამიტომ ეს მასალები ყველას შეუძლია ნახოს, კონკურენტებსაც. თუ არ გინდათ, GitHub-ის პარამეტრებში რეპოზიტორია private გახადეთ.
