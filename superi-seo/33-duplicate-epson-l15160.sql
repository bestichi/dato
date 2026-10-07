-- ============================================================================
-- superi.ge — დუბლიკატი: EPSON L15160 (ორივეს კოდი C11CH71404, ფასი 4899 ₾)
--
--   რჩება    5098  /epson-l15160-c11ch71404/   (სწორი კოდი მისამართში, 6 ფოტო)
--   ითიშება  3415  /epson-l15160-c11ch71504/   (მისამართში არასწორი კოდი, 4 ფოტო)
--
-- არაფერი იშლება: 3415 მხოლოდ ითიშება (D), მისი ძველი მისამართი 301-ით გადადის 5098-ზე.
-- შეკვეთების ისტორია, ფოტოები, აღწერა — ხელუხლებელი რჩება. დაბრუნება — ბოლოში.
-- ============================================================================
SET NAMES utf8mb4;

-- 0) გადამისამართების ფორმატი (იგივე, რაც წინა სკრიპტებში)
SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'category-15' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');

-- 1) ძველი მისამართის ძველი გადამისამართება (თუ არსებობს) — წაიშალოს, რომ ახალი ზუსტად ჩაჯდეს
DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) = 'epson-l15160-c11ch71504';

-- 2) /epson-l15160-c11ch71504/ -> პროდუქტი 5098 (301)
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id)
SELECT CONCAT(@pre,'epson-l15160-c11ch71504',@post), 'p', 5098, 'ka', 1 FROM cscart_products WHERE product_id = 5098;

-- 3) 3415-ის გათიშვა (მხოლოდ თუ ნამდვილად ეს Epson-ია)
UPDATE cscart_products SET status = 'D' WHERE product_id = 3415 AND product_code = 'C11CH71404';

-- 4) 3415-ის მისამართის გათავისუფლება
UPDATE cscart_seo_names SET name = 'dup-3415' WHERE type = 'p' AND object_id = 3415 AND company_id = 1 AND lang_code = 'ka' AND name = 'epson-l15160-c11ch71504';

-- 5) შემოწმება: 5098 = A + epson-l15160-c11ch71404; 3415 = D + dup-3415; redirect -> 5098
SELECT p.product_id, p.product_code, p.status, s.name FROM cscart_products p LEFT JOIN cscart_seo_names s ON s.object_id = p.product_id AND s.type = 'p' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE p.product_id IN (5098, 3415);
SELECT src, type, object_id FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) = 'epson-l15160-c11ch71504';

-- ============================================================================
-- დაბრუნება (მხოლოდ საჭიროების შემთხვევაში; კომენტარია, არ სრულდება):
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 3415;
-- UPDATE cscart_seo_names SET name = 'epson-l15160-c11ch71504' WHERE type = 'p' AND object_id = 3415 AND company_id = 1 AND lang_code = 'ka';
-- DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) = 'epson-l15160-c11ch71504';
-- ============================================================================
