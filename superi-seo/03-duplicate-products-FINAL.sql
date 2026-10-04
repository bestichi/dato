-- ============================================================================
-- superi.ge — დუბლიკატები, მე-2 ტალღა — საბოლოო ვერსია (შემოწმებულია 2026-10-04)
-- 6 წყვილი + iPhone 17 Pro Max 256GB Cosmic Orange-ის არასწორი გადამისამართება
-- Remeza ამოღებულია (-11 / -16 = სხვა მოდელი).
--
-- წესი: რჩება S-კოდიანი; თუ ორივე/არცერთი S — მარაგში არსებული; შემდეგ — სუფთა მისამართიანი.
-- მეორე ითიშება (არ იშლება), მისი მისამართი 301-ით გადადის დარჩენილზე.
-- არაფერი იშლება: მხოლოდ სტატუსი და მისამართის სახელი იცვლება. დაბრუნება — ბოლოში.
-- ============================================================================
--
--   რჩება    12598 S57080        4048 ₾  -> /apple-iphone-17-pro-max-256gb-deep-blue/
--   ითიშება   9830 1236999       4219 ₾     (S)
--   რჩება    12599 S83453        4033 ₾  -> /apple-iphone-17-pro-max-256gb-silver/
--   ითიშება   9832 S65048        4049 ₾     (both S, in stock)
--   რჩება    13520 S70367         719 ₾  -> /lg-ultrawide-29-uwfhd-29u531a-w-ama-white/
--   ითიშება  14253 S22287         700 ₾     (both S, clean URL)
--   რჩება     8459 13177          719 ₾  -> /asus-prime-z790m-plus-4ddr5-lga1700-90mb1e70-m1eay0/
--   ითიშება   8957 801695         690 ₾     (no S, clean URL)
--   რჩება     8458 13653          539 ₾  -> /gigabyte-b760-gaming-x-4ddr5-lga1700/
--   ითიშება   8966 846328         520 ₾     (no S, clean URL)
--   რჩება    10358 S98107         380 ₾  -> /tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router/
--   ითიშება   9761 66010194683    339 ₾     (S)
--   iPhone 256GB Cosmic Orange: /apple-iphone-17-pro-max-256gb-cosmic-orange/ -> პროდუქტი 12597 (S48891); 2TB (9831) ხელუხლებელი რჩება

-- 0) გადამისამართების ფორმატი (წინა სკრიპტებში უკვე მუშაობს)
SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'category-15' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');

-- 1) ძველი/არასწორი გადამისამართებების გასუფთავება ამ მისამართებზე
--    (მათ შორის 256GB Cosmic Orange -> 2TB), რომ ახალი ჩანაწერები ზუსტად ჩაჯდეს
DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) IN (
  'apple-iphone-17-pro-max-256gb-deep-blue-ka',
  'apple-iphone-17-pro-max-256gb-silver-ka',
  'monitor-lg-lg-ultrawide-29u531a-w-amc-29-21-9-wfhd-2560x1080-ips-100-hz-white',
  'asus-prime-z790m-plus-4ddr5-lga1700-90mb1e70-m1eay0-ka-2',
  'gigabyte-b760-gaming-x-4ddr5-lga1700-ka',
  'tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router-ka',
  'apple-iphone-17-pro-max-256gb-cosmic-orange-ka',
  'apple-iphone-17-pro-max-256gb-deep-blue',
  'apple-iphone-17-pro-max-256gb-silver',
  'lg-ultrawide-29-uwfhd-29u531a-w-ama-white',
  'asus-prime-z790m-plus-4ddr5-lga1700-90mb1e70-m1eay0',
  'gigabyte-b760-gaming-x-4ddr5-lga1700',
  'tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router',
  'apple-iphone-17-pro-max-256gb-cosmic-orange');

-- 2) ძველი მისამართები -> დარჩენილი პროდუქტი (301)
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id) VALUES
  (CONCAT(@pre,'apple-iphone-17-pro-max-256gb-deep-blue-ka',@post), 'p', 12598, 'ka', 1),
  (CONCAT(@pre,'apple-iphone-17-pro-max-256gb-silver-ka',@post), 'p', 12599, 'ka', 1),
  (CONCAT(@pre,'monitor-lg-lg-ultrawide-29u531a-w-amc-29-21-9-wfhd-2560x1080-ips-100-hz-white',@post), 'p', 13520, 'ka', 1),
  (CONCAT(@pre,'asus-prime-z790m-plus-4ddr5-lga1700-90mb1e70-m1eay0-ka-2',@post), 'p', 8459, 'ka', 1),
  (CONCAT(@pre,'gigabyte-b760-gaming-x-4ddr5-lga1700-ka',@post), 'p', 8458, 'ka', 1),
  (CONCAT(@pre,'tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router-ka',@post), 'p', 10358, 'ka', 1),
  (CONCAT(@pre,'apple-iphone-17-pro-max-256gb-cosmic-orange-ka',@post), 'p', 12597, 'ka', 1);

-- 3) მეორე პროდუქტის გათიშვა (D = Disabled)
UPDATE cscart_products SET status = 'D' WHERE product_id IN (9830,9832,14253,8957,8966,9761);

-- 4) გათიშულის მისამართის გათავისუფლება (dup-ID)
UPDATE cscart_seo_names SET name = CONCAT('dup-', object_id) WHERE type = 'p' AND company_id = 1 AND lang_code = 'ka' AND object_id IN (9830,9832,14253,8957,8966,9761);

-- 5) დარჩენილ პროდუქტს სუფთა მისამართი (თითო ხაზი ზუსტად ერთ ჩანაწერს ცვლის)
UPDATE cscart_seo_names SET name = 'apple-iphone-17-pro-max-256gb-deep-blue' WHERE type = 'p' AND object_id = 12598 AND name = 'apple-iphone-17-pro-max-256gb-deep-blue-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'apple-iphone-17-pro-max-256gb-silver' WHERE type = 'p' AND object_id = 12599 AND name = 'apple-iphone-17-pro-max-256gb-silver-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router' WHERE type = 'p' AND object_id = 10358 AND name = 'tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'apple-iphone-17-pro-max-256gb-cosmic-orange' WHERE type = 'p' AND object_id = 12597 AND name = 'apple-iphone-17-pro-max-256gb-cosmic-orange-ka' AND company_id = 1 AND lang_code = 'ka';

-- 6) შემოწმება: 13 ხაზი. დარჩენილები — A + სუფთა მისამართი; გათიშულები — D + dup-ID
SELECT p.product_id, p.product_code, p.status, s.name FROM cscart_products p LEFT JOIN cscart_seo_names s ON s.object_id = p.product_id AND s.type = 'p' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE p.product_id IN (12598,9830,12599,9832,13520,14253,8459,8957,8458,8966,10358,9761,12597) ORDER BY s.name;

-- ============================================================================
-- დაბრუნება (მხოლოდ საჭიროების შემთხვევაში; ეს ხაზები არ სრულდება — კომენტარია):
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 9830;
-- UPDATE cscart_seo_names SET name = 'apple-iphone-17-pro-max-256gb-deep-blue' WHERE type = 'p' AND object_id = 9830 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_seo_names SET name = 'apple-iphone-17-pro-max-256gb-deep-blue-ka' WHERE type = 'p' AND object_id = 12598 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 9832;
-- UPDATE cscart_seo_names SET name = 'apple-iphone-17-pro-max-256gb-silver' WHERE type = 'p' AND object_id = 9832 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_seo_names SET name = 'apple-iphone-17-pro-max-256gb-silver-ka' WHERE type = 'p' AND object_id = 12599 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 14253;
-- UPDATE cscart_seo_names SET name = 'monitor-lg-lg-ultrawide-29u531a-w-amc-29-21-9-wfhd-2560x1080-ips-100-hz-white' WHERE type = 'p' AND object_id = 14253 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 8957;
-- UPDATE cscart_seo_names SET name = 'asus-prime-z790m-plus-4ddr5-lga1700-90mb1e70-m1eay0-ka-2' WHERE type = 'p' AND object_id = 8957 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 8966;
-- UPDATE cscart_seo_names SET name = 'gigabyte-b760-gaming-x-4ddr5-lga1700-ka' WHERE type = 'p' AND object_id = 8966 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 9761;
-- UPDATE cscart_seo_names SET name = 'tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router' WHERE type = 'p' AND object_id = 9761 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_seo_names SET name = 'tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router-ka' WHERE type = 'p' AND object_id = 10358 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_seo_names SET name = 'apple-iphone-17-pro-max-256gb-cosmic-orange-ka' WHERE type = 'p' AND object_id = 12597 AND company_id = 1 AND lang_code = 'ka';
-- ============================================================================
