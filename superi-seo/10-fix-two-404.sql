-- ============================================================================
-- superi.ge — 2 გვერდი 404-ით (Search Console)
-- 1) /motorola-moto-g35-5g-4-128gb-leaf-green/ — პროდუქტი არსებობს -ka მისამართზე (12602, S61584).
--    ვაბრუნებთ სუფთა მისამართზე, -ka 301-ით გადადის.
-- 2) /lg-65qned82a6b-165/ — ეს მოდელი საიტზე აღარ არის. 301-ით გადადის უახლოეს
--    ანალოგზე: LG 65QNED80A6A 65" (9849, მარაგშია).
-- თუ ეს მისამართები გათიშულ/დამალულ პროდუქტს უკავია, მას dup-ID სახელი ეძლევა.
-- ============================================================================
SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'category-15' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');

-- 0) ძველი მისამართის გათავისუფლება, თუ გათიშულ ან დამალულ პროდუქტს უკავია
UPDATE cscart_seo_names s JOIN cscart_products p ON p.product_id = s.object_id
SET s.name = CONCAT('dup-', s.object_id)
WHERE s.type = 'p' AND s.lang_code = 'ka' AND s.company_id = 1 AND p.status <> 'A'
  AND s.name IN ('lg-65qned82a6b-165', 'motorola-moto-g35-5g-4-128gb-leaf-green');

-- 1) ძველი გადამისამართებების გასუფთავება ამ მისამართებზე
DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) IN
  ('lg-65qned82a6b-165', 'motorola-moto-g35-5g-4-128gb-leaf-green', 'motorola-moto-g35-5g-4-128gb-leaf-green-ka');

-- 2) Motorola: -ka -> პროდუქტი (301) და სუფთა მისამართი პროდუქტს
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id)
VALUES (CONCAT(@pre, 'motorola-moto-g35-5g-4-128gb-leaf-green-ka', @post), 'p', 12602, 'ka', 1);
UPDATE cscart_seo_names SET name = 'motorola-moto-g35-5g-4-128gb-leaf-green'
WHERE type = 'p' AND object_id = 12602 AND name = 'motorola-moto-g35-5g-4-128gb-leaf-green-ka' AND company_id = 1 AND lang_code = 'ka'
  AND NOT EXISTS (SELECT 1 FROM (SELECT name FROM cscart_seo_names WHERE name = 'motorola-moto-g35-5g-4-128gb-leaf-green') t);

-- 3) LG 65QNED82A6B -> LG 65QNED80A6A (301)
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id)
VALUES (CONCAT(@pre, 'lg-65qned82a6b-165', @post), 'p', 9849, 'ka', 1);

-- 4) შემოწმება
SELECT name, object_id FROM cscart_seo_names WHERE type = 'p' AND name IN ('motorola-moto-g35-5g-4-128gb-leaf-green', 'motorola-moto-g35-5g-4-128gb-leaf-green-ka', 'lg-65qned82a6b-165');
SELECT src, object_id FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) IN ('lg-65qned82a6b-165', 'motorola-moto-g35-5g-4-128gb-leaf-green-ka');
