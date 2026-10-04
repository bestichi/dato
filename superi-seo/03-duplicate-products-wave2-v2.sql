-- superi.ge — დუბლიკატები, მე-2 ტალღა (6 წყვილი, Remeza გარეშე) + iPhone 17 Pro Max 256GB Cosmic Orange-ის არასწორი გადამისამართება
-- წესი: რჩება S-კოდიანი; თუ ორივე ან არცერთი S — მარაგში არსებული; შემდეგ — სუფთა მისამართიანი.
-- მეორე ითიშება (არ იშლება), მისი მისამართი 301-ით გადადის დარჩენილზე. დარჩენილი იღებს სუფთა მისამართს.

--   რჩება 12598 (S57080, 4048 ₾, InStock) -> /apple-iphone-17-pro-max-256gb-deep-blue/ | ითიშება 9830 (1236999, 4219 ₾) | S
--   რჩება 12599 (S83453, 4033 ₾, InStock) -> /apple-iphone-17-pro-max-256gb-silver/ | ითიშება 9832 (S65048, 4049 ₾) | both S, in stock
--   რჩება 13520 (S70367, 719 ₾, InStock) -> /lg-ultrawide-29-uwfhd-29u531a-w-ama-white/ | ითიშება 14253 (S22287, 700 ₾) | both S, clean URL
--   რჩება 8459 (13177, 719 ₾, InStock) -> /asus-prime-z790m-plus-4ddr5-lga1700-90mb1e70-m1eay0/ | ითიშება 8957 (801695, 690 ₾) | no S, clean URL
--   რჩება 8458 (13653, 539 ₾, InStock) -> /gigabyte-b760-gaming-x-4ddr5-lga1700/ | ითიშება 8966 (846328, 520 ₾) | no S, clean URL
--   რჩება 10358 (S98107, 380 ₾, InStock) -> /tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router/ | ითიშება 9761 (66010194683, 339 ₾) | S
--   iPhone Cosmic Orange 256GB: /apple-iphone-17-pro-max-256gb-cosmic-orange/ ახლა 2TB-ზე გადადის — ვაბრუნებთ 256GB პროდუქტზე (12597, S48891)

-- 0) გადამისამართების ფორმატი
SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'category-15' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');

-- 1) ძველი მისამართები -> დარჩენილი პროდუქტი (301)
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id) VALUES
(CONCAT(@pre,'apple-iphone-17-pro-max-256gb-deep-blue-ka',@post),'p',12598,'ka',1),
(CONCAT(@pre,'apple-iphone-17-pro-max-256gb-silver-ka',@post),'p',12599,'ka',1),
(CONCAT(@pre,'monitor-lg-lg-ultrawide-29u531a-w-amc-29-21-9-wfhd-2560x1080-ips-100-hz-white',@post),'p',13520,'ka',1),
(CONCAT(@pre,'asus-prime-z790m-plus-4ddr5-lga1700-90mb1e70-m1eay0-ka-2',@post),'p',8459,'ka',1),
(CONCAT(@pre,'gigabyte-b760-gaming-x-4ddr5-lga1700-ka',@post),'p',8458,'ka',1),
(CONCAT(@pre,'tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router-ka',@post),'p',10358,'ka',1),
(CONCAT(@pre,'apple-iphone-17-pro-max-256gb-cosmic-orange-ka',@post),'p',12597,'ka',1);

-- 2) მეორე პროდუქტის გათიშვა
UPDATE cscart_products SET status = 'D' WHERE product_id IN (9830,9832,14253,8957,8966,9761);

-- 3) გათიშულის მისამართის გათავისუფლება
UPDATE cscart_seo_names SET name = CONCAT('dup-', object_id) WHERE type = 'p' AND company_id = 1 AND lang_code = 'ka' AND object_id IN (9830,9832,14253,8957,8966,9761);

-- 4) iPhone 256GB Cosmic Orange: არასწორი გადამისამართების (256GB -> 2TB) წაშლა
DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) = 'apple-iphone-17-pro-max-256gb-cosmic-orange';

-- 5) დარჩენილ პროდუქტებს სუფთა მისამართი
UPDATE cscart_seo_names SET name = 'apple-iphone-17-pro-max-256gb-deep-blue' WHERE type = 'p' AND object_id = 12598 AND name = 'apple-iphone-17-pro-max-256gb-deep-blue-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'apple-iphone-17-pro-max-256gb-silver' WHERE type = 'p' AND object_id = 12599 AND name = 'apple-iphone-17-pro-max-256gb-silver-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router' WHERE type = 'p' AND object_id = 10358 AND name = 'tp-link-archer-ge230-be3600-dual-band-wi-fi-7-gaming-router-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'apple-iphone-17-pro-max-256gb-cosmic-orange' WHERE type = 'p' AND object_id = 12597 AND name = 'apple-iphone-17-pro-max-256gb-cosmic-orange-ka' AND company_id = 1 AND lang_code = 'ka';

-- 6) შემოწმება: დარჩენილები A + სუფთა მისამართი, გათიშულები D + dup-NNNN
SELECT p.product_id, p.product_code, p.status, s.name FROM cscart_products p LEFT JOIN cscart_seo_names s ON s.object_id = p.product_id AND s.type = 'p' AND s.lang_code = 'ka' WHERE p.product_id IN (12598,9830,12599,9832,13520,14253,8459,8957,8458,8966,10358,9761,12597) ORDER BY s.name;
