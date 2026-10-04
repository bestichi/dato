-- ============================================================================
-- superi.ge — დუბლიკატები, მე-3 ტალღა (5 წყვილი). შემოწმებულია ცოცხალ საიტზე.
-- წესი: S-კოდი → მარაგში არსებული → მეტი ფოტო → სუფთა მისამართი.
-- მეორე ითიშება (საიტზე ქრება), მისი მისამართი 301-ით გადადის დარჩენილზე;
-- დარჩენილი იღებს სუფთა მისამართს (-ka-ს გარეშე). არაფერი იშლება — დაბრუნება ბოლოშია.
-- ============================================================================
--   რჩება     8319 150709          1279 ₾ InStock    -> /asus-vivobook-15-x1504za-bq449-cool-silver/  (მარაგშია)
--   ითიშება   8313 150709          1279 ₾ OutOfStock
--   რჩება     8893 17051154        2149 ₾ InStock    -> /liam-collection-huc25431am/  (მარაგშია)
--   ითიშება   2634 D-17051154      2149 ₾ OutOfStock
--   რჩება    10110 6945878347304   1299 ₾ InStock    -> /midea-mfa01w80b-t-8/  (მარაგშია)
--   ითიშება   8432 6945878347304   1169 ₾ OutOfStock
--   რჩება     2710 S99921          5799 ₾ InStock    -> /midea-mfm-60arn1-rb6/  (S-კოდი)
--   ითიშება    268 176080          6499 ₾ OutOfStock
--   რჩება    12522 S60305          1149 ₾ InStock    -> /midea-mo715105gb/  (S-კოდი)
--   ითიშება   9739 6944271686164   1349 ₾ OutOfStock

SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'category-15' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');

-- 1) ძველი/არასწორი გადამისამართებების გასუფთავება ამ მისამართებზე
DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) IN (
  'asus-vivobook-15-x1504za-bq449-cool-silver-ka',
  'liam-collection-huc25431am-ka',
  'midea-mfa01w80b-t-8-ka',
  'midea-mfm-60arn1-rb6-ka',
  'midea-mo715105gb-ka',
  'asus-vivobook-15-x1504za-bq449-cool-silver',
  'liam-collection-huc25431am',
  'midea-mfa01w80b-t-8',
  'midea-mfm-60arn1-rb6',
  'midea-mo715105gb');

-- 2) ძველი მისამართი -> დარჩენილი პროდუქტი (301)
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id) VALUES
  (CONCAT(@pre,'asus-vivobook-15-x1504za-bq449-cool-silver-ka',@post), 'p', 8319, 'ka', 1),
  (CONCAT(@pre,'liam-collection-huc25431am-ka',@post), 'p', 8893, 'ka', 1),
  (CONCAT(@pre,'midea-mfa01w80b-t-8-ka',@post), 'p', 10110, 'ka', 1),
  (CONCAT(@pre,'midea-mfm-60arn1-rb6-ka',@post), 'p', 2710, 'ka', 1),
  (CONCAT(@pre,'midea-mo715105gb-ka',@post), 'p', 12522, 'ka', 1);

-- 3) მეორე პროდუქტის გათიშვა
UPDATE cscart_products SET status = 'D' WHERE product_id IN (8313,2634,8432,268,9739);

-- 4) გათიშულის მისამართის გათავისუფლება
UPDATE cscart_seo_names SET name = CONCAT('dup-', object_id) WHERE type = 'p' AND company_id = 1 AND lang_code = 'ka' AND object_id IN (8313,2634,8432,268,9739);

-- 5) დარჩენილს სუფთა მისამართი
UPDATE cscart_seo_names SET name = 'asus-vivobook-15-x1504za-bq449-cool-silver' WHERE type = 'p' AND object_id = 8319 AND name = 'asus-vivobook-15-x1504za-bq449-cool-silver-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'liam-collection-huc25431am' WHERE type = 'p' AND object_id = 8893 AND name = 'liam-collection-huc25431am-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'midea-mfa01w80b-t-8' WHERE type = 'p' AND object_id = 10110 AND name = 'midea-mfa01w80b-t-8-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'midea-mfm-60arn1-rb6' WHERE type = 'p' AND object_id = 2710 AND name = 'midea-mfm-60arn1-rb6-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'midea-mo715105gb' WHERE type = 'p' AND object_id = 12522 AND name = 'midea-mo715105gb-ka' AND company_id = 1 AND lang_code = 'ka';

-- 6) შემოწმება: 10 ხაზი — დარჩენილები A + სუფთა მისამართი, გათიშულები D + dup-ID
SELECT p.product_id, p.product_code, p.status, s.name FROM cscart_products p LEFT JOIN cscart_seo_names s ON s.object_id = p.product_id AND s.type = 'p' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE p.product_id IN (8319,8313,8893,2634,10110,8432,2710,268,12522,9739) ORDER BY s.name;

-- ============================================================================
-- დაბრუნება (კომენტარია, არ სრულდება):
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 8313;
-- UPDATE cscart_seo_names SET name = 'asus-vivobook-15-x1504za-bq449-cool-silver' WHERE type = 'p' AND object_id = 8313 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_seo_names SET name = 'asus-vivobook-15-x1504za-bq449-cool-silver-ka' WHERE type = 'p' AND object_id = 8319 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 2634;
-- UPDATE cscart_seo_names SET name = 'liam-collection-huc25431am' WHERE type = 'p' AND object_id = 2634 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_seo_names SET name = 'liam-collection-huc25431am-ka' WHERE type = 'p' AND object_id = 8893 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 8432;
-- UPDATE cscart_seo_names SET name = 'midea-mfa01w80b-t-8' WHERE type = 'p' AND object_id = 8432 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_seo_names SET name = 'midea-mfa01w80b-t-8-ka' WHERE type = 'p' AND object_id = 10110 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 268;
-- UPDATE cscart_seo_names SET name = 'midea-mfm-60arn1-rb6' WHERE type = 'p' AND object_id = 268 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_seo_names SET name = 'midea-mfm-60arn1-rb6-ka' WHERE type = 'p' AND object_id = 2710 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 9739;
-- UPDATE cscart_seo_names SET name = 'midea-mo715105gb' WHERE type = 'p' AND object_id = 9739 AND company_id = 1 AND lang_code = 'ka';
-- UPDATE cscart_seo_names SET name = 'midea-mo715105gb-ka' WHERE type = 'p' AND object_id = 12522 AND company_id = 1 AND lang_code = 'ka';
