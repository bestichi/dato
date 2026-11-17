# superi.ge — Google Merchant Center-ის ავტომატური ფიდი

ყოველდღე, ადამიანის ჩარევის გარეშე:

| დრო | რა ხდება |
|---|---|
| 03:00 | CS-Cart „GOOGLE“ data feed-ს სერვერზე ფაილად ინახავს (`products_GOOGLE.csv`) |
| 03:30 | `superi_feed.py` ფაილს ამუშავებს და ქმნის `superi_google_merchant_feed.tsv`-ს |
| 05:00 | Merchant Center ფაილს ბმულიდან თავად ჩამოტვირთავს |

`superi_feed.py` იგივე დამუშავებას აკეთებს, რაც ხელით აწყობილ ფაილზე კეთდებოდა:

- რჩება მხოლოდ **A** სტატუსის პროდუქტები, `availability = in_stock`;
- ენიჭება Google-ის კატეგორია;
- ივსება ბრენდი; უბრენდო პროდუქტზე იწერება „Superi“ და `identifier_exists = no`;
- გამოიყენება GTIN/MPN, გასწორებული სათაურები, გასუფთავებული აღწერები და სრული ზომის სურათები;
- ძველი/ფასდაკლებული ფასი იწერება `price` / `sale_price`-ში.

წინა დღის ფიდიდან ბრენდები, შტრიხკოდები და დამატებითი სურათები გადმოდის.

**დაცვა:** ახალი ფიდი არ ჩაიწერება და გუშინდელი ძალაში რჩება, თუ ექსპორტი დაზიანებულია (არ არის UTF-8, ქართული ტექსტი „???“-ად არის ქცეული) ან პროდუქტები 30%-ზე მეტით შემცირდა.

## მოთხოვნები

- Linux ჰოსტინგი cron-ით (cPanel → Cron Jobs ან SSH);
- **Python 3.8+**, დამატებითი ბიბლიოთეკები საჭირო არ არის. შემოწმება: `python3 --version`.

## დაყენება (ერთჯერადად, ~30 წუთი)

### 1. ფაილების ატვირთვა სერვერზე
საქაღალდე `superi_feed/` ატვირთეთ საჯარო საქაღალდის **გარეთ**, მაგ. `/home/USER/superi_feed/`. მასში უნდა იყოს:
`superi_feed.py`, `catmap.py`, `brands.py`, `google_taxonomy_2021-09-21.tsv`.

### 2. საჯარო საქაღალდე ფიდისთვის
შექმენით `/home/USER/public_html/google-feed/`. პირველი გაშვებისთვის მასში ჩადეთ ამჟამინდელი
`superi_google_merchant_feed.tsv` (`superi_feed_bundle.zip` არქივის `seed/` საქაღალდეშია) — მისგან გადმოვა უკვე ამოცნობილი ბრენდები და სურათები.

### 3. CS-Cart: data feed-ის ავტომატური ექსპორტი
1. **Add-ons → Manage add-ons → Data feeds**: დარწმუნდით, რომ ჩართულია. დანამატის პარამეტრებში ჩაწერეთ **cron password** და შეინახეთ.
2. გახსენით data feed **„GOOGLE“**. ველები და მათი თანმიმდევრობა იგივე დატოვეთ:
   `Product code; Language; Price; Status; Product name; Description; Product URL; Image URL; List price; Category`
   (CSV, გამყოფი `;`, კოდირება UTF-8).
3. ექსპორტის ადგილად აირჩიეთ **სერვერი** და ჩაწერეთ ფაილის სახელი `products_GOOGLE.csv`.
   დაიმახსოვრეთ სრული გზა სერვერზე (მაგ. `/home/USER/public_html/var/files/1/products_GOOGLE.csv`).
4. data feed-ის/დანამატის გვერდზე CS-Cart აჩვენებს cron-ის ზუსტ ბრძანებას. ის დაახლოებით ასე გამოიყურება:
   `php /home/USER/public_html/ADMIN.php --dispatch=exim.cron_export --cron_password=PAROLI`
   (`ADMIN.php` — თქვენი ადმინ-პანელის ფაილის სახელი).

### 4. Cron-ის ორი ამოცანა (cPanel → Cron Jobs)
```
0 3 * * *  php /home/USER/public_html/ADMIN.php --dispatch=exim.cron_export --cron_password=PAROLI
30 3 * * * python3 /home/USER/superi_feed/superi_feed.py --csv /home/USER/public_html/var/files/1/products_GOOGLE.csv --out /home/USER/public_html/google-feed >> /home/USER/superi_feed/feed.log 2>&1
```
გზები შეცვალეთ თქვენი სერვერის რეალური გზებით.

შემოწმება: მეორე ბრძანება ერთხელ ხელით გაუშვით. უნდა გამოიტანოს მსგავსი ხაზი:
`feed=19025 new=0 skipped=0 unmapped_categories=0`.

### 5. Cloudflare: Google-ს არ დაუბლოკოთ ფიდი
საიტი ახლა ავტომატურ მოთხოვნებს Cloudflare-ის შემოწმებით ბლოკავს. **Security → WAF → Custom rules**-ში დაამატეთ წესი:
- If: *URI Path* starts with `/google-feed/`
- Then: **Skip** (ყველა დარჩენილი custom rule, Super Bot Fight Mode / Bot Fight Mode, rate limiting).

ასევე დარწმუნდით, რომ Google-ის ბოტები (Verified bots) დაშვებულია, თორემ Merchant Center პროდუქტის გვერდებსა და სურათებს ვერ ნახავს.

### 6. Merchant Center: ფაილის ბმულიდან ჩამოტვირთვა
**Products → Add products → Add products from a file → Enter a link to your file**:
- ბმული: `https://superi.ge/google-feed/superi_google_merchant_feed.tsv`
- სიხშირე: **Daily**, დრო **05:00**, დროის სარტყელი **Tbilisi (GMT+4)**
- ქვეყანა: Georgia, ენა: Georgian

თუ ფაილი უკვე ხელით გაქვთ ატვირთული, იმავე data source-ის პარამეტრებში შეცვალეთ წყარო ბმულზე. პროდუქტების ID-ები იგივე რჩება.
რეკომენდებულია **Automatic item updates**-ის ჩართვაც (ფასი/მარაგი საიტის მიხედვით).

## ყოველდღიური ანგარიში
`https://superi.ge/google-feed/superi_google_merchant_feed_report.txt` — პროდუქტების რაოდენობა, ახალი პროდუქტები,
ამოღებული პროდუქტები (ფასის/სურათის გარეშე) და **ახალი კატეგორიები, რომლებიც Google-ის კატეგორიას ჯერ არ არის მიბმული**.
ასეთ კატეგორიას დროებით ზოგადი Google-კატეგორია ენიჭება. ზუსტი მიბმისთვის `catmap.py` უნდა განახლდეს.

---

## English — handover for the server admin / agent

**Bundle (everything in one file):**
`https://github.com/bestichi/dato/raw/claude/gallant-euler-rgbn7v/google_merchant/auto/superi_feed_bundle.zip`

```
superi_feed/superi_feed.py                  main script (Python 3.8+, stdlib only)
superi_feed/catmap.py                       CS-Cart category -> Google product category rules
superi_feed/brands.py                       brand detection
superi_feed/google_taxonomy_2021-09-21.tsv  Google taxonomy (id -> path)
seed/superi_google_merchant_feed.tsv        current approved feed = initial state
```

**Task:**
1. Unzip `superi_feed/` outside the web root (e.g. `~/superi_feed/`).
2. Create a public dir served at `https://superi.ge/google-feed/` and copy `seed/superi_google_merchant_feed.tsv` into it
   (the previous feed is used as state: confirmed brands, GTINs, extra images carry over).
3. CS-Cart admin → Add-ons → Data feeds: set a cron password; set the existing data feed **"GOOGLE"** to export to a
   server file (`products_GOOGLE.csv`; fields: `Product code;Language;Price;Status;Product name;Description;Product URL;Image URL;List price;Category`, delimiter `;`, UTF-8). Use the exact cron command CS-Cart shows for the add-on.
4. Crontab (server time; adjust paths):
   ```
   0 3 * * *  php /PATH/public_html/ADMIN.php --dispatch=exim.cron_export --cron_password=PASS
   30 3 * * * python3 ~/superi_feed/superi_feed.py --csv /PATH/products_GOOGLE.csv --out /PATH/public_html/google-feed >> ~/superi_feed/feed.log 2>&1
   ```
5. Run step 4's second line once by hand. Expected stdout: `<timestamp> feed=NNNNN new=N skipped=N unmapped_categories=N`.
   Output: `google-feed/superi_google_merchant_feed.tsv` + `google-feed/superi_google_merchant_feed_report.txt`.
6. Cloudflare → Security → WAF → Custom rules: *URI Path starts with `/google-feed/`* → **Skip** remaining custom rules,
   Bot Fight Mode, rate limiting. Keep Verified Bots (Googlebot, Google-InspectionTool, Storebot-Google) allowed.
7. Merchant Center → Products → Add products from a file → link
   `https://superi.ge/google-feed/superi_google_merchant_feed.tsv`, daily 05:00 Asia/Tbilisi. Optional: enable Automatic item updates.

**Script behaviour:** only Status `A` rows; `availability=in_stock`; `price`/`sale_price` from List price vs Price;
full-size image URL derived from the thumbnail; brand from previous feed or title, otherwise `Superi` +
`identifier_exists=no`; GTIN checksum-validated; HTML description → clean text. Atomic write.
Exit 1 = export not UTF-8 / garbled (`???`) / missing columns; exit 2 = fewer than 70 % of yesterday's products
(`--min-ratio` to change). On any non-zero exit the old feed is kept. Unknown new categories fall back to the
parent's Google category and are listed in the report; add rules to `catmap.py` for exact mapping.
