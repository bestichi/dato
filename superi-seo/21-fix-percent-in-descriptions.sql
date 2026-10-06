-- 21: გაფუჭებული პროცენტის ნიშანი პროდუქტის აღწერებში (76 პროდუქტი)
-- "82.7&gt;#br###"  ->  "82.7%<br>"
-- "80&gt;#/p###"    ->  "80%"
-- Backup: superi_bk_desc_21

CREATE TABLE IF NOT EXISTS superi_bk_desc_21 AS
SELECT product_id, lang_code, full_description, short_description
FROM cscart_product_descriptions
WHERE full_description LIKE '%#br###%' OR full_description LIKE '%#/p###%'
   OR short_description LIKE '%#br###%' OR short_description LIKE '%#/p###%';

UPDATE cscart_product_descriptions SET
  full_description = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(full_description,
      '&gt;#br###', '%<br>'), '>#br###', '%<br>'),
      '&gt;#/p###', '%'),     '>#/p###', '%'),
      '#br###', '<br>'),      '#/p###', ''),
  short_description = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(short_description,
      '&gt;#br###', '%<br>'), '>#br###', '%<br>'),
      '&gt;#/p###', '%'),     '>#/p###', '%'),
      '#br###', '<br>'),      '#/p###', '')
WHERE full_description LIKE '%#br###%' OR full_description LIKE '%#/p###%'
   OR short_description LIKE '%#br###%' OR short_description LIKE '%#/p###%';

SELECT
  (SELECT COUNT(*) FROM superi_bk_desc_21) AS backed_up,
  (SELECT COUNT(*) FROM cscart_product_descriptions
    WHERE full_description LIKE '%#br###%' OR full_description LIKE '%#/p###%'
       OR short_description LIKE '%#br###%' OR short_description LIKE '%#/p###%') AS remaining;
