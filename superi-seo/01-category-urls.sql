-- superi.ge — კატეგორიების SEO მისამართების ერთიანი შეცვლა (62 კატეგორია)
-- ძველი მისამართი (category-NN) 301-ით გადავა ახალზე.

-- 0) არსებული გადამისამართებების ფორმატის დადგენა
SET @f := (SELECT src FROM cscart_seo_redirects WHERE TRIM(BOTH '/' FROM src) = 'klimaturi-teqnika' LIMIT 1);
SET @pre := IF(@f IS NULL OR LEFT(@f,1) = '/', '/', '');
SET @post := IF(@f IS NULL OR RIGHT(@f,1) = '/', '/', '');

-- 1) ძველი მისამართი -> კატეგორია (301)
INSERT IGNORE INTO cscart_seo_redirects (src, type, object_id, lang_code, company_id) VALUES
(CONCAT(@pre,'notebook-ka',@post),'c',33,'ka',1),
(CONCAT(@pre,'and',@post),'c',76,'ka',1),
(CONCAT(@pre,'category-7',@post),'c',7,'ka',1),
(CONCAT(@pre,'category-8',@post),'c',8,'ka',1),
(CONCAT(@pre,'category-11',@post),'c',11,'ka',1),
(CONCAT(@pre,'category-12',@post),'c',12,'ka',1),
(CONCAT(@pre,'category-14',@post),'c',14,'ka',1),
(CONCAT(@pre,'category-15',@post),'c',15,'ka',1),
(CONCAT(@pre,'category-16',@post),'c',16,'ka',1),
(CONCAT(@pre,'category-17',@post),'c',17,'ka',1),
(CONCAT(@pre,'category-21',@post),'c',21,'ka',1),
(CONCAT(@pre,'category-24',@post),'c',24,'ka',1),
(CONCAT(@pre,'category-26',@post),'c',26,'ka',1),
(CONCAT(@pre,'category-29',@post),'c',29,'ka',1),
(CONCAT(@pre,'category-31',@post),'c',31,'ka',1),
(CONCAT(@pre,'category-32',@post),'c',32,'ka',1),
(CONCAT(@pre,'category-34',@post),'c',34,'ka',1),
(CONCAT(@pre,'category-37',@post),'c',37,'ka',1),
(CONCAT(@pre,'category-38',@post),'c',38,'ka',1),
(CONCAT(@pre,'category-40',@post),'c',40,'ka',1),
(CONCAT(@pre,'category-41',@post),'c',41,'ka',1),
(CONCAT(@pre,'category-43',@post),'c',43,'ka',1),
(CONCAT(@pre,'category-47',@post),'c',47,'ka',1),
(CONCAT(@pre,'category-48',@post),'c',48,'ka',1),
(CONCAT(@pre,'category-53',@post),'c',53,'ka',1),
(CONCAT(@pre,'category-56',@post),'c',56,'ka',1),
(CONCAT(@pre,'category-57',@post),'c',57,'ka',1),
(CONCAT(@pre,'category-60',@post),'c',60,'ka',1),
(CONCAT(@pre,'category-62',@post),'c',62,'ka',1),
(CONCAT(@pre,'category-65',@post),'c',65,'ka',1),
(CONCAT(@pre,'category-67',@post),'c',67,'ka',1),
(CONCAT(@pre,'category-68',@post),'c',68,'ka',1),
(CONCAT(@pre,'category-69',@post),'c',69,'ka',1),
(CONCAT(@pre,'category-71',@post),'c',71,'ka',1),
(CONCAT(@pre,'category-72',@post),'c',72,'ka',1),
(CONCAT(@pre,'category-74',@post),'c',74,'ka',1),
(CONCAT(@pre,'category-75',@post),'c',75,'ka',1),
(CONCAT(@pre,'category-80',@post),'c',80,'ka',1),
(CONCAT(@pre,'category-81',@post),'c',81,'ka',1),
(CONCAT(@pre,'category-82',@post),'c',82,'ka',1),
(CONCAT(@pre,'category-83',@post),'c',83,'ka',1),
(CONCAT(@pre,'category-85',@post),'c',85,'ka',1),
(CONCAT(@pre,'category-86',@post),'c',86,'ka',1),
(CONCAT(@pre,'category-87',@post),'c',87,'ka',1),
(CONCAT(@pre,'category-90',@post),'c',90,'ka',1),
(CONCAT(@pre,'category-92',@post),'c',92,'ka',1),
(CONCAT(@pre,'category-93',@post),'c',93,'ka',1),
(CONCAT(@pre,'category-96',@post),'c',96,'ka',1),
(CONCAT(@pre,'category-97',@post),'c',97,'ka',1),
(CONCAT(@pre,'category-98',@post),'c',98,'ka',1),
(CONCAT(@pre,'category-101',@post),'c',101,'ka',1),
(CONCAT(@pre,'category-103',@post),'c',103,'ka',1),
(CONCAT(@pre,'category-105',@post),'c',105,'ka',1),
(CONCAT(@pre,'category-107',@post),'c',107,'ka',1),
(CONCAT(@pre,'category-109',@post),'c',109,'ka',1),
(CONCAT(@pre,'category-110',@post),'c',110,'ka',1),
(CONCAT(@pre,'category-112',@post),'c',112,'ka',1),
(CONCAT(@pre,'category-113',@post),'c',113,'ka',1),
(CONCAT(@pre,'category-115',@post),'c',115,'ka',1),
(CONCAT(@pre,'category-150',@post),'c',150,'ka',1),
(CONCAT(@pre,'category-153',@post),'c',153,'ka',1),
(CONCAT(@pre,'category-166',@post),'c',166,'ka',1);

-- 2) ძველი, საპირისპირო გადამისამართებების წაშლა (ახალი სახელი -> category-NN), რომ ციკლი არ შეიქმნას
DELETE FROM cscart_seo_redirects WHERE company_id = 1 AND TRIM(BOTH '/' FROM src) IN (
'noutbuqebi',
'hamakebi-da-saqanelebi',
'sabavshvo-produqtsia',
'sakhli-da-dekori',
'samsheneblo-khelsatskoebi',
'tskhovelta-samkaro',
'velosipedebi',
'klimaturi-teqnika',
'baghi-da-ezo',
'avtosamkaro',
'saburavebi',
'sakopatskhovrebo-teqnika',
'noutbuqebi-kompiuterebi-monitorebi',
'kursasmenebi',
'eleqtro-gamatboblebi',
'saretskhi-manqanebi',
'fotoaparatebi',
'akumulatorebi',
'mobiluri-aqsesuarebi',
'tskhovelta-da-prinvelta-kveba',
'statsionaluri-teleponebi',
'televizoris-aqsesuarebi',
'tsvrili-sakopatskhovrebo-teqnika',
'mtversasrutebi',
'quris-zedapiri',
'sakeravi-teqnika',
'saopise-da-qseluri-motskobilobebi',
'samzareulos-danebi',
'hoverbordebi',
'qvabebisa-da-tapebis-nakrebebi',
'portatuli-damtenebi',
'mikrotalghuri-ghumelebi',
'miqserebi',
'chasashenebeli-ghumelebi',
'chasashenebeli-saretskhi-manqanebi',
'eleqtro-manqanebi',
'batutebi',
'kompresorebi',
'gamtsovi',
'satibebi',
'proeqtorebi-da-aqsesuarebi',
'tsvensatsurebi',
'blenderebi',
'kartrijebi-saghebavebi-qaghaldi',
'trenazhorebi',
'gasaberi-aveji',
'kompiuteris-aqsesuarebi',
'mogzauroba',
'khelis-instrumentebi',
'saretskh-satsmendi-sashualebebi',
'proeqtori',
'droni',
'tsnevit-saretskhi-aparatebi',
'tsentraluri-gatbobis-qvabi',
'tsklis-gamatskheleblebi',
'tosteri',
'haeris-gamtsmendi-da-damatenianeblebi',
'magida-da-skamebi',
'tmis-uto-staileri',
'kutkhsakhekhi',
'kompiuteris-natsilebi',
'protsesorebi');

-- 3) ახალი SEO სახელები
UPDATE cscart_seo_names SET name = 'noutbuqebi' WHERE type = 'c' AND object_id = 33 AND name = 'notebook-ka' AND company_id = 1 AND lang_code = 'ka'; -- ნოუთბუქები
UPDATE cscart_seo_names SET name = 'hamakebi-da-saqanelebi' WHERE type = 'c' AND object_id = 76 AND name = 'and' AND company_id = 1 AND lang_code = 'ka'; -- ჰამაკები & საქანელები
UPDATE cscart_seo_names SET name = 'sabavshvo-produqtsia' WHERE type = 'c' AND object_id = 7 AND name = 'category-7' AND company_id = 1 AND lang_code = 'ka'; -- საბავშვო პროდუქცია
UPDATE cscart_seo_names SET name = 'sakhli-da-dekori' WHERE type = 'c' AND object_id = 8 AND name = 'category-8' AND company_id = 1 AND lang_code = 'ka'; -- სახლი და დეკორი
UPDATE cscart_seo_names SET name = 'samsheneblo-khelsatskoebi' WHERE type = 'c' AND object_id = 11 AND name = 'category-11' AND company_id = 1 AND lang_code = 'ka'; -- სამშენებლო ხელსაწყოები
UPDATE cscart_seo_names SET name = 'tskhovelta-samkaro' WHERE type = 'c' AND object_id = 12 AND name = 'category-12' AND company_id = 1 AND lang_code = 'ka'; -- ცხოველთა სამყარო
UPDATE cscart_seo_names SET name = 'velosipedebi' WHERE type = 'c' AND object_id = 14 AND name = 'category-14' AND company_id = 1 AND lang_code = 'ka'; -- ველოსიპედები
UPDATE cscart_seo_names SET name = 'klimaturi-teqnika' WHERE type = 'c' AND object_id = 15 AND name = 'category-15' AND company_id = 1 AND lang_code = 'ka'; -- კლიმატური ტექნიკა
UPDATE cscart_seo_names SET name = 'baghi-da-ezo' WHERE type = 'c' AND object_id = 16 AND name = 'category-16' AND company_id = 1 AND lang_code = 'ka'; -- ბაღი და ეზო
UPDATE cscart_seo_names SET name = 'avtosamkaro' WHERE type = 'c' AND object_id = 17 AND name = 'category-17' AND company_id = 1 AND lang_code = 'ka'; -- ავტოსამყარო
UPDATE cscart_seo_names SET name = 'saburavebi' WHERE type = 'c' AND object_id = 21 AND name = 'category-21' AND company_id = 1 AND lang_code = 'ka'; -- საბურავები
UPDATE cscart_seo_names SET name = 'sakopatskhovrebo-teqnika' WHERE type = 'c' AND object_id = 24 AND name = 'category-24' AND company_id = 1 AND lang_code = 'ka'; -- საყოფაცხოვრებო ტექნიკა
UPDATE cscart_seo_names SET name = 'noutbuqebi-kompiuterebi-monitorebi' WHERE type = 'c' AND object_id = 26 AND name = 'category-26' AND company_id = 1 AND lang_code = 'ka'; -- ნოუთბუქები, კომპიუტერები, მონიტორები
UPDATE cscart_seo_names SET name = 'kursasmenebi' WHERE type = 'c' AND object_id = 29 AND name = 'category-29' AND company_id = 1 AND lang_code = 'ka'; -- ყურსასმენები
UPDATE cscart_seo_names SET name = 'eleqtro-gamatboblebi' WHERE type = 'c' AND object_id = 31 AND name = 'category-31' AND company_id = 1 AND lang_code = 'ka'; -- ელექტრო გამათბობლები
UPDATE cscart_seo_names SET name = 'saretskhi-manqanebi' WHERE type = 'c' AND object_id = 32 AND name = 'category-32' AND company_id = 1 AND lang_code = 'ka'; -- სარეცხი მანქანები
UPDATE cscart_seo_names SET name = 'fotoaparatebi' WHERE type = 'c' AND object_id = 34 AND name = 'category-34' AND company_id = 1 AND lang_code = 'ka'; -- ფოტოაპარატები
UPDATE cscart_seo_names SET name = 'akumulatorebi' WHERE type = 'c' AND object_id = 37 AND name = 'category-37' AND company_id = 1 AND lang_code = 'ka'; -- აკუმულატორები
UPDATE cscart_seo_names SET name = 'mobiluri-aqsesuarebi' WHERE type = 'c' AND object_id = 38 AND name = 'category-38' AND company_id = 1 AND lang_code = 'ka'; -- მობილური აქსესუარები
UPDATE cscart_seo_names SET name = 'tskhovelta-da-prinvelta-kveba' WHERE type = 'c' AND object_id = 40 AND name = 'category-40' AND company_id = 1 AND lang_code = 'ka'; -- ცხოველთა და ფრინველთა კვება
UPDATE cscart_seo_names SET name = 'statsionaluri-teleponebi' WHERE type = 'c' AND object_id = 41 AND name = 'category-41' AND company_id = 1 AND lang_code = 'ka'; -- სტაციონალური ტელეფონები
UPDATE cscart_seo_names SET name = 'televizoris-aqsesuarebi' WHERE type = 'c' AND object_id = 43 AND name = 'category-43' AND company_id = 1 AND lang_code = 'ka'; -- ტელევიზორის აქსესუარები
UPDATE cscart_seo_names SET name = 'tsvrili-sakopatskhovrebo-teqnika' WHERE type = 'c' AND object_id = 47 AND name = 'category-47' AND company_id = 1 AND lang_code = 'ka'; -- წვრილი საყოფაცხოვრებო ტექნიკა
UPDATE cscart_seo_names SET name = 'mtversasrutebi' WHERE type = 'c' AND object_id = 48 AND name = 'category-48' AND company_id = 1 AND lang_code = 'ka'; -- მტვერსასრუტები
UPDATE cscart_seo_names SET name = 'quris-zedapiri' WHERE type = 'c' AND object_id = 53 AND name = 'category-53' AND company_id = 1 AND lang_code = 'ka'; -- ქურის ზედაპირი
UPDATE cscart_seo_names SET name = 'sakeravi-teqnika' WHERE type = 'c' AND object_id = 56 AND name = 'category-56' AND company_id = 1 AND lang_code = 'ka'; -- საკერავი ტექნიკა
UPDATE cscart_seo_names SET name = 'saopise-da-qseluri-motskobilobebi' WHERE type = 'c' AND object_id = 57 AND name = 'category-57' AND company_id = 1 AND lang_code = 'ka'; -- საოფისე და ქსელური მოწყობილობები
UPDATE cscart_seo_names SET name = 'samzareulos-danebi' WHERE type = 'c' AND object_id = 60 AND name = 'category-60' AND company_id = 1 AND lang_code = 'ka'; -- სამზარეულოს დანები
UPDATE cscart_seo_names SET name = 'hoverbordebi' WHERE type = 'c' AND object_id = 62 AND name = 'category-62' AND company_id = 1 AND lang_code = 'ka'; -- ჰოვერბორდები
UPDATE cscart_seo_names SET name = 'qvabebisa-da-tapebis-nakrebebi' WHERE type = 'c' AND object_id = 65 AND name = 'category-65' AND company_id = 1 AND lang_code = 'ka'; -- ქვაბებისა და ტაფების ნაკრებები
UPDATE cscart_seo_names SET name = 'portatuli-damtenebi' WHERE type = 'c' AND object_id = 67 AND name = 'category-67' AND company_id = 1 AND lang_code = 'ka'; -- პორტატული დამტენები
UPDATE cscart_seo_names SET name = 'mikrotalghuri-ghumelebi' WHERE type = 'c' AND object_id = 68 AND name = 'category-68' AND company_id = 1 AND lang_code = 'ka'; -- მიკროტალღური ღუმელები
UPDATE cscart_seo_names SET name = 'miqserebi' WHERE type = 'c' AND object_id = 69 AND name = 'category-69' AND company_id = 1 AND lang_code = 'ka'; -- მიქსერები
UPDATE cscart_seo_names SET name = 'chasashenebeli-ghumelebi' WHERE type = 'c' AND object_id = 71 AND name = 'category-71' AND company_id = 1 AND lang_code = 'ka'; -- ჩასაშენებელი ღუმელები
UPDATE cscart_seo_names SET name = 'chasashenebeli-saretskhi-manqanebi' WHERE type = 'c' AND object_id = 72 AND name = 'category-72' AND company_id = 1 AND lang_code = 'ka'; -- ჩასაშენებელი სარეცხი მანქანები
UPDATE cscart_seo_names SET name = 'eleqtro-manqanebi' WHERE type = 'c' AND object_id = 74 AND name = 'category-74' AND company_id = 1 AND lang_code = 'ka'; -- ელექტრო მანქანები
UPDATE cscart_seo_names SET name = 'batutebi' WHERE type = 'c' AND object_id = 75 AND name = 'category-75' AND company_id = 1 AND lang_code = 'ka'; -- ბატუტები
UPDATE cscart_seo_names SET name = 'kompresorebi' WHERE type = 'c' AND object_id = 80 AND name = 'category-80' AND company_id = 1 AND lang_code = 'ka'; -- კომპრესორები
UPDATE cscart_seo_names SET name = 'gamtsovi' WHERE type = 'c' AND object_id = 81 AND name = 'category-81' AND company_id = 1 AND lang_code = 'ka'; -- გამწოვი
UPDATE cscart_seo_names SET name = 'satibebi' WHERE type = 'c' AND object_id = 82 AND name = 'category-82' AND company_id = 1 AND lang_code = 'ka'; -- სათიბები
UPDATE cscart_seo_names SET name = 'proeqtorebi-da-aqsesuarebi' WHERE type = 'c' AND object_id = 83 AND name = 'category-83' AND company_id = 1 AND lang_code = 'ka'; -- პროექტორები და აქსესუარები
UPDATE cscart_seo_names SET name = 'tsvensatsurebi' WHERE type = 'c' AND object_id = 85 AND name = 'category-85' AND company_id = 1 AND lang_code = 'ka'; -- წვენსაწურები
UPDATE cscart_seo_names SET name = 'blenderebi' WHERE type = 'c' AND object_id = 86 AND name = 'category-86' AND company_id = 1 AND lang_code = 'ka'; -- ბლენდერები
UPDATE cscart_seo_names SET name = 'kartrijebi-saghebavebi-qaghaldi' WHERE type = 'c' AND object_id = 87 AND name = 'category-87' AND company_id = 1 AND lang_code = 'ka'; -- კარტრიჯები, საღებავები, ქაღალდი
UPDATE cscart_seo_names SET name = 'trenazhorebi' WHERE type = 'c' AND object_id = 90 AND name = 'category-90' AND company_id = 1 AND lang_code = 'ka'; -- ტრენაჟორები
UPDATE cscart_seo_names SET name = 'gasaberi-aveji' WHERE type = 'c' AND object_id = 92 AND name = 'category-92' AND company_id = 1 AND lang_code = 'ka'; -- გასაბერი ავეჯი
UPDATE cscart_seo_names SET name = 'kompiuteris-aqsesuarebi' WHERE type = 'c' AND object_id = 93 AND name = 'category-93' AND company_id = 1 AND lang_code = 'ka'; -- კომპიუტერის აქსესუარები
UPDATE cscart_seo_names SET name = 'mogzauroba' WHERE type = 'c' AND object_id = 96 AND name = 'category-96' AND company_id = 1 AND lang_code = 'ka'; -- მოგზაურობა
UPDATE cscart_seo_names SET name = 'khelis-instrumentebi' WHERE type = 'c' AND object_id = 97 AND name = 'category-97' AND company_id = 1 AND lang_code = 'ka'; -- ხელის ინსტრუმენტები
UPDATE cscart_seo_names SET name = 'saretskh-satsmendi-sashualebebi' WHERE type = 'c' AND object_id = 98 AND name = 'category-98' AND company_id = 1 AND lang_code = 'ka'; -- სარეცხ-საწმენდი საშუალებები
UPDATE cscart_seo_names SET name = 'proeqtori' WHERE type = 'c' AND object_id = 101 AND name = 'category-101' AND company_id = 1 AND lang_code = 'ka'; -- პროექტორი
UPDATE cscart_seo_names SET name = 'droni' WHERE type = 'c' AND object_id = 103 AND name = 'category-103' AND company_id = 1 AND lang_code = 'ka'; -- დრონი
UPDATE cscart_seo_names SET name = 'tsnevit-saretskhi-aparatebi' WHERE type = 'c' AND object_id = 105 AND name = 'category-105' AND company_id = 1 AND lang_code = 'ka'; -- წნევით სარეცხი აპარატები
UPDATE cscart_seo_names SET name = 'tsentraluri-gatbobis-qvabi' WHERE type = 'c' AND object_id = 107 AND name = 'category-107' AND company_id = 1 AND lang_code = 'ka'; -- ცენტრალური გათბობის ქვაბი
UPDATE cscart_seo_names SET name = 'tsklis-gamatskheleblebi' WHERE type = 'c' AND object_id = 109 AND name = 'category-109' AND company_id = 1 AND lang_code = 'ka'; -- წყლის გამაცხელებლები
UPDATE cscart_seo_names SET name = 'tosteri' WHERE type = 'c' AND object_id = 110 AND name = 'category-110' AND company_id = 1 AND lang_code = 'ka'; -- ტოსტერი
UPDATE cscart_seo_names SET name = 'haeris-gamtsmendi-da-damatenianeblebi' WHERE type = 'c' AND object_id = 112 AND name = 'category-112' AND company_id = 1 AND lang_code = 'ka'; -- ჰაერის გამწმენდი და დამატენიანებლები
UPDATE cscart_seo_names SET name = 'magida-da-skamebi' WHERE type = 'c' AND object_id = 113 AND name = 'category-113' AND company_id = 1 AND lang_code = 'ka'; -- მაგიდა და სკამები
UPDATE cscart_seo_names SET name = 'tmis-uto-staileri' WHERE type = 'c' AND object_id = 115 AND name = 'category-115' AND company_id = 1 AND lang_code = 'ka'; -- თმის უთო/სტაილერი
UPDATE cscart_seo_names SET name = 'kutkhsakhekhi' WHERE type = 'c' AND object_id = 150 AND name = 'category-150' AND company_id = 1 AND lang_code = 'ka'; -- კუთხსახეხი
UPDATE cscart_seo_names SET name = 'kompiuteris-natsilebi' WHERE type = 'c' AND object_id = 153 AND name = 'category-153' AND company_id = 1 AND lang_code = 'ka'; -- კომპიუტერის ნაწილები
UPDATE cscart_seo_names SET name = 'protsesorebi' WHERE type = 'c' AND object_id = 166 AND name = 'category-166' AND company_id = 1 AND lang_code = 'ka'; -- პროცესორები

-- 4) შემოწმება: შედეგი ცარიელი უნდა იყოს (არც ერთი სახელი არ მეორდება)
SELECT name, COUNT(*) AS c FROM cscart_seo_names WHERE company_id = 1 AND lang_code = 'ka' AND name IN ('noutbuqebi','hamakebi-da-saqanelebi','sabavshvo-produqtsia','sakhli-da-dekori','samsheneblo-khelsatskoebi','tskhovelta-samkaro','velosipedebi','klimaturi-teqnika','baghi-da-ezo','avtosamkaro','saburavebi','sakopatskhovrebo-teqnika','noutbuqebi-kompiuterebi-monitorebi','kursasmenebi','eleqtro-gamatboblebi','saretskhi-manqanebi','fotoaparatebi','akumulatorebi','mobiluri-aqsesuarebi','tskhovelta-da-prinvelta-kveba','statsionaluri-teleponebi','televizoris-aqsesuarebi','tsvrili-sakopatskhovrebo-teqnika','mtversasrutebi','quris-zedapiri','sakeravi-teqnika','saopise-da-qseluri-motskobilobebi','samzareulos-danebi','hoverbordebi','qvabebisa-da-tapebis-nakrebebi','portatuli-damtenebi','mikrotalghuri-ghumelebi','miqserebi','chasashenebeli-ghumelebi','chasashenebeli-saretskhi-manqanebi','eleqtro-manqanebi','batutebi','kompresorebi','gamtsovi','satibebi','proeqtorebi-da-aqsesuarebi','tsvensatsurebi','blenderebi','kartrijebi-saghebavebi-qaghaldi','trenazhorebi','gasaberi-aveji','kompiuteris-aqsesuarebi','mogzauroba','khelis-instrumentebi','saretskh-satsmendi-sashualebebi','proeqtori','droni','tsnevit-saretskhi-aparatebi','tsentraluri-gatbobis-qvabi','tsklis-gamatskheleblebi','tosteri','haeris-gamtsmendi-da-damatenianeblebi','magida-da-skamebi','tmis-uto-staileri','kutkhsakhekhi','kompiuteris-natsilebi','protsesorebi') GROUP BY name HAVING c > 1;
