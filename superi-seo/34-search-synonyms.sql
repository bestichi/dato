-- ============================================================================
-- superi.ge — 34: საიტის ძებნის სინონიმები (Live search) — 22 ჯგუფი
-- „Search for“ (რას ეძებს საიტი)  ←  „When user types“ (რას წერს მყიდველი)
-- ფორმატი აღებულია შენ მიერ ადმინიდან დამატებული „დანების“ სინონიმიდან.
-- უკვე არსებულ ფრაზას არ ეხება; ხელახლა გაშვება უსაფრთხოა. დაბრუნება — ბოლოში.
-- ============================================================================
SET NAMES utf8mb4;
SET @raw := (SELECT synonyms FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'დანების' LIMIT 1);
SET @sep := IF(LOCATE(CHAR(10), IFNULL(@raw,'')) > 0, CHAR(10), IF(LOCATE(', ', IFNULL(@raw,'')) > 0, ', ', ','));

-- akog  ←  aco, ако, აკო, აკოგ
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'akog', CONCAT_WS(@sep, 'aco', 'ако', 'აკო', 'აკოგ'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'akog');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'akog' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'aco' AS word UNION ALL SELECT 'ако' UNION ALL SELECT 'აკო' UNION ALL SELECT 'აკოგ' UNION ALL SELECT 'akog') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- გამათბობელი  ←  გამათბობელუ, გამათბობლები, აირგამათბობელი, გამატბობელი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'გამათბობელი', CONCAT_WS(@sep, 'გამათბობელუ', 'გამათბობლები', 'აირგამათბობელი', 'გამატბობელი'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'გამათბობელი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'გამათბობელი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'გამათბობელუ' AS word UNION ALL SELECT 'გამათბობლები' UNION ALL SELECT 'აირგამათბობელი' UNION ALL SELECT 'გამატბობელი' UNION ALL SELECT 'გამათბობელი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ninja  ←  ნინჯა, ნინჯას, ნინძა
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ninja', CONCAT_WS(@sep, 'ნინჯა', 'ნინჯას', 'ნინძა'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ninja');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ninja' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ნინჯა' AS word UNION ALL SELECT 'ნინჯას' UNION ALL SELECT 'ნინძა' UNION ALL SELECT 'ninja') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- lg  ←  ლჯ, ელჯი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'lg', CONCAT_WS(@sep, 'ლჯ', 'ელჯი'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'lg');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'lg' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ლჯ' AS word UNION ALL SELECT 'ელჯი' UNION ALL SELECT 'lg') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- lego  ←  ლეგო, legო
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'lego', CONCAT_WS(@sep, 'ლეგო', 'legო'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'lego');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'lego' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ლეგო' AS word UNION ALL SELECT 'legო' UNION ALL SELECT 'lego') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ყავის აპარატი  ←  ესპრესო, ესპრესოს, кофемашина
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ყავის აპარატი', CONCAT_WS(@sep, 'ესპრესო', 'ესპრესოს', 'кофемашина'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ყავის აპარატი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ყავის აპარატი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ესპრესო' AS word UNION ALL SELECT 'ესპრესოს' UNION ALL SELECT 'кофемашина' UNION ALL SELECT 'ყავის აპარატი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- river 2  ←  river2
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'river 2', CONCAT_WS(@sep, 'river2'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'river 2');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'river 2' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'river2' AS word UNION ALL SELECT 'river 2') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- iphone 15  ←  iphone15
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'iphone 15', CONCAT_WS(@sep, 'iphone15'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'iphone 15');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'iphone 15' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'iphone15' AS word UNION ALL SELECT 'iphone 15') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- iphone 16  ←  iphone16
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'iphone 16', CONCAT_WS(@sep, 'iphone16'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'iphone 16');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'iphone 16' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'iphone16' AS word UNION ALL SELECT 'iphone 16') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- iphone 17  ←  iphone17
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'iphone 17', CONCAT_WS(@sep, 'iphone17'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'iphone 17');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'iphone 17' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'iphone17' AS word UNION ALL SELECT 'iphone 17') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- iphone 18  ←  iphone18
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'iphone 18', CONCAT_WS(@sep, 'iphone18'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'iphone 18');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'iphone 18' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'iphone18' AS word UNION ALL SELECT 'iphone 18') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- iphone  ←  აიფონი, აიფონ, айфон
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'iphone', CONCAT_WS(@sep, 'აიფონი', 'აიფონ', 'айфон'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'iphone');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'iphone' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'აიფონი' AS word UNION ALL SELECT 'აიფონ' UNION ALL SELECT 'айфон' UNION ALL SELECT 'iphone') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- gorenje  ←  გორენჯე, горенье
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'gorenje', CONCAT_WS(@sep, 'გორენჯე', 'горенье'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'gorenje');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'gorenje' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'გორენჯე' AS word UNION ALL SELECT 'горенье' UNION ALL SELECT 'gorenje') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- samsung  ←  самсунг
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'samsung', CONCAT_WS(@sep, 'самсунг'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'samsung');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'samsung' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'самсунг' AS word UNION ALL SELECT 'samsung') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- honor  ←  ჰონორი, ჰონორ, хонор
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'honor', CONCAT_WS(@sep, 'ჰონორი', 'ჰონორ', 'хонор'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'honor');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'honor' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ჰონორი' AS word UNION ALL SELECT 'ჰონორ' UNION ALL SELECT 'хонор' UNION ALL SELECT 'honor') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- xiaomi  ←  სიაომი, შაომი, ქსიაომი, ксиоми
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'xiaomi', CONCAT_WS(@sep, 'სიაომი', 'შაომი', 'ქსიაომი', 'ксиоми'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'xiaomi');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'xiaomi' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'სიაომი' AS word UNION ALL SELECT 'შაომი' UNION ALL SELECT 'ქსიაომი' UNION ALL SELECT 'ксиоми' UNION ALL SELECT 'xiaomi') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ტელევიზორი  ←  ტელევიზორები, ტელეკი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ტელევიზორი', CONCAT_WS(@sep, 'ტელევიზორები', 'ტელეკი'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ტელევიზორი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ტელევიზორი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ტელევიზორები' AS word UNION ALL SELECT 'ტელეკი' UNION ALL SELECT 'ტელევიზორი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- მაცივარი  ←  მაცივრები, მაცივრის
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'მაცივარი', CONCAT_WS(@sep, 'მაცივრები', 'მაცივრის'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მაცივარი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მაცივარი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'მაცივრები' AS word UNION ALL SELECT 'მაცივრის' UNION ALL SELECT 'მაცივარი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- სარეცხი  ←  სარეცხის
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'სარეცხი', CONCAT_WS(@sep, 'სარეცხის'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'სარეცხი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'სარეცხი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'სარეცხის' AS word UNION ALL SELECT 'სარეცხი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- მტვერსასრუტი  ←  მტვერსასრუტები, პილესოსი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'მტვერსასრუტი', CONCAT_WS(@sep, 'მტვერსასრუტები', 'პილესოსი'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მტვერსასრუტი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მტვერსასრუტი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'მტვერსასრუტები' AS word UNION ALL SELECT 'პილესოსი' UNION ALL SELECT 'მტვერსასრუტი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- კონდიციონერი  ←  კონდიციონერები, კანდიციონერი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'კონდიციონერი', CONCAT_WS(@sep, 'კონდიციონერები', 'კანდიციონერი'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'კონდიციონერი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'კონდიციონერი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'კონდიციონერები' AS word UNION ALL SELECT 'კანდიციონერი' UNION ALL SELECT 'კონდიციონერი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- გენერატორი  ←  გენერატორები, генератор
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'გენერატორი', CONCAT_WS(@sep, 'გენერატორები', 'генератор'), UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'გენერატორი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'გენერატორი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'გენერატორები' AS word UNION ALL SELECT 'генератор' UNION ALL SELECT 'გენერატორი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- შემოწმება: 22 ახალი ჯგუფი + „დანების“
SELECT s.synonym_id, s.phrase, REPLACE(s.synonyms, CHAR(10), ' | ') AS synonyms, COUNT(w.word_id) AS words FROM cscart_csc_live_search_synonyms s LEFT JOIN cscart_csc_live_search_synonym_words w ON w.synonym_id = s.synonym_id WHERE s.company_id = 1 AND s.lang_code = 'ka' GROUP BY s.synonym_id, s.phrase, s.synonyms ORDER BY s.synonym_id;

-- ============================================================================
-- დაბრუნება (მხოლოდ საჭიროების შემთხვევაში; კომენტარია, არ სრულდება):
-- DELETE w FROM cscart_csc_live_search_synonym_words w JOIN cscart_csc_live_search_synonyms s ON s.synonym_id = w.synonym_id WHERE s.company_id = 1 AND s.lang_code = 'ka' AND s.phrase IN ('akog', 'გამათბობელი', 'ninja', 'lg', 'lego', 'ყავის აპარატი', 'river 2', 'iphone 15', 'iphone 16', 'iphone 17', 'iphone 18', 'iphone', 'gorenje', 'samsung', 'honor', 'xiaomi', 'ტელევიზორი', 'მაცივარი', 'სარეცხი', 'მტვერსასრუტი', 'კონდიციონერი', 'გენერატორი');
-- DELETE FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase IN ('akog', 'გამათბობელი', 'ninja', 'lg', 'lego', 'ყავის აპარატი', 'river 2', 'iphone 15', 'iphone 16', 'iphone 17', 'iphone 18', 'iphone', 'gorenje', 'samsung', 'honor', 'xiaomi', 'ტელევიზორი', 'მაცივარი', 'სარეცხი', 'მტვერსასრუტი', 'კონდიციონერი', 'გენერატორი');
-- ============================================================================
