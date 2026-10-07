-- ============================================================================
-- superi.ge — 35: საიტის ძებნის სინონიმები, მე-2 პაკეტი — 64 ჯგუფი, 138 ვარიანტი
-- კატეგორიები (ლაპტოპი, პლანშეტი, ბოილერი, პაუერბანკი, самокат…) და ბრენდები ქართულად (ტოშიბა, ფილიპსი, ლენოვო…).
-- ფორმატი — იგივე JSON, რასაც დამატება იყენებს: ["ვარიანტი1","ვარიანტი2"].
-- ყველა წყვილი საიტზე გადამოწმებულია: მყიდველის სიტყვა ახლა ნაკლებს პოულობს, ვიდრე სწორი სიტყვა.
-- არსებულ ფრაზებს არ ეხება; ხელახლა გაშვება უსაფრთხოა.
-- ატვირთვის შემდეგ: Live search → Synonyms → „Rebuild synonym index“ → ქეშის გასუფთავება.
-- ============================================================================
SET NAMES utf8mb4;

-- ნოუთბუქი  ←  ლაპტოპი, ნოუთბუკი, ნოუთბუქები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ნოუთბუქი', '["ლაპტოპი","ნოუთბუკი","ნოუთბუქები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ნოუთბუქი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ნოუთბუქი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ლაპტოპი' AS word UNION ALL SELECT 'ნოუთბუკი' UNION ALL SELECT 'ნოუთბუქები' UNION ALL SELECT 'ნოუთბუქი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ტაბლეტი  ←  პლანშეტი, პლანშეტები, ტაბლეტები, планшет, tablet
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ტაბლეტი', '["პლანშეტი","პლანშეტები","ტაბლეტები","планшет","tablet"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ტაბლეტი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ტაბლეტი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'პლანშეტი' AS word UNION ALL SELECT 'პლანშეტები' UNION ALL SELECT 'ტაბლეტები' UNION ALL SELECT 'планшет' UNION ALL SELECT 'tablet' UNION ALL SELECT 'ტაბლეტი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ipad  ←  აიპადი, აიპედი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ipad', '["აიპადი","აიპედი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ipad');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ipad' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'აიპადი' AS word UNION ALL SELECT 'აიპედი' UNION ALL SELECT 'ipad') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ყურსასმენი  ←  ყურსასმენები, ნაუშნიკები, ყურსაცვამი, наушники, headphones, earbuds
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ყურსასმენი', '["ყურსასმენები","ნაუშნიკები","ყურსაცვამი","наушники","headphones","earbuds"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ყურსასმენი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ყურსასმენი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ყურსასმენები' AS word UNION ALL SELECT 'ნაუშნიკები' UNION ALL SELECT 'ყურსაცვამი' UNION ALL SELECT 'наушники' UNION ALL SELECT 'headphones' UNION ALL SELECT 'earbuds' UNION ALL SELECT 'ყურსასმენი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- სმარტ საათი  ←  სმარტსაათი, ჭკვიანი საათი, smartwatch, смарт часы
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'სმარტ საათი', '["სმარტსაათი","ჭკვიანი საათი","smartwatch","смарт часы"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'სმარტ საათი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'სმარტ საათი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'სმარტსაათი' AS word UNION ALL SELECT 'ჭკვიანი საათი' UNION ALL SELECT 'smartwatch' UNION ALL SELECT 'смарт часы' UNION ALL SELECT 'სმარტ საათი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- საყინულე  ←  საყინულეები, морозилка, ფრიზერი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'საყინულე', '["საყინულეები","морозилка","ფრიზერი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'საყინულე');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'საყინულე' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'საყინულეები' AS word UNION ALL SELECT 'морозилка' UNION ALL SELECT 'ფრიზერი' UNION ALL SELECT 'საყინულე') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ჭურჭლის სარეცხი  ←  ჭურჭლის სარეცხები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ჭურჭლის სარეცხი', '["ჭურჭლის სარეცხები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ჭურჭლის სარეცხი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ჭურჭლის სარეცხი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ჭურჭლის სარეცხები' AS word UNION ALL SELECT 'ჭურჭლის სარეცხი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- გაზქურა  ←  გაზქურები, გაზის ქურა, плита, газовая плита
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'გაზქურა', '["გაზქურები","გაზის ქურა","плита","газовая плита"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'გაზქურა');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'გაზქურა' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'გაზქურები' AS word UNION ALL SELECT 'გაზის ქურა' UNION ALL SELECT 'плита' UNION ALL SELECT 'газовая плита' UNION ALL SELECT 'გაზქურა') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- მიკროტალღური  ←  მიკროტალღოვანი, микроволновка
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'მიკროტალღური', '["მიკროტალღოვანი","микроволновка"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მიკროტალღური');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მიკროტალღური' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'მიკროტალღოვანი' AS word UNION ALL SELECT 'микроволновка' UNION ALL SELECT 'მიკროტალღური') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ჩაიდანი  ←  ჩაიდნები, ელჩაიდანი, чайник
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ჩაიდანი', '["ჩაიდნები","ელჩაიდანი","чайник"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ჩაიდანი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ჩაიდანი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ჩაიდნები' AS word UNION ALL SELECT 'ელჩაიდანი' UNION ALL SELECT 'чайник' UNION ALL SELECT 'ჩაიდანი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- აეროგრილი  ←  აეროგრილები, airfryer, ფრიტიურნიცა, аэрогриль, აეროფრაიერი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'აეროგრილი', '["აეროგრილები","airfryer","ფრიტიურნიცა","аэрогриль","აეროფრაიერი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'აეროგრილი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'აეროგრილი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'აეროგრილები' AS word UNION ALL SELECT 'airfryer' UNION ALL SELECT 'ფრიტიურნიცა' UNION ALL SELECT 'аэрогриль' UNION ALL SELECT 'აეროფრაიერი' UNION ALL SELECT 'აეროგრილი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- უთო  ←  უთოები, утюг
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'უთო', '["უთოები","утюг"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'უთო');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'უთო' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'უთოები' AS word UNION ALL SELECT 'утюг' UNION ALL SELECT 'უთო') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ფენი  ←  თმის საშრობი, фен, ფენები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ფენი', '["თმის საშრობი","фен","ფენები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ფენი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ფენი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'თმის საშრობი' AS word UNION ALL SELECT 'фен' UNION ALL SELECT 'ფენები' UNION ALL SELECT 'ფენი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ვენტილატორი  ←  ვენტილატორები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ვენტილატორი', '["ვენტილატორები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ვენტილატორი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ვენტილატორი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ვენტილატორები' AS word UNION ALL SELECT 'ვენტილატორი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- წყლის გამაცხელებელი  ←  ბოილერი, ბოილერები, водонагреватель, бойлер, წყლის გამაცხელებლები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'წყლის გამაცხელებელი', '["ბოილერი","ბოილერები","водонагреватель","бойлер","წყლის გამაცხელებლები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'წყლის გამაცხელებელი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'წყლის გამაცხელებელი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ბოილერი' AS word UNION ALL SELECT 'ბოილერები' UNION ALL SELECT 'водонагреватель' UNION ALL SELECT 'бойлер' UNION ALL SELECT 'წყლის გამაცხელებლები' UNION ALL SELECT 'წყლის გამაცხელებელი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ველოსიპედი  ←  велосипед, ველოსიპედები, bicycle
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ველოსიპედი', '["велосипед","ველოსიპედები","bicycle"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ველოსიპედი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ველოსიპედი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'велосипед' AS word UNION ALL SELECT 'ველოსიპედები' UNION ALL SELECT 'bicycle' UNION ALL SELECT 'ველოსიპედი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- სკუტერი  ←  самокат, სამოკატი, სკუტერები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'სკუტერი', '["самокат","სამოკატი","სკუტერები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'სკუტერი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'სკუტერი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'самокат' AS word UNION ALL SELECT 'სამოკატი' UNION ALL SELECT 'სკუტერები' UNION ALL SELECT 'სკუტერი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ჰოვერბორდი  ←  гироскутер, გიროსკუტერი, ჰოვერბორდები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ჰოვერბორდი', '["гироскутер","გიროსკუტერი","ჰოვერბორდები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ჰოვერბორდი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ჰოვერბორდი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'гироскутер' AS word UNION ALL SELECT 'გიროსკუტერი' UNION ALL SELECT 'ჰოვერბორდები' UNION ALL SELECT 'ჰოვერბორდი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ბატუტი  ←  батут, trampoline, ბატუტები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ბატუტი', '["батут","trampoline","ბატუტები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ბატუტი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ბატუტი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'батут' AS word UNION ALL SELECT 'trampoline' UNION ALL SELECT 'ბატუტები' UNION ALL SELECT 'ბატუტი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- სარბენი ბილიკი  ←  беговая дорожка, სარბენი ბილიკები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'სარბენი ბილიკი', '["беговая дорожка","სარბენი ბილიკები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'სარბენი ბილიკი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'სარბენი ბილიკი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'беговая дорожка' AS word UNION ALL SELECT 'სარბენი ბილიკები' UNION ALL SELECT 'სარბენი ბილიკი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ტრენაჟორი  ←  тренажер, ტრენაჟორები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ტრენაჟორი', '["тренажер","ტრენაჟორები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ტრენაჟორი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ტრენაჟორი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'тренажер' AS word UNION ALL SELECT 'ტრენაჟორები' UNION ALL SELECT 'ტრენაჟორი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- პორტატული დამტენი  ←  პაუერბანკი, powerbank, power bank, повербанк
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'პორტატული დამტენი', '["პაუერბანკი","powerbank","power bank","повербанк"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'პორტატული დამტენი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'პორტატული დამტენი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'პაუერბანკი' AS word UNION ALL SELECT 'powerbank' UNION ALL SELECT 'power bank' UNION ALL SELECT 'повербанк' UNION ALL SELECT 'პორტატული დამტენი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ფოტოაპარატი  ←  ფოტოკამერა, фотоаппарат
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ფოტოაპარატი', '["ფოტოკამერა","фотоаппарат"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ფოტოაპარატი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ფოტოაპარატი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ფოტოკამერა' AS word UNION ALL SELECT 'фотоаппарат' UNION ALL SELECT 'ფოტოაპარატი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- დრონი  ←  квадрокоптер, კვადროკოპტერი, drone
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'დრონი', '["квадрокоптер","კვადროკოპტერი","drone"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'დრონი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'დრონი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'квадрокоптер' AS word UNION ALL SELECT 'კვადროკოპტერი' UNION ALL SELECT 'drone' UNION ALL SELECT 'დრონი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- პრინტერი  ←  принтер, პრინტერები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'პრინტერი', '["принтер","პრინტერები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'პრინტერი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'პრინტერი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'принтер' AS word UNION ALL SELECT 'პრინტერები' UNION ALL SELECT 'პრინტერი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- მონიტორი  ←  მონიტორები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'მონიტორი', '["მონიტორები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მონიტორი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მონიტორი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'მონიტორები' AS word UNION ALL SELECT 'მონიტორი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- როუტერი  ←  роутер, რაუტერი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'როუტერი', '["роутер","რაუტერი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'როუტერი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'როუტერი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'роутер' AS word UNION ALL SELECT 'რაუტერი' UNION ALL SELECT 'როუტერი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- მობილური ტელეფონი  ←  სმარტფონები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'მობილური ტელეფონი', '["სმარტფონები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მობილური ტელეფონი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მობილური ტელეფონი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'სმარტფონები' AS word UNION ALL SELECT 'მობილური ტელეფონი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ბლენდერი  ←  блендер, ბლენდერები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ბლენდერი', '["блендер","ბლენდერები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ბლენდერი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ბლენდერი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'блендер' AS word UNION ALL SELECT 'ბლენდერები' UNION ALL SELECT 'ბლენდერი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- მიქსერი  ←  миксер, მიქსერები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'მიქსერი', '["миксер","მიქსერები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მიქსერი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'მიქსერი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'миксер' AS word UNION ALL SELECT 'მიქსერები' UNION ALL SELECT 'მიქსერი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ტოსტერი  ←  тостер
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ტოსტერი', '["тостер"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ტოსტერი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ტოსტერი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'тостер' AS word UNION ALL SELECT 'ტოსტერი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- წვენსაწური  ←  соковыжималка, juicer, წვენის საწური
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'წვენსაწური', '["соковыжималка","juicer","წვენის საწური"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'წვენსაწური');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'წვენსაწური' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'соковыжималка' AS word UNION ALL SELECT 'juicer' UNION ALL SELECT 'წვენის საწური' UNION ALL SELECT 'წვენსაწური') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ხორცსაკეპი  ←  мясорубка, ხორცის საკეპი, ხორცის მანქანა
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ხორცსაკეპი', '["мясорубка","ხორცის საკეპი","ხორცის მანქანა"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ხორცსაკეპი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ხორცსაკეპი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'мясорубка' AS word UNION ALL SELECT 'ხორცის საკეპი' UNION ALL SELECT 'ხორცის მანქანა' UNION ALL SELECT 'ხორცსაკეპი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ჰაერის გამწმენდი  ←  очиститель воздуха, air purifier
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ჰაერის გამწმენდი', '["очиститель воздуха","air purifier"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ჰაერის გამწმენდი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ჰაერის გამწმენდი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'очиститель воздуха' AS word UNION ALL SELECT 'air purifier' UNION ALL SELECT 'ჰაერის გამწმენდი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ღუმელი  ←  ღუმელები
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ღუმელი', '["ღუმელები"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ღუმელი');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ღუმელი' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ღუმელები' AS word UNION ALL SELECT 'ღუმელი') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- toshiba  ←  ტოშიბა
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'toshiba', '["ტოშიბა"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'toshiba');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'toshiba' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ტოშიბა' AS word UNION ALL SELECT 'toshiba') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- electrolux  ←  ელექტროლუქსი, ელექტროლუქს
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'electrolux', '["ელექტროლუქსი","ელექტროლუქს"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'electrolux');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'electrolux' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ელექტროლუქსი' AS word UNION ALL SELECT 'ელექტროლუქს' UNION ALL SELECT 'electrolux') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- philips  ←  ფილიპსი, ფილიპს
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'philips', '["ფილიპსი","ფილიპს"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'philips');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'philips' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ფილიპსი' AS word UNION ALL SELECT 'ფილიპს' UNION ALL SELECT 'philips') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- dyson  ←  დაისონი, დაისონ
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'dyson', '["დაისონი","დაისონ"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'dyson');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'dyson' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'დაისონი' AS word UNION ALL SELECT 'დაისონ' UNION ALL SELECT 'dyson') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- smeg  ←  სმეგი, სმეგ
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'smeg', '["სმეგი","სმეგ"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'smeg');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'smeg' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'სმეგი' AS word UNION ALL SELECT 'სმეგ' UNION ALL SELECT 'smeg') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- tcl  ←  ტისიელი, ტისიელ
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'tcl', '["ტისიელი","ტისიელ"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'tcl');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'tcl' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ტისიელი' AS word UNION ALL SELECT 'ტისიელ' UNION ALL SELECT 'tcl') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- haier  ←  ჰაიერი, ჰაიერ
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'haier', '["ჰაიერი","ჰაიერ"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'haier');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'haier' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ჰაიერი' AS word UNION ALL SELECT 'ჰაიერ' UNION ALL SELECT 'haier') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- midea  ←  მიდია, midia
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'midea', '["მიდია","midia"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'midea');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'midea' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'მიდია' AS word UNION ALL SELECT 'midia' UNION ALL SELECT 'midea') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- lenovo  ←  ლენოვო
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'lenovo', '["ლენოვო"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'lenovo');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'lenovo' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ლენოვო' AS word UNION ALL SELECT 'lenovo') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- asus  ←  ასუსი, ასუს
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'asus', '["ასუსი","ასუს"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'asus');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'asus' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ასუსი' AS word UNION ALL SELECT 'ასუს' UNION ALL SELECT 'asus') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- acer  ←  ეისერი, აცერი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'acer', '["ეისერი","აცერი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'acer');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'acer' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ეისერი' AS word UNION ALL SELECT 'აცერი' UNION ALL SELECT 'acer') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- apple  ←  ეპლი, ეფლი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'apple', '["ეპლი","ეფლი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'apple');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'apple' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ეპლი' AS word UNION ALL SELECT 'ეფლი' UNION ALL SELECT 'apple') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- nokia  ←  ნოკია
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'nokia', '["ნოკია"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'nokia');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'nokia' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ნოკია' AS word UNION ALL SELECT 'nokia') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- motorola  ←  მოტოროლა
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'motorola', '["მოტოროლა"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'motorola');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'motorola' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'მოტოროლა' AS word UNION ALL SELECT 'motorola') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- realme  ←  რეალმი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'realme', '["რეალმი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'realme');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'realme' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'რეალმი' AS word UNION ALL SELECT 'realme') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- oukitel  ←  ოუკიტელი, ოკიტელი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'oukitel', '["ოუკიტელი","ოკიტელი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'oukitel');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'oukitel' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ოუკიტელი' AS word UNION ALL SELECT 'ოკიტელი' UNION ALL SELECT 'oukitel') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- poco  ←  პოკო
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'poco', '["პოკო"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'poco');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'poco' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'პოკო' AS word UNION ALL SELECT 'poco') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- redmi  ←  რედმი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'redmi', '["რედმი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'redmi');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'redmi' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'რედმი' AS word UNION ALL SELECT 'redmi') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- hisense  ←  ჰაისენსი, ჰისენსი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'hisense', '["ჰაისენსი","ჰისენსი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'hisense');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'hisense' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ჰაისენსი' AS word UNION ALL SELECT 'ჰისენსი' UNION ALL SELECT 'hisense') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- panasonic  ←  პანასონიკი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'panasonic', '["პანასონიკი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'panasonic');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'panasonic' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'პანასონიკი' AS word UNION ALL SELECT 'panasonic') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- epson  ←  ეფსონი, ეპსონი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'epson', '["ეფსონი","ეპსონი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'epson');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'epson' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ეფსონი' AS word UNION ALL SELECT 'ეპსონი' UNION ALL SELECT 'epson') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- braun  ←  ბრაუნი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'braun', '["ბრაუნი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'braun');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'braun' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ბრაუნი' AS word UNION ALL SELECT 'braun') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- delonghi  ←  დელონგი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'delonghi', '["დელონგი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'delonghi');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'delonghi' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'დელონგი' AS word UNION ALL SELECT 'delonghi') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- kenwood  ←  კენვუდი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'kenwood', '["კენვუდი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'kenwood');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'kenwood' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'კენვუდი' AS word UNION ALL SELECT 'kenwood') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- hyundai  ←  ჰიუნდაი, ჰუნდაი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'hyundai', '["ჰიუნდაი","ჰუნდაი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'hyundai');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'hyundai' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ჰიუნდაი' AS word UNION ALL SELECT 'ჰუნდაი' UNION ALL SELECT 'hyundai') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- indesit  ←  ინდეზიტი, ინდესიტი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'indesit', '["ინდეზიტი","ინდესიტი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'indesit');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'indesit' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ინდეზიტი' AS word UNION ALL SELECT 'ინდესიტი' UNION ALL SELECT 'indesit') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ersel  ←  ერსელი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ersel', '["ერსელი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ersel');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ersel' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'ერსელი' AS word UNION ALL SELECT 'ersel') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- ardesto  ←  არდესტო
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'ardesto', '["არდესტო"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ardesto');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'ardesto' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'არდესტო' AS word UNION ALL SELECT 'ardesto') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- sencor  ←  სენკორი
INSERT INTO cscart_csc_live_search_synonyms (company_id, phrase, synonyms, `timestamp`, user_id, lang_code, status) SELECT 1, 'sencor', '["სენკორი"]', UNIX_TIMESTAMP(), 0, 'ka', 'A' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'sencor');
SET @sid := (SELECT synonym_id FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase = 'sencor' ORDER BY synonym_id LIMIT 1);
INSERT INTO cscart_csc_live_search_synonym_words (synonym_id, company_id, lang_code, word, is_variant) SELECT @sid, 1, 'ka', w.word, 0 FROM (SELECT 'სენკორი' AS word UNION ALL SELECT 'sencor') w WHERE @sid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM cscart_csc_live_search_synonym_words x WHERE x.synonym_id = @sid AND x.word = w.word);

-- შემოწმება: ყველა ხაზში is_json = 1
SELECT COUNT(*) AS synonyms_total, SUM(JSON_VALID(synonyms)) AS json_ok FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka';
SELECT synonym_id, phrase, synonyms, JSON_VALID(synonyms) AS is_json FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase IN ('ნოუთბუქი', 'ტაბლეტი', 'ipad', 'ყურსასმენი', 'სმარტ საათი', 'საყინულე', 'ჭურჭლის სარეცხი', 'გაზქურა', 'მიკროტალღური', 'ჩაიდანი', 'აეროგრილი', 'უთო', 'ფენი', 'ვენტილატორი', 'წყლის გამაცხელებელი', 'ველოსიპედი', 'სკუტერი', 'ჰოვერბორდი', 'ბატუტი', 'სარბენი ბილიკი', 'ტრენაჟორი', 'პორტატული დამტენი', 'ფოტოაპარატი', 'დრონი', 'პრინტერი', 'მონიტორი', 'როუტერი', 'მობილური ტელეფონი', 'ბლენდერი', 'მიქსერი', 'ტოსტერი', 'წვენსაწური', 'ხორცსაკეპი', 'ჰაერის გამწმენდი', 'ღუმელი', 'toshiba', 'electrolux', 'philips', 'dyson', 'smeg', 'tcl', 'haier', 'midea', 'lenovo', 'asus', 'acer', 'apple', 'nokia', 'motorola', 'realme', 'oukitel', 'poco', 'redmi', 'hisense', 'panasonic', 'epson', 'braun', 'delonghi', 'kenwood', 'hyundai', 'indesit', 'ersel', 'ardesto', 'sencor') ORDER BY synonym_id;

-- ============================================================================
-- დაბრუნება (მხოლოდ საჭიროების შემთხვევაში; კომენტარია, არ სრულდება):
-- DELETE w FROM cscart_csc_live_search_synonym_words w JOIN cscart_csc_live_search_synonyms s ON s.synonym_id = w.synonym_id WHERE s.company_id = 1 AND s.lang_code = 'ka' AND s.phrase IN ('ნოუთბუქი', 'ტაბლეტი', 'ipad', 'ყურსასმენი', 'სმარტ საათი', 'საყინულე', 'ჭურჭლის სარეცხი', 'გაზქურა', 'მიკროტალღური', 'ჩაიდანი', 'აეროგრილი', 'უთო', 'ფენი', 'ვენტილატორი', 'წყლის გამაცხელებელი', 'ველოსიპედი', 'სკუტერი', 'ჰოვერბორდი', 'ბატუტი', 'სარბენი ბილიკი', 'ტრენაჟორი', 'პორტატული დამტენი', 'ფოტოაპარატი', 'დრონი', 'პრინტერი', 'მონიტორი', 'როუტერი', 'მობილური ტელეფონი', 'ბლენდერი', 'მიქსერი', 'ტოსტერი', 'წვენსაწური', 'ხორცსაკეპი', 'ჰაერის გამწმენდი', 'ღუმელი', 'toshiba', 'electrolux', 'philips', 'dyson', 'smeg', 'tcl', 'haier', 'midea', 'lenovo', 'asus', 'acer', 'apple', 'nokia', 'motorola', 'realme', 'oukitel', 'poco', 'redmi', 'hisense', 'panasonic', 'epson', 'braun', 'delonghi', 'kenwood', 'hyundai', 'indesit', 'ersel', 'ardesto', 'sencor');
-- DELETE FROM cscart_csc_live_search_synonyms WHERE company_id = 1 AND lang_code = 'ka' AND phrase IN ('ნოუთბუქი', 'ტაბლეტი', 'ipad', 'ყურსასმენი', 'სმარტ საათი', 'საყინულე', 'ჭურჭლის სარეცხი', 'გაზქურა', 'მიკროტალღური', 'ჩაიდანი', 'აეროგრილი', 'უთო', 'ფენი', 'ვენტილატორი', 'წყლის გამაცხელებელი', 'ველოსიპედი', 'სკუტერი', 'ჰოვერბორდი', 'ბატუტი', 'სარბენი ბილიკი', 'ტრენაჟორი', 'პორტატული დამტენი', 'ფოტოაპარატი', 'დრონი', 'პრინტერი', 'მონიტორი', 'როუტერი', 'მობილური ტელეფონი', 'ბლენდერი', 'მიქსერი', 'ტოსტერი', 'წვენსაწური', 'ხორცსაკეპი', 'ჰაერის გამწმენდი', 'ღუმელი', 'toshiba', 'electrolux', 'philips', 'dyson', 'smeg', 'tcl', 'haier', 'midea', 'lenovo', 'asus', 'acer', 'apple', 'nokia', 'motorola', 'realme', 'oukitel', 'poco', 'redmi', 'hisense', 'panasonic', 'epson', 'braun', 'delonghi', 'kenwood', 'hyundai', 'indesit', 'ersel', 'ardesto', 'sencor');
-- ============================================================================
