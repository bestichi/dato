-- superi.ge — დუბლიკატი პროდუქტები (11 წყვილი)
-- რჩება მისამართი -ka-ს გარეშე. -ka დუბლიკატი ითიშება (არ იშლება!),
-- მისი მისამართი კი 301-ით გადადის დარჩენილ პროდუქტზე. ყველაფერი შექცევადია.

-- 0) გადამისამართების ფორმატის დადგენა (კატეგორიების სკრიპტის მიხედვით)
SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'category-15' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');

-- 1) დუბლიკატის მისამართი -> დარჩენილი პროდუქტი (301)
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id) VALUES
(CONCAT(@pre,'ardesto-dtf-m212x143-ka',@post),'p',1757,'ka',1),
(CONCAT(@pre,'asus-tuf-a16-16-fa608pp-rv066-jaeger-gray-ka',@post),'p',10303,'ka',1),
(CONCAT(@pre,'bosch-twk4p434-ka',@post),'p',3071,'ka',1),
(CONCAT(@pre,'gorenje-gs643e90w-ka',@post),'p',8363,'ka',1),
(CONCAT(@pre,'gorenje-mo20a3w-ka',@post),'p',2380,'ka',1),
(CONCAT(@pre,'janome-jl-23-ka',@post),'p',771,'ka',1),
(CONCAT(@pre,'lg-24u411a-b-24-fhd-24u411a-b-amcq-black-ka',@post),'p',11977,'ka',1),
(CONCAT(@pre,'midea-ag720c2mv-s-ka',@post),'p',12162,'ka',1),
(CONCAT(@pre,'samsung-qe43q7faauxru-4k-qled-109-ka',@post),'p',8454,'ka',1),
(CONCAT(@pre,'schpindel-schi-169009-2-8kw-x208cc-ka',@post),'p',9669,'ka',1),
(CONCAT(@pre,'akog-5-sp-sit-60-70-m2-black-ka',@post),'p',13150,'ka',1);

-- 2) დუბლიკატების გათიშვა (status D = Disabled)
UPDATE cscart_products SET status = 'D' WHERE product_id IN (10248,10328,13183,13380,12739,13726,13540,12164,8506,12795,13585);

-- 3) გათიშული დუბლიკატის SEO სახელის გათავისუფლება, რომ ძველმა მისამართმა გადამისამართება დაიწყოს
UPDATE cscart_seo_names SET name = CONCAT('dup-', object_id) WHERE type = 'p' AND company_id = 1 AND lang_code = 'ka' AND object_id IN (10248,10328,13183,13380,12739,13726,13540,12164,8506,12795,13585);

-- 4) შემოწმება: 11 ხაზი, ყველა status = D და name = dup-NNNN
SELECT p.product_id, p.status, s.name FROM cscart_products p LEFT JOIN cscart_seo_names s ON s.object_id = p.product_id AND s.type = 'p' AND s.lang_code = 'ka' WHERE p.product_id IN (10248,10328,13183,13380,12739,13726,13540,12164,8506,12795,13585);

-- დაბრუნება (თუ დაგჭირდა): status = 'A' და name-ში ძველი მისამართი:
--   10248: ardesto-dtf-m212x143-ka  (რჩება 1757: ardesto-dtf-m212x143)
--   10328: asus-tuf-a16-16-fa608pp-rv066-jaeger-gray-ka  (რჩება 10303: asus-tuf-a16-16-fa608pp-rv066-jaeger-gray)
--   13183: bosch-twk4p434-ka  (რჩება 3071: bosch-twk4p434)
--   13380: gorenje-gs643e90w-ka  (რჩება 8363: gorenje-gs643e90w)
--   12739: gorenje-mo20a3w-ka  (რჩება 2380: gorenje-mo20a3w)
--   13726: janome-jl-23-ka  (რჩება 771: janome-jl-23)
--   13540: lg-24u411a-b-24-fhd-24u411a-b-amcq-black-ka  (რჩება 11977: lg-24u411a-b-24-fhd-24u411a-b-amcq-black)
--   12164: midea-ag720c2mv-s-ka  (რჩება 12162: midea-ag720c2mv-s)
--   8506: samsung-qe43q7faauxru-4k-qled-109-ka  (რჩება 8454: samsung-qe43q7faauxru-4k-qled-109)
--   12795: schpindel-schi-169009-2-8kw-x208cc-ka  (რჩება 9669: schpindel-schi-169009-2-8kw-x208cc)
--   13585: akog-5-sp-sit-60-70-m2-black-ka  (რჩება 13150: akog-5-sp-sit-60-70-m2-black)
