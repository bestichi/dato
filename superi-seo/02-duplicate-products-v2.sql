-- superi.ge — დუბლიკატი პროდუქტები, წესი: რჩება ის, ვისი კოდიც S-ით იწყება (11 წყვილი)
-- მეორე ითიშება (არ იშლება), მისი მისამართი 301-ით გადადის დარჩენილზე.
-- დარჩენილი პროდუქტი იღებს სუფთა მისამართს (-ka-ს გარეშე). ყველაფერი შექცევადია.

--   რჩება 1757 (179902, 694 ₾) -> /ardesto-dtf-m212x143/ | ითიშება 10248 (DTF-M212X143, 649 ₾) | no S
--   რჩება 10303 (S79860, 5190 ₾) -> /asus-tuf-a16-16-fa608pp-rv066-jaeger-gray/ | ითიშება 10328 (169261, 5299 ₾) | S
--   რჩება 13183 (S39230, 231 ₾) -> /bosch-twk4p434/ | ითიშება 3071 (I69733, 202 ₾) | S
--   რჩება 13380 (S62467, 949 ₾) -> /gorenje-gs643e90w/ | ითიშება 8363 (I95814, 1199 ₾) | S
--   რჩება 12739 (S11454, 399 ₾) -> /gorenje-mo20a3w/ | ითიშება 2380 (231347, 239 ₾) | S
--   რჩება 13726 (S45527, 500 ₾) -> /janome-jl-23/ | ითიშება 771 (165972, 500 ₾) | S
--   რჩება 13540 (S27221, 293 ₾) -> /lg-24u411a-b-24-fhd-24u411a-b-amcq-black/ | ითიშება 11977 (172226, 319 ₾) | S
--   რჩება 12162 (S78671, 239 ₾) -> /midea-ag720c2mv-s/ | ითიშება 12164 (S12775, 229 ₾) | both S
--   რჩება 8454 (165954, 1099 ₾) -> /samsung-qe43q7faauxru-4k-qled-109/ | ითიშება 8506 (I98012, 1099 ₾) | no S
--   რჩება 9669 (7314518169009, 999 ₾) -> /schpindel-schi-169009-2-8kw-x208cc/ | ითიშება 12795 (7314518169009, 969 ₾) | no S
--   რჩება 13150 (S40329, 715 ₾) -> /akog-5-sp-sit-60-70-m2-black/ | ითიშება 13585 (S60723, 799 ₾) | both S

-- 0) გადამისამართების ფორმატის დადგენა
SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'category-15' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');

-- 1) -ka მისამართი -> დარჩენილი პროდუქტი (301)
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id) VALUES
(CONCAT(@pre,'ardesto-dtf-m212x143-ka',@post),'p',1757,'ka',1),
(CONCAT(@pre,'asus-tuf-a16-16-fa608pp-rv066-jaeger-gray-ka',@post),'p',10303,'ka',1),
(CONCAT(@pre,'bosch-twk4p434-ka',@post),'p',13183,'ka',1),
(CONCAT(@pre,'gorenje-gs643e90w-ka',@post),'p',13380,'ka',1),
(CONCAT(@pre,'gorenje-mo20a3w-ka',@post),'p',12739,'ka',1),
(CONCAT(@pre,'janome-jl-23-ka',@post),'p',13726,'ka',1),
(CONCAT(@pre,'lg-24u411a-b-24-fhd-24u411a-b-amcq-black-ka',@post),'p',13540,'ka',1),
(CONCAT(@pre,'midea-ag720c2mv-s-ka',@post),'p',12162,'ka',1),
(CONCAT(@pre,'samsung-qe43q7faauxru-4k-qled-109-ka',@post),'p',8454,'ka',1),
(CONCAT(@pre,'schpindel-schi-169009-2-8kw-x208cc-ka',@post),'p',9669,'ka',1),
(CONCAT(@pre,'akog-5-sp-sit-60-70-m2-black-ka',@post),'p',13150,'ka',1);

-- 2) მეორე პროდუქტის გათიშვა (status D = Disabled)
UPDATE cscart_products SET status = 'D' WHERE product_id IN (10248,10328,3071,8363,2380,771,11977,12164,8506,12795,13585);

-- 3) გათიშული პროდუქტის მისამართის გათავისუფლება
UPDATE cscart_seo_names SET name = CONCAT('dup-', object_id) WHERE type = 'p' AND company_id = 1 AND lang_code = 'ka' AND object_id IN (10248,10328,3071,8363,2380,771,11977,12164,8506,12795,13585);

-- 4) S-პროდუქტს სუფთა მისამართი (-ka-ს გარეშე)
UPDATE cscart_seo_names SET name = 'bosch-twk4p434' WHERE type = 'p' AND object_id = 13183 AND name = 'bosch-twk4p434-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'gorenje-gs643e90w' WHERE type = 'p' AND object_id = 13380 AND name = 'gorenje-gs643e90w-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'gorenje-mo20a3w' WHERE type = 'p' AND object_id = 12739 AND name = 'gorenje-mo20a3w-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'janome-jl-23' WHERE type = 'p' AND object_id = 13726 AND name = 'janome-jl-23-ka' AND company_id = 1 AND lang_code = 'ka';
UPDATE cscart_seo_names SET name = 'lg-24u411a-b-24-fhd-24u411a-b-amcq-black' WHERE type = 'p' AND object_id = 13540 AND name = 'lg-24u411a-b-24-fhd-24u411a-b-amcq-black-ka' AND company_id = 1 AND lang_code = 'ka';

-- 5) შემოწმება: 22 ხაზი — დარჩენილები A + სუფთა მისამართი, გათიშულები D + dup-NNNN
SELECT p.product_id, p.product_code, p.status, s.name FROM cscart_products p LEFT JOIN cscart_seo_names s ON s.object_id = p.product_id AND s.type = 'p' AND s.lang_code = 'ka' WHERE p.product_id IN (1757,10248,10303,10328,13183,3071,13380,8363,12739,2380,13726,771,13540,11977,12162,12164,8454,8506,9669,12795,13150,13585) ORDER BY s.name;
