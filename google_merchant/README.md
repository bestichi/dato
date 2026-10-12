# Google Merchant Center feed — superi.ge

| ფაილი | დანიშნულება |
|---|---|
| `superi_google_merchant_feed.tsv` | Merchant Center-ში ასატვირთი ფაილი (tab-delimited, UTF-8) |
| `superi_google_merchant_feed.xlsx` | იგივე მონაცემები + შესამოწმებელი ფურცლები (ინსტრუქცია, კატეგორიების რუკა, ბრენდები, სათაურის ცვლილებები, ამოღებული პროდუქტები) |

ატვირთვა: Merchant Center → Products → Add products → Add products from a file → `superi_google_merchant_feed.tsv`.
ენა: ქართული, ქვეყანა: საქართველო, ვალუტა: GEL. მიწოდების და დაბრუნების პარამეტრები Merchant Center-ის ანგარიშში დააყენეთ.

## ხელახლა აწყობა (scripts/)

```bash
python3 -I scripts/crawl.py active.csv crawl.jsonl            # საიტის გვერდებიდან ფასი/მარაგი/ბრენდი/სურათები
python3 -I scripts/build.py active.csv crawl.jsonl taxonomy.tsv out [imgcheck.jsonl]
python3 -I scripts/imgcheck.py out/feed.json imgcheck.jsonl    # მთავარი სურათების შემოწმება
python3 -I scripts/finalize.py out/feed.json out               # ვალიდაცია + TSV/XLSX
```

`active.csv` — CS-Cart-ის ექსპორტი მხოლოდ `Status = A` პროდუქტებით; `taxonomy.tsv` — Google product taxonomy (2021-09-21) `id<TAB>path` ფორმატში.
