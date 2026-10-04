-- ============================================================================
-- superi.ge — დუბლიკატი: ELECTROLUX EW6S4R27W
--   რჩება   957  (173031, 1149 ₾) -> /electrolux-ew6s4r27w/
--   ითიშება 1584 (112642, 1099 ₾) -> /electrolux-ew6s4r27b/ 301-ით გადადის W-ზე
-- არაფერი იშლება — დაბრუნება ბოლოშია.
-- ============================================================================
SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'category-15' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');

DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) = 'electrolux-ew6s4r27b';
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id) VALUES (CONCAT(@pre,'electrolux-ew6s4r27b',@post), 'p', 957, 'ka', 1);
UPDATE cscart_products SET status = 'D' WHERE product_id = 1584;
UPDATE cscart_seo_names SET name = 'dup-1584' WHERE type = 'p' AND object_id = 1584 AND name = 'electrolux-ew6s4r27b' AND company_id = 1 AND lang_code = 'ka';

-- შემოწმება: 957 = A + electrolux-ew6s4r27w, 1584 = D + dup-1584
SELECT p.product_id, p.product_code, p.status, s.name FROM cscart_products p LEFT JOIN cscart_seo_names s ON s.object_id = p.product_id AND s.type = 'p' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE p.product_id IN (957, 1584);

-- დაბრუნება (კომენტარია):
-- UPDATE cscart_products SET status = 'A' WHERE product_id = 1584;
-- UPDATE cscart_seo_names SET name = 'electrolux-ew6s4r27b' WHERE type = 'p' AND object_id = 1584 AND company_id = 1 AND lang_code = 'ka';
