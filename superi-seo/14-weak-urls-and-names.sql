-- ============================================================================
-- superi.ge — სუსტი URL-ები, Thomson-ის არეული მისამართები, Sencor-ის 404 და სახელების შეცდომები
-- 1) 85 პროდუქტს ეძლევა აღწერითი მისამართი (/2/, /product-8910/, /180-aa-180/, ზედმეტი -ka …).
--    ძველი მისამართი 301-ით გადადის ახალზე. თუ ახალი მისამართი სხვა აქტიურ გვერდს უკავია, ეს პროდუქტი გამოტოვდება.
-- 2) Thomson: 50" და 55" ტელევიზორებს მისამართები ერთმანეთში ჰქონდათ არეული — ადგილს ვუცვლით.
-- 3) Sencor SVC 7221BK: /sencor-svc-7221bk-ka/ და /product-13985/ (404) -> 301 დარჩენილ პროდუქტზე (13986).
-- 4) სახელების შეცდომები: ავაჯის, კონტრუქცით, REGAL REGAL, აუზი აუზი, I(FX608JMI …
-- 5) სათაურების ბოლოში "| SUPERI.GE" -> "| Superi.ge" (ერთნაირი ბრენდი ყველგან).
-- ასლები: superi_bk_seo_14, superi_bk_desc_14, superi_bk_titles_14. დაბრუნება ბოლოშია.
-- გაშვების შემდეგ: ქეშის გასუფთავება და sitemap-ის თავიდან გენერაცია (AB: Advanced sitemap).
-- ============================================================================
SET NAMES utf8mb4;
SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'category-15' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');

-- 0) ასლები (მხოლოდ პირველ გაშვებაზე)
CREATE TABLE IF NOT EXISTS superi_bk_seo_14 AS SELECT * FROM cscart_seo_names WHERE type = 'p' AND company_id = 1 AND object_id IN (1256,1951,1952,2236,2237,2238,2275,2276,2277,2291,2300,2389,2390,2391,2392,2393,2394,2395,2396,2397,2670,2951,3283,3336,3494,3495,3496,3497,3498,3872,5157,5158,8802,8895,8896,8904,8906,8908,8909,8910,8911,8912,8913,8914,8915,8916,8917,8918,8919,8921,8923,8924,8925,8926,8927,8928,8929,8930,8932,8934,8935,8956,8960,8961,8964,8965,8967,8970,8971,8972,8973,8974,8975,8979,8980,8981,8987,8988,8989,9823,10246,10359,10444,12001,12055,12106,13748,13985,13986);
CREATE TABLE IF NOT EXISTS superi_bk_desc_14 AS SELECT product_id, lang_code, product, page_title, meta_description, short_description, full_description FROM cscart_product_descriptions WHERE product_id IN (1256,1313,2670,3283,8911,8916,8934,12001,14031);
CREATE TABLE IF NOT EXISTS superi_bk_titles_14 AS SELECT product_id, lang_code, page_title FROM cscart_product_descriptions WHERE lang_code = 'ka' AND page_title LIKE '%| SUPERI.GE%';

-- 1) აღწერითი მისამართები
DROP TEMPORARY TABLE IF EXISTS tmp_slug;
CREATE TEMPORARY TABLE tmp_slug AS SELECT object_id AS pid, name AS old_name, name AS new_name FROM cscart_seo_names LIMIT 0;
ALTER TABLE tmp_slug ADD COLUMN ok TINYINT NOT NULL DEFAULT 0;
INSERT INTO tmp_slug (pid, old_name, new_name) VALUES
(3336,'hagen-hrbf1832x-ka','hagen-hrbf1832x'),
(9823,'product-9823','bunebrivi-da-mkhutavi-airis-deteqtori-3314725'),
(3283,'80x80x70-57x70x65','baghis-avejis-kompleqti-magida-80x80x70-sm-skami-57x70x65-sm'),
(8802,'allibert-rosario-graphite-ka','allibert-rosario-graphite'),
(8895,'6-hy-009','baghis-avejis-kompleqti-magida-da-6-skami-hy-009'),
(8896,'product-8896','baghis-khis-avejis-kompleqti-17051330'),
(8904,'49x46-2-81x81x97','avejis-kompleqti-magida-49x46-sm-2-skami-81x81x97-sm'),
(8906,'2','baghis-avejis-kompleqti-magida-da-2-skami-17051478'),
(8908,'2-xb-4','avejis-kompleqti-magida-2-savardzeli-xb-4'),
(8909,'2-ka','baghis-avejis-kompleqti-magida-divani-da-2-savardzeli-17051526'),
(8910,'product-8910','baghis-avejis-kompleqti-17051527'),
(8911,'product-8911','baghis-avejis-kompleqti-dasaketsi-konstruqtsiit-17051530'),
(8912,'product-8912','baghis-avejis-kompleqti-17051529'),
(8913,'product-8913','baghis-avejis-kompleqti-17051528'),
(8914,'product-8914','baghis-avejis-kompleqti-17051534'),
(8915,'product-8915','baghis-avejis-kompleqti-17051535'),
(8916,'product-8916','baghis-avejis-kompleqti-17051548'),
(8917,'product-8917','baghis-avejis-kompleqti-17051570'),
(8918,'2-ka-2','baghis-avejis-kompleqti-magida-da-2-skami-17051569'),
(8919,'80x70-4-53x58x74','baghis-avejis-kompleqti-magida-80x70-sm-4-skami-53x58x74-sm'),
(8921,'2-ka-3','baghis-avejis-kompleqti-magida-da-2-savardzeli-17051602'),
(8923,'4-zt-0152b','baghis-avejis-kompleqti-magida-da-4-skami-zt-0152b'),
(8924,'product-8924','baghis-avejis-kompleqti-17051599'),
(8925,'90x66x70','avejis-kompleqti-dasaketsi-90x66x70-sm'),
(8926,'61x61x72-57x70x65','kompleqti-baghis-avejis-magida-61x61x72-sm-skami-57x70x65-sm'),
(8927,'137x72x63-5-65x65x37-5','baghis-avejis-kompleqti-137x72x63-5-sm-magida-65x65x37-5-sm'),
(8928,'106-6x74-4-73-5x59-8x108-jm-ps-t720','baghis-avejis-kompleqti-106-6x74-sm-4-skami-73-5x59-8x108-sm-jm-ps-t720'),
(8929,'130x90','baghis-avejis-kompleqti-130x90-sm'),
(8930,'6-sl-003','baghis-avejis-kompleqti-magida-da-6-skami-sl-003'),
(8932,'2-ka-4','baghis-avejis-kompleqti-divani-2-savardzeli-magida-17051631'),
(8934,'product-8934','baghis-avejis-kompleqti-17051659'),
(8935,'product-8935','baghis-avejis-nakrebi-17051657'),
(12055,'4-ss-011f-8b','baghis-avejis-kompleqti-magida-4-skami-ss-011f-8b'),
(13748,'product-13748','zetis-radiatori-s16755'),
(10246,'bauma-ka','bauma-eleqtro-sekatori'),
(1951,'07020919','samzareulos-skami-tetri-07020919'),
(1952,'07020918','samzareulos-skami-natsrisperi-07020918'),
(12106,'product-12106','midea-mwh100-20ed6-cis-w'),
(3872,'product-3872','midea-p8-plus-mp08gebk-ds'),
(1256,'244-150-22bt2415','batuti-244-sm-22bt2415'),
(2951,'3','3-adgiliani-premium-saqanela-gasashleli-a2958'),
(10359,'170x110x152','baghis-saqanela-170x110x152-sm'),
(2236,'180-aa-180','nadzvis-khe-dublini-180-sm-aa-180'),
(2237,'210-aa-210','nadzvis-khe-dublini-210-sm-aa-210'),
(2238,'240-aa-240','nadzvis-khe-kolorado-240-sm-aa-240'),
(2275,'180-bc-180','nadzvis-khe-himalai-180-sm-bc-180'),
(2276,'210-bc-210','nadzvis-khe-himalai-210-sm-bc-210'),
(2277,'270-bc-270','nadzvis-khe-himalai-270-sm-bc-270'),
(2291,'240-ef-240','nadzvis-khe-ohaio-240-sm-ef-240'),
(2300,'150-zx-150','nadzvis-khe-bavaria-150-sm-zx-150'),
(2389,'180-23sn2675-180','nadzvis-khe-180-sm-23sn2675-180'),
(2390,'210-23sn2675-210','nadzvis-khe-210-sm-23sn2675-210'),
(2391,'240-23sn2675-240','nadzvis-khe-240-sm-23sn2675-240'),
(2392,'270-23sn2675-270','nadzvis-khe-270-sm-23sn2675-270'),
(2393,'180-23sn2732-180','datovlili-nadzvis-khe-180-sm-23sn2732-180'),
(2394,'210-23sn2732-210','nadzvis-khe-210-sm-23sn2732-210'),
(2395,'270-23sn2732-270','nadzvis-khe-270-sm-23sn2732-270'),
(2396,'300-23sn2732-300','nadzvis-khe-300-sm-23sn2732-300'),
(2397,'210-22sn1323-210','nadzvis-khe-210-sm-22sn1323-210'),
(3494,'270-2335-270','nadzvis-khe-270-sm-2335-270'),
(3495,'270-2223-270','datovlili-nadzvis-khe-270-sm-2223-270'),
(3496,'210-2223-270','datovlili-nadzvis-khe-210-sm-2223-210'),
(3497,'180-2223-180','datovlili-nadzvis-khe-180-sm-2223-180'),
(3498,'270-2355-210','nadzvis-khe-270-sm-2355-210'),
(8956,'asus-prime-b760-plus-4ddr5-lga1700-90mb1ef0-m1eay0-ka','asus-prime-b760-plus-4ddr5-lga1700-90mb1ef0-m1eay0'),
(8960,'asus-prime-h610m-r-d4-si-2ddr4-lga1700-90mb1b40-m0ecy0-ka','asus-prime-h610m-r-d4-si-2ddr4-lga1700-90mb1b40-m0ecy0'),
(8961,'asus-prime-h610m-k-d4-2ddr4-lga1700-90mb1a10-m0eay0-ka','asus-prime-h610m-k-d4-2ddr4-lga1700-90mb1a10-m0eay0'),
(8964,'gigabyte-b760m-h-ddr4-2ddr4-lga1700-ka','gigabyte-b760m-h-ddr4-2ddr4-lga1700'),
(8965,'gigabyte-h610m-k-ddr4-2ddr4-lga1700-ka','gigabyte-h610m-k-ddr4-2ddr4-lga1700'),
(8967,'gigabyte-b760m-d3hp-ddr4-4ddr4-lga1700-9mb76m3p4-00-g10-ka','gigabyte-b760m-d3hp-ddr4-4ddr4-lga1700-9mb76m3p4-00-g10'),
(8970,'gigabyte-b860m-d3hp-4ddr5-lga1851-ka','gigabyte-b860m-d3hp-4ddr5-lga1851'),
(8971,'gigabyte-b850m-d3hp-4ddr5-am5-ka','gigabyte-b850m-d3hp-4ddr5-am5'),
(8972,'asus-prime-h610m-k-2ddr5-lga1700-90mb1ga0-m0eay0-ka','asus-prime-h610m-k-2ddr5-lga1700-90mb1ga0-m0eay0'),
(8973,'asus-prime-x870-p-wifi-4ddr5-am5-90mb1is0-m0eay0-ka','asus-prime-x870-p-wifi-4ddr5-am5-90mb1is0-m0eay0'),
(8974,'asus-prime-z890-p-wifi-4ddr5-lga1851-90mb1i70-m0eay0-ka','asus-prime-z890-p-wifi-4ddr5-lga1851-90mb1i70-m0eay0'),
(8975,'asus-rog-strix-z890-h-gaming-wifi-4ddr5-lga1851-90mb1k20-m0eay0-ka','asus-rog-strix-z890-h-gaming-wifi-4ddr5-lga1851-90mb1k20-m0eay0'),
(8979,'gigabyte-b760-ds3h-4ddr5-lga1700-9mb76ds35-00-g10-ka','gigabyte-b760-ds3h-4ddr5-lga1700-9mb76ds35-00-g10'),
(8980,'gigabyte-b760m-gaming-x-ddr4-4ddr4-lga1700-9mb76mgx4-00-g10-ka','gigabyte-b760m-gaming-x-ddr4-4ddr4-lga1700-9mb76mgx4-00-g10'),
(8981,'asus-prime-b760m-k-d4-2ddr4-lga1700-90mb1ds0-m1eay0-ka','asus-prime-b760m-k-d4-2ddr4-lga1700-90mb1ds0-m1eay0'),
(8987,'asus-tuf-gaming-x870-plus-wifi-4ddr5-am5-90mb1iu0-m0eay0-ka','asus-tuf-gaming-x870-plus-wifi-4ddr5-am5-90mb1iu0-m0eay0'),
(8988,'asus-rog-maximus-z890-hero-4ddr5-lga1851-90mb1id0-m0eay0-ka','asus-rog-maximus-z890-hero-4ddr5-lga1851-90mb1id0-m0eay0'),
(8989,'asus-prime-b760m-k-2ddr5-lga1700-90mb1fi0-m1eay0-ka','asus-prime-b760m-k-2ddr5-lga1700-90mb1fi0-m1eay0'),
(10444,'product-10444','sarbeni-biliki-sensoruli-ekranit-9587441236'),
(12001,'product-12001','propesionaluri-sarbeni-biliki-88475631'),
(2670,'regal-regal-ty7454w-7','regal-ty7454w-7');
-- ახალ მისამართს თუ გათიშული/დამალული პროდუქტი იკავებს, ის თავისუფლდება (dup-ID)
UPDATE cscart_seo_names s JOIN cscart_products p ON p.product_id = s.object_id JOIN tmp_slug t ON t.new_name = s.name SET s.name = CONCAT('dup-', s.object_id) WHERE s.type = 'p' AND s.company_id = 1 AND p.status <> 'A' AND s.object_id <> t.pid;
-- მხოლოდ ის რიგები, სადაც პროდუქტს ახლაც ძველი მისამართი აქვს და ახალი თავისუფალია
UPDATE tmp_slug t SET t.ok = 1 WHERE EXISTS (SELECT 1 FROM cscart_seo_names s WHERE s.object_id = t.pid AND s.type = 'p' AND s.name = t.old_name AND s.lang_code = 'ka' AND s.company_id = 1) AND NOT EXISTS (SELECT 1 FROM cscart_seo_names s2 WHERE s2.name = t.new_name);
-- უკვე გადარქმეულები (განმეორებით გაშვებისას) — მხოლოდ ანგარიშისთვის
UPDATE tmp_slug t SET t.ok = 2 WHERE t.ok = 0 AND EXISTS (SELECT 1 FROM cscart_seo_names s WHERE s.object_id = t.pid AND s.type = 'p' AND s.name = t.new_name AND s.lang_code = 'ka' AND s.company_id = 1);
DELETE r FROM cscart_seo_redirects r JOIN tmp_slug t ON TRIM(BOTH '/' FROM r.src) = t.new_name AND t.ok = 1 WHERE r.company_id = 1;
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id) SELECT CONCAT(@pre, t.old_name, @post), 'p', t.pid, 'ka', 1 FROM tmp_slug t WHERE t.ok = 1;
UPDATE cscart_seo_names s JOIN tmp_slug t ON t.pid = s.object_id AND t.old_name = s.name AND t.ok = 1 SET s.name = t.new_name WHERE s.type = 'p' AND s.lang_code = 'ka' AND s.company_id = 1;

-- 2) Thomson: 5157 = 50UG4S14 (127 სმ), 5158 = 55UG4S14 (140 სმ) — მისამართების გაცვლა
UPDATE cscart_seo_names SET name = 'tmp-swap-5157' WHERE type = 'p' AND object_id = 5157 AND name = 'thomson-55ug4s14-140' AND lang_code = 'ka' AND company_id = 1;
UPDATE cscart_seo_names SET name = 'thomson-55ug4s14-140' WHERE type = 'p' AND object_id = 5158 AND name = 'thomson-50ug4s14-127' AND lang_code = 'ka' AND company_id = 1 AND EXISTS (SELECT 1 FROM (SELECT name FROM cscart_seo_names WHERE name = 'tmp-swap-5157') x);
UPDATE cscart_seo_names SET name = 'thomson-50ug4s14-127' WHERE type = 'p' AND object_id = 5157 AND name = 'tmp-swap-5157' AND lang_code = 'ka' AND company_id = 1 AND NOT EXISTS (SELECT 1 FROM (SELECT name FROM cscart_seo_names WHERE name = 'thomson-50ug4s14-127') x);
UPDATE cscart_seo_names SET name = 'thomson-55ug4s14-140' WHERE type = 'p' AND object_id = 5157 AND name = 'tmp-swap-5157' AND lang_code = 'ka' AND company_id = 1;

-- 3) Sencor: ძველი მისამართები -> 13986
UPDATE cscart_seo_names s JOIN cscart_products p ON p.product_id = s.object_id SET s.name = CONCAT('dup-', s.object_id) WHERE s.type = 'p' AND s.company_id = 1 AND p.status <> 'A' AND s.name IN ('sencor-svc-7221bk-ka', 'product-13985');
DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) IN ('sencor-svc-7221bk-ka', 'product-13985');
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id) SELECT CONCAT(@pre, x.n, @post), 'p', 13986, 'ka', 1 FROM (SELECT 'sencor-svc-7221bk-ka' AS n UNION ALL SELECT 'product-13985') x WHERE NOT EXISTS (SELECT 1 FROM cscart_seo_names s WHERE s.name = x.n);

-- 4) სახელების შეცდომები (სახელი, სათაური, მეტა აღწერა, აღწერები) — მხოლოდ ამ პროდუქტებში
UPDATE cscart_product_descriptions SET product = REPLACE(product, 'ავაჯის', 'ავეჯის'), page_title = REPLACE(page_title, 'ავაჯის', 'ავეჯის'), meta_description = REPLACE(meta_description, 'ავაჯის', 'ავეჯის'), short_description = REPLACE(short_description, 'ავაჯის', 'ავეჯის'), full_description = REPLACE(full_description, 'ავაჯის', 'ავეჯის') WHERE product_id = 8916 AND lang_code = 'ka';
UPDATE cscart_product_descriptions SET product = REPLACE(product, 'ავაჯის', 'ავეჯის'), page_title = REPLACE(page_title, 'ავაჯის', 'ავეჯის'), meta_description = REPLACE(meta_description, 'ავაჯის', 'ავეჯის'), short_description = REPLACE(short_description, 'ავაჯის', 'ავეჯის'), full_description = REPLACE(full_description, 'ავაჯის', 'ავეჯის') WHERE product_id = 8934 AND lang_code = 'ka';
UPDATE cscart_product_descriptions SET product = REPLACE(product, 'კონტრუქცით', 'კონსტრუქციით'), page_title = REPLACE(page_title, 'კონტრუქცით', 'კონსტრუქციით'), meta_description = REPLACE(meta_description, 'კონტრუქცით', 'კონსტრუქციით'), short_description = REPLACE(short_description, 'კონტრუქცით', 'კონსტრუქციით'), full_description = REPLACE(full_description, 'კონტრუქცით', 'კონსტრუქციით') WHERE product_id = 8911 AND lang_code = 'ka';
UPDATE cscart_product_descriptions SET product = REPLACE(product, 'სკამი57x70x65', 'სკამი 57x70x65'), page_title = REPLACE(page_title, 'სკამი57x70x65', 'სკამი 57x70x65'), meta_description = REPLACE(meta_description, 'სკამი57x70x65', 'სკამი 57x70x65'), short_description = REPLACE(short_description, 'სკამი57x70x65', 'სკამი 57x70x65'), full_description = REPLACE(full_description, 'სკამი57x70x65', 'სკამი 57x70x65') WHERE product_id = 3283 AND lang_code = 'ka';
UPDATE cscart_product_descriptions SET product = REPLACE(product, 'პროფესიონალი სარბენი', 'პროფესიონალური სარბენი'), page_title = REPLACE(page_title, 'პროფესიონალი სარბენი', 'პროფესიონალური სარბენი'), meta_description = REPLACE(meta_description, 'პროფესიონალი სარბენი', 'პროფესიონალური სარბენი'), short_description = REPLACE(short_description, 'პროფესიონალი სარბენი', 'პროფესიონალური სარბენი'), full_description = REPLACE(full_description, 'პროფესიონალი სარბენი', 'პროფესიონალური სარბენი') WHERE product_id = 12001 AND lang_code = 'ka';
UPDATE cscart_product_descriptions SET product = REPLACE(product, '150კგ_მდე', '150კგ-მდე'), page_title = REPLACE(page_title, '150კგ_მდე', '150კგ-მდე'), meta_description = REPLACE(meta_description, '150კგ_მდე', '150კგ-მდე'), short_description = REPLACE(short_description, '150კგ_მდე', '150კგ-მდე'), full_description = REPLACE(full_description, '150კგ_მდე', '150კგ-მდე') WHERE product_id = 1256 AND lang_code = 'ka';
UPDATE cscart_product_descriptions SET product = REPLACE(product, 'REGAL REGAL', 'REGAL'), page_title = REPLACE(page_title, 'REGAL REGAL', 'REGAL'), meta_description = REPLACE(meta_description, 'REGAL REGAL', 'REGAL'), short_description = REPLACE(short_description, 'REGAL REGAL', 'REGAL'), full_description = REPLACE(full_description, 'REGAL REGAL', 'REGAL') WHERE product_id = 2670 AND lang_code = 'ka';
UPDATE cscart_product_descriptions SET product = REPLACE(product, 'აუზი აუზი', 'აუზი'), page_title = REPLACE(page_title, 'აუზი აუზი', 'აუზი'), meta_description = REPLACE(meta_description, 'აუზი აუზი', 'აუზი'), short_description = REPLACE(short_description, 'აუზი აუზი', 'აუზი'), full_description = REPLACE(full_description, 'აუზი აუზი', 'აუზი') WHERE product_id = 1313 AND lang_code = 'ka';
UPDATE cscart_product_descriptions SET product = REPLACE(product, '165Hz I(FX608JMI', '165Hz (FX608JMI'), page_title = REPLACE(page_title, '165Hz I(FX608JMI', '165Hz (FX608JMI'), meta_description = REPLACE(meta_description, '165Hz I(FX608JMI', '165Hz (FX608JMI'), short_description = REPLACE(short_description, '165Hz I(FX608JMI', '165Hz (FX608JMI'), full_description = REPLACE(full_description, '165Hz I(FX608JMI', '165Hz (FX608JMI') WHERE product_id = 14031 AND lang_code = 'ka';

-- 5) სათაურებში ბრენდი ერთნაირად
UPDATE cscart_product_descriptions SET page_title = REPLACE(page_title, '| SUPERI.GE', '| Superi.ge') WHERE lang_code = 'ka' AND page_title LIKE '%| SUPERI.GE%';

-- 6) შედეგი
SELECT (SELECT COUNT(*) FROM tmp_slug) AS slugs_in_file, (SELECT COUNT(*) FROM tmp_slug WHERE ok = 1) AS slugs_renamed, (SELECT COUNT(*) FROM tmp_slug WHERE ok = 2) AS already_done, (SELECT IFNULL(GROUP_CONCAT(old_name SEPARATOR ', '), '-') FROM tmp_slug WHERE ok = 0) AS slugs_skipped, (SELECT GROUP_CONCAT(CONCAT(object_id, '=', name) SEPARATOR ', ') FROM cscart_seo_names WHERE type = 'p' AND object_id IN (5157, 5158) AND lang_code = 'ka') AS thomson, (SELECT COUNT(*) FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) IN ('sencor-svc-7221bk-ka', 'product-13985') AND object_id = 13986) AS sencor_redirects, (SELECT COUNT(*) FROM cscart_product_descriptions WHERE lang_code = 'ka' AND page_title LIKE BINARY '%| SUPERI.GE%') AS titles_uppercase_left;
DROP TEMPORARY TABLE IF EXISTS tmp_slug;

-- ============================================================================
-- დაბრუნება (კომენტარია, არ სრულდება):
-- DELETE r FROM cscart_seo_redirects r JOIN superi_bk_seo_14 b ON b.object_id = r.object_id AND r.type = 'p' AND TRIM(BOTH '/' FROM r.src) = b.name;
-- UPDATE cscart_seo_names s JOIN superi_bk_seo_14 b ON b.object_id = s.object_id AND b.type = s.type AND b.dispatch = s.dispatch AND b.lang_code = s.lang_code AND b.company_id = s.company_id SET s.name = b.name;
-- UPDATE cscart_product_descriptions d JOIN superi_bk_desc_14 b ON b.product_id = d.product_id AND b.lang_code = d.lang_code SET d.product = b.product, d.page_title = b.page_title, d.meta_description = b.meta_description, d.short_description = b.short_description, d.full_description = b.full_description;
-- UPDATE cscart_product_descriptions d JOIN superi_bk_titles_14 b ON b.product_id = d.product_id AND b.lang_code = d.lang_code SET d.page_title = b.page_title;
-- ============================================================================
