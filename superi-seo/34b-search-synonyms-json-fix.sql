-- ============================================================================
-- superi.ge — 34b: სინონიმების ფორმატის გასწორება
-- დამატება სინონიმებს JSON-ად ინახავს: ["დანა","დანის","დანები"].
-- SQL 34-მა ისინი მძიმით ჩაწერა (aco,ако,აკო) — ადმინში ცარიელი ჩანდა და ინდექსში ვერ მოხვდა.
-- ეს ფაილი 22 ჩანაწერს JSON ფორმატში გადაწერს. „დანების“-ს არ ეხება.
-- ატვირთვის შემდეგ: Live search → Synonyms → „Rebuild synonym index“ → ქეშის გასუფთავება.
-- ხელახლა გაშვება უსაფრთხოა (უკვე JSON-ს არ ეხება).
-- ============================================================================
SET NAMES utf8mb4;

UPDATE cscart_csc_live_search_synonyms
SET synonyms = CONCAT('["', REPLACE(synonyms, ',', '","'), '"]')
WHERE company_id = 1 AND lang_code = 'ka' AND synonyms NOT LIKE '[%' AND phrase IN ('akog', 'გამათბობელი', 'ninja', 'lg', 'lego', 'ყავის აპარატი', 'river 2', 'iphone 15', 'iphone 16', 'iphone 17', 'iphone 18', 'iphone', 'gorenje', 'samsung', 'honor', 'xiaomi', 'ტელევიზორი', 'მაცივარი', 'სარეცხი', 'მტვერსასრუტი', 'კონდიციონერი', 'გენერატორი');

-- შემოწმება: ყველა ხაზში synonyms უნდა იწყებოდეს [ -ით და is_json = 1
SELECT synonym_id, phrase, synonyms, JSON_VALID(synonyms) AS is_json FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' ORDER BY synonym_id;
