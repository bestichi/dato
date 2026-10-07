-- ============================================================================
-- superi.ge — დუბლიკატი EPSON L15160, ვერსია 2 (33-ის ნაცვლად! 33 აღარ ატვირთო)
-- საიტზე მდგომარეობა შეიცვალა: 5098 მარაგში აღარ არის და მისამართი შეეცვალა
-- (/epson-l15160-c11ch71504-ka/), 3415 კი მარაგშია. ამიტომ ახლა რჩება 3415.
--
--   რჩება    3415  /epson-l15160-c11ch71504/      (მარაგშია)
--   ითიშება  5098  /epson-l15160-c11ch71504-ka/   (მარაგში არ არის)
--   ორივე ძველი მისამართი 5098-ისა 301-ით გადადის 3415-ზე:
--     /epson-l15160-c11ch71404/  და  /epson-l15160-c11ch71504-ka/
--   3415-ის სახელში კოდი სწორდება: (C11CH71504) → (C11CH71404) — სწორი კოდი C11CH71404-ია.
--
-- არაფერი იშლება. დაბრუნება — ბოლოში.
-- ============================================================================
SET NAMES utf8mb4;

-- 0) გადამისამართების ფორმატი
SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'category-15' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');

-- 1) ამ ორ მისამართზე არსებული ძველი გადამისამართებების წაშლა
DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) IN ('epson-l15160-c11ch71404', 'epson-l15160-c11ch71504-ka');

-- 2) ორივე მისამართი -> 3415 (301)
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id)
SELECT CONCAT(@pre,'epson-l15160-c11ch71404',@post), 'p', 3415, 'ka', 1 FROM cscart_products WHERE product_id = 3415;
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id)
SELECT CONCAT(@pre,'epson-l15160-c11ch71504-ka',@post), 'p', 3415, 'ka', 1 FROM cscart_products WHERE product_id = 3415;

-- 3) 5098-ის გათიშვა (მხოლოდ თუ ნამდვილად ეს Epson-ია)
UPDATE cscart_products SET status = 'D' WHERE product_id = 5098 AND product_code = 'C11CH71404';

-- 4) 5098-ის მისამართის გათავისუფლება
UPDATE cscart_seo_names SET name = 'dup-5098' WHERE type = 'p' AND object_id = 5098 AND company_id = 1 AND lang_code = 'ka' AND name = 'epson-l15160-c11ch71504-ka';

-- 5) 3415-ის სახელსა და სათაურში კოდის გასწორება
UPDATE cscart_product_descriptions SET product = REPLACE(product, '(C11CH71504)', '(C11CH71404)'), page_title = REPLACE(page_title, '(C11CH71504)', '(C11CH71404)') WHERE product_id = 3415 AND lang_code = 'ka';

-- 6) შემოწმება: 3415 = A + epson-l15160-c11ch71504; 5098 = D + dup-5098; ორივე გადამისამართება -> 3415
SELECT p.product_id, p.product_code, p.status, s.name FROM cscart_products p LEFT JOIN cscart_seo_names s ON s.object_id = p.product_id AND s.type = 'p' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE p.product_id IN (3415, 5098);
SELECT src, type, object_id FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) IN ('epson-l15160-c11ch71404', 'epson-l15160-c11ch71504-ka');

-- ============================================================================
-- დაბრუნება (მხოლოდ საჭიროების შემთხვევაში; კომენტარია, არ სრულდება):
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 5098;
-- UPDATE cscart_seo_names SET name = 'epson-l15160-c11ch71504-ka' WHERE type = 'p' AND object_id = 5098 AND company_id = 1 AND lang_code = 'ka';
-- DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) = 'epson-l15160-c11ch71504-ka';
-- UPDATE cscart_seo_redirects SET object_id = 5098 WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) = 'epson-l15160-c11ch71404';
-- UPDATE cscart_product_descriptions SET product = REPLACE(product, '(C11CH71404)', '(C11CH71504)'), page_title = REPLACE(page_title, '(C11CH71404)', '(C11CH71504)') WHERE product_id = 3415 AND lang_code = 'ka';
-- ============================================================================
