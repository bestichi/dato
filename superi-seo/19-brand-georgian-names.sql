-- ============================================================================
-- superi.ge — ბრენდების ქართული სახელები სათაურებში (ასე ეძებენ Google-ში: „კარმა გამათბობელი“,
-- „სმეგის ჩაიდანი“, „ნოკიას ტელეფონები“, „დაისონის მტვერსასრუტი“ … ~17 000 ჩვენება).
-- 1) 13 ბრენდის სათაური: მაგ. „Karma (კარმა) გაზის გამათბობლები — საუკეთესო ფასები | Superi.ge“
--    (მხოლოდ თუ სათაური ჯერ შაბლონურია — ხელით შეცვლილს არ ეხება).
-- 2) ყველა ბრენდის მეტა აღწერაში გრამატიკა: „Karma-ის“ -> „Karma-ს“, „DYSON -ის“ -> „DYSON-ის“.
-- 3) Gorenje: /gorenje-superi-ge/ -> /gorenje/ (ძველი 301-ით გადადის).
-- ასლი: superi_bk_brand_19. დაბრუნება ბოლოშია.
-- ============================================================================
SET NAMES utf8mb4;
SET @et := (SELECT s.type FROM cscart_seo_names s JOIN cscart_product_feature_variant_descriptions vd ON vd.variant_id = s.object_id AND vd.lang_code = 'ka' WHERE s.name = 'samsung' AND s.lang_code = 'ka' AND vd.variant = 'SAMSUNG' LIMIT 1);
SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'category-15' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');
CREATE TABLE IF NOT EXISTS superi_bk_brand_19 AS SELECT vd.variant_id, vd.lang_code, vd.page_title, vd.meta_description FROM cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' WHERE vd.lang_code = 'ka';

-- 1) სათაურები
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'karma' SET vd.page_title = 'Karma (კარმა) გაზის გამათბობლები — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'fujiyama' SET vd.page_title = 'Fujiyama (ფუჯიამა) გაზის გამათბობლები — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'tamkera' SET vd.page_title = 'Tam-Kera (თამ კერა) — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'nokia' SET vd.page_title = 'Nokia (ნოკია) ტელეფონები — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'motorola' SET vd.page_title = 'Motorola (მოტოროლა) ტელეფონები — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'dyson' SET vd.page_title = 'Dyson (დაისონი) — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'beko' SET vd.page_title = 'Beko (ბეკო) — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'midea' SET vd.page_title = 'Midea (მიდეა) — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'gorenje-superi-ge' SET vd.page_title = 'Gorenje (გორენიე) — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'honor' SET vd.page_title = 'Honor (ჰონორი) — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'xiaomi' SET vd.page_title = 'Xiaomi (ქსიაომი) — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'samsung' SET vd.page_title = 'Samsung (სამსუნგი) — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'smeg' SET vd.page_title = 'Smeg (სმეგი) საქართველოში — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND (vd.page_title LIKE '% — საუკეთესო ფასები | Superi.ge' OR vd.page_title = '') AND vd.page_title NOT LIKE '%(%';

-- 2) მეტა აღწერის გრამატიკა (ხმოვანზე დამთავრებული ბრენდი -> „-ს“; ზედმეტი ჰარი „-ის“-მდე)
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' SET vd.meta_description = REGEXP_REPLACE(vd.meta_description, '^(.*[AEIOUaeiouაეიოუ])[[:space:]]*-ის პროდუქცია Superi', '\\1-ს პროდუქცია Superi') WHERE vd.lang_code = 'ka' AND vd.meta_description REGEXP '^.*[AEIOUaeiouაეიოუ][[:space:]]*-ის პროდუქცია Superi';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' SET vd.meta_description = REGEXP_REPLACE(vd.meta_description, '[[:space:]]+-ის პროდუქცია Superi', '-ის პროდუქცია Superi') WHERE vd.lang_code = 'ka' AND vd.meta_description REGEXP '[[:space:]]+-ის პროდუქცია Superi';

-- 3) Gorenje-ს სუფთა მისამართი
SET @gv := (SELECT object_id FROM cscart_seo_names WHERE type = @et AND name = 'gorenje-superi-ge' AND lang_code = 'ka' LIMIT 1);
DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) IN ('gorenje', 'gorenje-superi-ge') AND @gv IS NOT NULL AND NOT EXISTS (SELECT 1 FROM (SELECT name FROM cscart_seo_names WHERE name = 'gorenje') x);
UPDATE cscart_seo_names SET name = 'gorenje' WHERE type = @et AND object_id = @gv AND name = 'gorenje-superi-ge' AND lang_code = 'ka' AND NOT EXISTS (SELECT 1 FROM (SELECT name FROM cscart_seo_names WHERE name = 'gorenje') x);
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id) SELECT CONCAT(@pre, 'gorenje-superi-ge', @post), @et, @gv, 'ka', 1 FROM DUAL WHERE @gv IS NOT NULL AND EXISTS (SELECT 1 FROM cscart_seo_names WHERE type = @et AND object_id = @gv AND name = 'gorenje');

-- 4) შედეგი
SELECT s.name, vd.page_title, LEFT(vd.meta_description, 40) AS meta FROM cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' WHERE vd.lang_code = 'ka' AND s.name IN ('karma', 'fujiyama', 'tamkera', 'nokia', 'motorola', 'dyson', 'beko', 'midea', 'gorenje-superi-ge', 'honor', 'xiaomi', 'samsung', 'smeg', 'gorenje');

-- დაბრუნება (კომენტარია):
-- UPDATE cscart_product_feature_variant_descriptions vd JOIN superi_bk_brand_19 b ON b.variant_id = vd.variant_id AND b.lang_code = vd.lang_code SET vd.page_title = b.page_title, vd.meta_description = b.meta_description;
-- UPDATE cscart_seo_names SET name = 'gorenje-superi-ge' WHERE type = @et AND name = 'gorenje'; (+ წაშალეთ redirect 'gorenje-superi-ge')
