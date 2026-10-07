-- ============================================================================
-- superi.ge — 26: სტატიების ბმულები კატეგორიებიდან + კატეგორიის ტექსტები (მესამე ჯგუფი, 12)
-- 1) აეროგრილებს, სარბენ ბილიკებს და ნოუთბუქებს ემატება ბმული შესაბამის სტატიაზე (თუ უკვე არ არის).
-- 2) 12 კატეგორიას ერთხაზიანი სლოგანის/სიცარიელის ნაცვლად სრული ტექსტი ეწერება (მხოლოდ თუ ტექსტი 300 სიმბოლოზე მოკლეა).
-- ძველი ტექსტები ინახება superi_bk_cat_26-ში. ხელახლა გაშვება უსაფრთხოა.
-- ============================================================================
SET NAMES utf8mb4;
CREATE TABLE IF NOT EXISTS superi_bk_cat_26 AS SELECT cd.category_id, cd.lang_code, s.name AS slug, cd.description FROM cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = cd.lang_code AND s.company_id = 1 WHERE cd.lang_code = 'ka' AND s.name IN ('saretskhi-manqanebi', 'mtversasrutebi', 'gamtsovi', 'eleqtro-chaidnebi', 'samzareulos-danebi', 'proeqtorebi-da-aqsesuarebi', 'sakopatskhovrebo-teqnika', 'tsvrili-sakopatskhovrebo-teqnika', 'all-in-one', 'sabavshvo-produqtsia', 'batutebi', 'uto', 'aerogrilebi', 'sarbeni-bilikebi', 'noutbuqebi');
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'aerogrilebi' SET cd.description = CONCAT(IFNULL(cd.description, ''), '\n', '<p>დეტალური რჩევებისთვის წაიკითხეთ ჩვენი გზამკვლევი: <a href="https://superi.ge/rogor-shevarchiot-aerogrili/">როგორ შევარჩიოთ აეროგრილი</a>.</p>') WHERE cd.lang_code = 'ka' AND IFNULL(cd.description, '') NOT LIKE '%rogor-shevarchiot-aerogrili%';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'sarbeni-bilikebi' SET cd.description = CONCAT(IFNULL(cd.description, ''), '\n', '<p>დეტალური რჩევებისთვის წაიკითხეთ ჩვენი გზამკვლევი: <a href="https://superi.ge/rogor-shevarchiot-sarbeni-biliki/">როგორ შევარჩიოთ სარბენი ბილიკი</a>.</p>') WHERE cd.lang_code = 'ka' AND IFNULL(cd.description, '') NOT LIKE '%rogor-shevarchiot-sarbeni-biliki%';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'noutbuqebi' SET cd.description = CONCAT(IFNULL(cd.description, ''), '\n', '<p>დეტალური რჩევებისთვის წაიკითხეთ ჩვენი გზამკვლევი: <a href="https://superi.ge/rogor-avirchiot-noutbuqi-2026/">როგორ ავირჩიოთ ნოუთბუქი</a>.</p>') WHERE cd.lang_code = 'ka' AND IFNULL(cd.description, '') NOT LIKE '%rogor-avirchiot-noutbuqi-2026%';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'saretskhi-manqanebi' SET cd.description = '<p>სარეცხი მანქანა ოჯახის ერთ-ერთი ყველაზე ხშირად გამოყენებადი ტექნიკაა, ამიტომ სწორი არჩევანი წლების განმავლობაში ზოგავს დროს, წყალსა და დენს. Superi.ge-ზე იპოვით 250-ზე მეტ სარეცხ მანქანას — ჩვეულებრივ, ვიწრო და საშრობიან მოდელებს ბრენდებისგან: <a href="https://superi.ge/samsung/">Samsung</a>, <a href="https://superi.ge/bosch/">Bosch</a>, <a href="https://superi.ge/lg/">LG</a>, <a href="https://superi.ge/gorenje/">Gorenje</a>, <a href="https://superi.ge/midea/">Midea</a>, <a href="https://superi.ge/toshiba/">Toshiba</a>, <a href="https://superi.ge/beko/">Beko</a> და <a href="https://superi.ge/electrolux/">Electrolux</a>.</p>
<h2>როგორ შევარჩიოთ სარეცხი მანქანა</h2>
<ul>
<li><strong>ტევადობა:</strong> 1–2 ადამიანისთვის საკმარისია 6–7 კგ, 3–4 კაციანი ოჯახისთვის — 8–9 კგ, დიდი ოჯახისა და საბნების გასარეცხად — 10 კგ და მეტი.</li>
<li><strong>ზომა:</strong> სტანდარტული სიღრმე დაახლოებით 55–60 სმ-ია; მცირე აბაზანისთვის აირჩიეთ ვიწრო მოდელი. ყიდვამდე გაზომეთ ადგილი და კარის გასაღები სივრცე.</li>
<li><strong>ინვერტორული ძრავა:</strong> უფრო ჩუმად მუშაობს, ნაკლებ დენს ხარჯავს და დიდხანს ძლებს.</li>
<li><strong>დაწურვის სიჩქარე:</strong> 1200–1400 ბრ/წთ საკმარისია ყოველდღიური რეცხვისთვის — სარეცხი უფრო მშრალი გამოდის.</li>
<li><strong>საშრობიანი მოდელი:</strong> სარეცხ მანქანას საშრობით ცალკე საშრობისთვის ადგილი არ სჭირდება — კარგია ბინისთვის, სადაც აივანზე გაშრობა რთულია.</li>
<li><strong>პროგრამები:</strong> ორთქლით რეცხვა, სწრაფი პროგრამა და ბავშვის ტანსაცმლის რეჟიმი რეცხვას უფრო მოსახერხებელს ხდის.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/sashrobebi/">საშრობი მანქანები</a>, <a href="https://superi.ge/chasashenebeli-saretskhi-manqanebi/">ჩასაშენებელი სარეცხი მანქანები</a> და <a href="https://superi.ge/saretskh-satsmendi-sashualebebi/">სარეცხ-საწმენდი საშუალებები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'mtversasrutebi' SET cd.description = '<p>Superi.ge-ზე იპოვით 170-ზე მეტ მტვერსასრუტს — ტომრიან და უტომრო, უსადენო ვერტიკალურ, რობოტ და სველი წმენდის მოდელებს ბრენდებისგან: <a href="https://superi.ge/dyson/">Dyson</a>, <a href="https://superi.ge/bosch/">Bosch</a>, <a href="https://superi.ge/dreame/">Dreame</a>, <a href="https://superi.ge/samsung/">Samsung</a>, <a href="https://superi.ge/lg/">LG</a>, <a href="https://superi.ge/gorenje/">Gorenje</a>, <a href="https://superi.ge/shark/">Shark</a>, <a href="https://superi.ge/beko/">Beko</a> და <a href="https://superi.ge/midea/">Midea</a>.</p>
<h2>როგორ შევარჩიოთ მტვერსასრუტი</h2>
<ul>
<li><strong>ტიპი:</strong> კლასიკური მტვერსასრუტი მძლავრია და დიდი ბინისთვის კარგია; უსადენო ვერტიკალური სწრაფი ყოველდღიური დალაგებისთვისაა; რობოტი მტვერსასრუტი თავად წმენდს თქვენი მონაწილეობის გარეშე; სველი წმენდის მოდელი იატაკსაც რეცხავს.</li>
<li><strong>ტომრით თუ უტომროდ:</strong> უტომრო (ციკლონური) მოდელში ტომრის ყიდვა არ გიწევთ — კონტეინერს უბრალოდ ცლით; ტომრიანი მოდელი მტვერს უკეთ იჭერს და ალერგიის დროს უფრო მოსახერხებელია.</li>
<li><strong>შეწოვის სიმძლავრე:</strong> ხალიჩებისა და შინაური ცხოველების ბეწვისთვის აირჩიეთ მაღალი შეწოვის სიმძლავრე და ტურბო ჯაგრისი.</li>
<li><strong>ბატარეა:</strong> უსადენო მოდელისთვის 40–60 წუთი მუშაობა საშუალო ზომის ბინისთვის საკმარისია; მოსახსნელი ბატარეა მის შეცვლას ამარტივებს.</li>
<li><strong>ფილტრი:</strong> HEPA ფილტრი წვრილ მტვერსა და ალერგენებს იჭერს — მნიშვნელოვანია ალერგიისა და ასთმის დროს.</li>
<li><strong>ხმაური:</strong> ჩუმი მოდელი განსაკუთრებით მნიშვნელოვანია, თუ სახლში პატარა ბავშვები არიან.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/uto/">უთოები</a>, <a href="https://superi.ge/haeris-gamtsmendi-da-damatenianeblebi/">ჰაერის გამწმენდები</a> და <a href="https://superi.ge/tsvrili-sakopatskhovrebo-teqnika/">წვრილი საყოფაცხოვრებო ტექნიკა</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'gamtsovi' SET cd.description = '<p>სამზარეულოს გამწოვი მომზადებისას გამოყოფილ ორთქლს, ცხიმსა და სუნს შთანთქავს — სამზარეულო სუფთა რჩება, ავეჯი და კედლები კი ცხიმისგან დაცული. Superi.ge-ზე იპოვით ჩასაშენებელ, კედლის, დახრილ და ტელესკოპურ გამწოვებს ბრენდებისგან: <a href="https://superi.ge/bosch/">Bosch</a>, <a href="https://superi.ge/gorenje/">Gorenje</a>, <a href="https://superi.ge/beko/">Beko</a>, <a href="https://superi.ge/midea/">Midea</a>, <a href="https://superi.ge/samsung/">Samsung</a>, <a href="https://superi.ge/electrolux/">Electrolux</a> და <a href="https://superi.ge/graetz/">Graetz</a>.</p>
<h2>როგორ შევარჩიოთ გამწოვი</h2>
<ul>
<li><strong>ტიპი:</strong> ჩასაშენებელი და ტელესკოპური გამწოვი კარადაში იმალება; კედლის (ბუხრის ტიპის) და დახრილი გამწოვი კი სამზარეულოს დიზაინის ნაწილი ხდება.</li>
<li><strong>სიგანე:</strong> გამწოვი ქურის ზედაპირის სიგანეს უნდა შეესაბამებოდეს ან ოდნავ აღემატებოდეს — 60 სმ ზედაპირისთვის 60 სმ, დიდი ქურისთვის 90 სმ.</li>
<li><strong>წარმადობა (მ³/სთ):</strong> რაც დიდია სამზარეულო, მით მეტი წარმადობაა საჭირო. საორიენტაციოდ: სამზარეულოს მოცულობა (ფართობი × სიმაღლე) გაამრავლეთ 10–12-ზე.</li>
<li><strong>გაწოვა თუ ცირკულაცია:</strong> ჰაერის გარეთ გაყვანა უფრო ეფექტურია; თუ სავენტილაციო არხი არ გაქვთ, გამოიყენეთ ცირკულაციის რეჟიმი ნახშირის ფილტრით.</li>
<li><strong>ხმაური და მართვა:</strong> ჩუმი ძრავა, სენსორული მართვა და LED განათება მომზადებას უფრო კომფორტულს ხდის.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/quris-zedapiri/">ქურის ზედაპირები</a>, <a href="https://superi.ge/gazqurebi/">გაზქურები</a> და <a href="https://superi.ge/chasashenebeli-ghumelebi/">ჩასაშენებელი ღუმელები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'eleqtro-chaidnebi' SET cd.description = '<p>ელექტრო ჩაიდანი წყალს წუთებში ადუღებს და სამზარეულოს ყველაზე ხშირად გამოყენებადი ტექნიკაა. Superi.ge-ზე იპოვით 60-ზე მეტ ჩაიდანს ბრენდებისგან: <a href="https://superi.ge/bosch/">Bosch</a>, <a href="https://superi.ge/smeg/">Smeg</a>, <a href="https://superi.ge/gorenje/">Gorenje</a>, <a href="https://superi.ge/braun/">Braun</a>, <a href="https://superi.ge/midea/">Midea</a>, <a href="https://superi.ge/delonghi/">DeLonghi</a>, <a href="https://superi.ge/beko/">Beko</a> და <a href="https://superi.ge/electrolux/">Electrolux</a> — კლასიკური, მინის, ტემპერატურის რეგულირების მქონე და რეტრო დიზაინის მოდელებს.</p>
<h2>როგორ შევარჩიოთ ელექტრო ჩაიდანი</h2>
<ul>
<li><strong>მოცულობა:</strong> 1–2 ადამიანისთვის საკმარისია 1–1.5 ლიტრი, ოჯახისთვის — 1.7 ლიტრი.</li>
<li><strong>კორპუსის მასალა:</strong> უჟანგავი ფოლადი გამძლეა, მინის კორპუსი ლამაზად გამოიყურება და წყლის დონე კარგად ჩანს, პლასტმასის კი მსუბუქი და ხელმისაწვდომია.</li>
<li><strong>ტემპერატურის რეგულირება:</strong> მწვანე ჩაისა და ბავშვის საკვებისთვის წყალი 70–80 °C-მდე უნდა გაცხელდეს — ასეთი ჩაიდანი ტემპერატურას ზუსტად ინარჩუნებს.</li>
<li><strong>უსაფრთხოება:</strong> ავტომატური გათიშვა ადუღებისას და ცარიელი ჩაიდნის ჩართვისგან დაცვა აუცილებელია.</li>
<li><strong>ფილტრი:</strong> მოსახსნელი ნადების ფილტრი ჩაის ჭიქაში ნადების მოხვედრას ამცირებს.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/yavis-aparatebi/">ყავის აპარატები</a>, <a href="https://superi.ge/tosteri/">ტოსტერები</a> და <a href="https://superi.ge/dispenserebi/">წყლის დისპენსერები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'samzareulos-danebi' SET cd.description = '<p>ხარისხიანი დანა სამზარეულოში ყველაზე მნიშვნელოვანი ხელსაწყოა — ჭრა ხდება სწრაფი, ზუსტი და უსაფრთხო. Superi.ge-ზე იპოვით დანების ნაკრებებს ბრენდებისგან: <a href="https://superi.ge/smeg/">Smeg</a>, <a href="https://superi.ge/tefal/">Tefal</a>, <a href="https://superi.ge/korkmaz/">Korkmaz</a>, <a href="https://superi.ge/ardesto/">Ardesto</a>, <a href="https://superi.ge/arshia/">Arshia</a> და <a href="https://superi.ge/ninja/">Ninja</a> — სადგამით და მის გარეშე.</p>
<h2>როგორ შევარჩიოთ დანების ნაკრები</h2>
<ul>
<li><strong>ნაკრების შემადგენლობა:</strong> საბაზისო ნაკრებში უნდა იყოს შეფის დანა, პურის დანა, უნივერსალური და გასაფცქვნელი დანა; დიდი ნაკრები ფილეს დანასა და მაკრატელსაც შეიცავს.</li>
<li><strong>ფოლადი:</strong> მაღალი ხარისხის უჟანგავი ფოლადი დიდხანს ინარჩუნებს სიბასრეს და კოროზიას უძლებს.</li>
<li><strong>სახელური:</strong> ერგონომიული, ხელში კარგად მოსარგები და არამოსრიალე სახელური ჭრისას უსაფრთხოებას უზრუნველყოფს.</li>
<li><strong>შენახვა:</strong> სადგამი ან ბლოკი დანებს იცავს და სამზარეულოში წესრიგს ინარჩუნებს.</li>
<li><strong>მოვლა:</strong> დანები ხელით გარეცხეთ და დროდადრო გალესეთ — ასე უფრო დიდხანს გაძლებს.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/qvabebisa-da-tapebis-nakrebebi/">ქვაბებისა და ტაფების ნაკრებები</a>, <a href="https://superi.ge/samzareulos-aqsesuarebi/">სამზარეულოს აქსესუარები</a> და <a href="https://superi.ge/churcheli/">ჭურჭელი</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'proeqtorebi-da-aqsesuarebi' SET cd.description = '<p>პროექტორი დიდ ეკრანს ნებისმიერ ოთახში ქმნის — ფილმების საყურებლად, თამაშებისთვის, პრეზენტაციებისა და გაკვეთილებისთვის. Superi.ge-ზე იპოვით <a href="https://superi.ge/proeqtori/">პროექტორებს</a> ბრენდებისგან: Acer, Epson, ViewSonic, Vivitek, Wanbo, Xiaomi და BYINTEK, ასევე <a href="https://superi.ge/proeqtoris-ekranebi/">პროექტორის ეკრანებს</a> (Allscreen, Reflecta) — სადგამიან, კედლის, ელექტრო და გასაბერ მოდელებს.</p>
<h2>როგორ შევარჩიოთ პროექტორი</h2>
<ul>
<li><strong>სიკაშკაშე (ლუმენი):</strong> ბნელ ოთახში საკმარისია 2000–3000 ლუმენი; განათებული ოთახისა და ოფისისთვის აირჩიეთ 3500 ლუმენი და მეტი.</li>
<li><strong>გარჩევადობა:</strong> ფილმებისთვის აირჩიეთ Full HD ან 4K; პრეზენტაციებისთვის XGA/WXGA გარჩევადობაც საკმარისია.</li>
<li><strong>პროექციის მანძილი:</strong> მოკლე პროექციის პროექტორი დიდ სურათს მცირე მანძილიდანაც იძლევა — კარგია პატარა ოთახისთვის.</li>
<li><strong>Smart ფუნქციები:</strong> ჩაშენებული Android, Wi-Fi და Bluetooth საშუალებას გაძლევთ YouTube და Netflix პირდაპირ პროექტორიდან უყუროთ.</li>
<li><strong>ეკრანი:</strong> სპეციალური ეკრანი კედელთან შედარებით უფრო კაშკაშა და მკვეთრ სურათს იძლევა.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/televizorebi/">ტელევიზორები</a> და <a href="https://superi.ge/saopise-da-qseluri-motskobilobebi/">საოფისე და ქსელური მოწყობილობები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'sakopatskhovrebo-teqnika' SET cd.description = '<p>საყოფაცხოვრებო ტექნიკა სახლის ყოველდღიური კომფორტის საფუძველია. Superi.ge-ზე იპოვით მსხვილ საყოფაცხოვრებო ტექნიკას წამყვანი ბრენდებისგან — <a href="https://superi.ge/bosch/">Bosch</a>, <a href="https://superi.ge/gorenje/">Gorenje</a>, <a href="https://superi.ge/beko/">Beko</a>, <a href="https://superi.ge/midea/">Midea</a>, <a href="https://superi.ge/samsung/">Samsung</a>, <a href="https://superi.ge/lg/">LG</a> და <a href="https://superi.ge/hisense/">Hisense</a> და სხვა.</p>
<h2>კატეგორიები</h2>
<ul>
<li><a href="https://superi.ge/macivrebi/">მაცივრები</a> და <a href="https://superi.ge/sakinule/">საყინულეები</a></li>
<li><a href="https://superi.ge/saretskhi-manqanebi/">სარეცხი მანქანები</a> და <a href="https://superi.ge/sashrobebi/">საშრობი მანქანები</a></li>
<li><a href="https://superi.ge/churchelis-sarecxhi-manqanebi/">ჭურჭლის სარეცხი მანქანები</a></li>
<li><a href="https://superi.ge/gazqurebi/">გაზქურები</a>, <a href="https://superi.ge/quris-zedapiri/">ქურის ზედაპირები</a> და <a href="https://superi.ge/chasashenebeli-ghumelebi/">ჩასაშენებელი ღუმელები</a></li>
<li><a href="https://superi.ge/gamtsovi/">გამწოვები</a></li>
</ul>
<p>ყიდვამდე გაზომეთ ტექნიკისთვის განკუთვნილი ადგილი, შეამოწმეთ ენერგოეფექტურობის კლასი და ინვერტორული ძრავის არსებობა — ასეთი ტექნიკა ნაკლებ დენს ხარჯავს და უფრო ჩუმად მუშაობს. შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'tsvrili-sakopatskhovrebo-teqnika' SET cd.description = '<p>წვრილი საყოფაცხოვრებო ტექნიკა ყოველდღიურ საქმეს ამარტივებს — დალაგებას, დაუთოებას და თავის მოვლას. Superi.ge-ზე იპოვით 200-ზე მეტ პროდუქტს ბრენდებისგან: <a href="https://superi.ge/dyson/">Dyson</a>, <a href="https://superi.ge/dreame/">Dreame</a>, <a href="https://superi.ge/bosch/">Bosch</a>, <a href="https://superi.ge/gorenje/">Gorenje</a>, <a href="https://superi.ge/samsung/">Samsung</a>, <a href="https://superi.ge/braun/">Braun</a>, <a href="https://superi.ge/philips/">Philips</a> და <a href="https://superi.ge/shark/">Shark</a>.</p>
<h2>კატეგორიები</h2>
<ul>
<li><a href="https://superi.ge/mtversasrutebi/">მტვერსასრუტები</a> — კლასიკური, უსადენო, რობოტი და სველი წმენდის</li>
<li><a href="https://superi.ge/uto/">უთოები</a> და ორთქლის გენერატორები</li>
<li><a href="https://superi.ge/tmis-uto-staileri/">თმის უთოები და სტაილერები</a></li>
<li><a href="https://superi.ge/haeris-gamtsmendi-da-damatenianeblebi/">ჰაერის გამწმენდები და დამატენიანებლები</a></li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/samzarelos-teqnika/">სამზარეულოს ტექნიკა</a> და <a href="https://superi.ge/sakopatskhovrebo-teqnika/">საყოფაცხოვრებო ტექნიკა</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'all-in-one' SET cd.description = '<p>All-in-One კომპიუტერი (მონობლოკი) კომპიუტერსა და მონიტორს ერთ კორპუსში აერთიანებს — ზედმეტი სადენები და სისტემური ბლოკი აღარ გჭირდებათ, სამუშაო მაგიდა კი მოწესრიგებული რჩება. Superi.ge-ზე იპოვით მონობლოკებს ბრენდებისგან: <a href="https://superi.ge/lenovo/">Lenovo</a>, <a href="https://superi.ge/asus/">ASUS</a>, <a href="https://superi.ge/apple/">Apple iMac</a>, <a href="https://superi.ge/acer/">Acer</a> და <a href="https://superi.ge/chuwi/">Chuwi</a>.</p>
<h2>როგორ შევარჩიოთ All-in-One კომპიუტერი</h2>
<ul>
<li><strong>ეკრანი:</strong> 22–24 დიუმი საკმარისია სახლისა და ოფისისთვის; 27 დიუმიანი ეკრანი კი უფრო კომფორტულია ფოტოებთან, ვიდეოსთან და რამდენიმე ფანჯარასთან მუშაობისას.</li>
<li><strong>პროცესორი:</strong> ოფისისა და ინტერნეტისთვის Intel Core i3 / AMD Ryzen 3 საკმარისია; უფრო მძიმე პროგრამებისთვის აირჩიეთ i5/i7 ან Ryzen 5/7.</li>
<li><strong>ოპერატიული მეხსიერება:</strong> მინიმუმ 8 GB; ბევრ პროგრამასთან ერთდროული მუშაობისთვის — 16 GB.</li>
<li><strong>მეხსიერება:</strong> SSD დისკი კომპიუტერს გაცილებით სწრაფს ხდის — რეკომენდებულია 512 GB ან მეტი.</li>
<li><strong>დამატებითი:</strong> ვებკამერა და მიკროფონი ვიდეოზარებისთვის, Wi-Fi და Bluetooth უსადენო მოწყობილობებისთვის.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/noutbuqebi/">ნოუთბუქები</a>, <a href="https://superi.ge/monitor/">მონიტორები</a> და <a href="https://superi.ge/kompiuteris-aqsesuarebi/">კომპიუტერის აქსესუარები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'sabavshvo-produqtsia' SET cd.description = '<p>სწორად შერჩეული სათამაშო ბავშვს ართობს და თან ავითარებს — ფანტაზიას, ლოგიკას და ხელის მოტორიკას. Superi.ge-ზე იპოვით <a href="https://superi.ge/lego/">LEGO</a>-ს კონსტრუქტორებს (City, Ninjago, Jurassic World, Minecraft, Botanicals), <a href="https://superi.ge/llorens/">Llorens</a>-ის თოჯინებს და საბავშვო ელექტრო მანქანებს.</p>
<h2>როგორ შევარჩიოთ სათამაშო</h2>
<ul>
<li><strong>ასაკი:</strong> ყოველთვის გაითვალისწინეთ შეფუთვაზე მითითებული ასაკი — პატარა დეტალები სამ წლამდე ბავშვებისთვის საშიშია.</li>
<li><strong>ინტერესი:</strong> კონსტრუქტორი ლოგიკასა და სივრცით აზროვნებას ავითარებს, თოჯინა — ფანტაზიასა და როლურ თამაშს, ელექტრო მანქანა კი აქტიურ თამაშს ეზოში.</li>
<li><strong>ხარისხი:</strong> აირჩიეთ ცნობილი ბრენდის, უსაფრთხო მასალისგან დამზადებული სათამაშო.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/satamashoebi/">სათამაშოები</a>, <a href="https://superi.ge/eleqtro-manqanebi/">საბავშვო ელექტრო მანქანები</a> და <a href="https://superi.ge/batutebi/">ბატუტები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'batutebi' SET cd.description = '<p>ბატუტი ბავშვებისთვის ერთ-ერთი ყველაზე სახალისო და აქტიური გართობაა — ავითარებს წონასწორობას, კოორდინაციას და ენერგიას სასარგებლოდ ხარჯავს. Superi.ge-ზე იპოვით სახლისა და ეზოს ბატუტებს 1.4-დან 2.44 მეტრამდე დიამეტრით, დამცავი ბადით.</p>
<h2>როგორ შევარჩიოთ ბატუტი</h2>
<ul>
<li><strong>ზომა:</strong> 1.4–1.5 მეტრიანი ბატუტი კომპაქტურია და ოთახში ან პატარა ეზოში ეტევა — კარგია პატარა ბავშვებისთვის; 2.4 მეტრიანი და მეტი ეზოსთვისაა და უფროს ბავშვებსაც იტევს.</li>
<li><strong>მაქსიმალური დატვირთვა:</strong> ყურადღება მიაქციეთ მწარმოებლის მიერ მითითებულ მაქსიმალურ წონას (მაგ. 150 კგ-მდე).</li>
<li><strong>უსაფრთხოება:</strong> დამცავი ბადე, დაფარული ზამბარები და მყარი კარკასი ვარდნისგან იცავს.</li>
<li><strong>ადგილი:</strong> ბატუტი დადგით სწორ ზედაპირზე, ხეებისა და ღობისგან მოშორებით.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/sporti/">სპორტი და დასვენება</a>, <a href="https://superi.ge/satamashoebi/">სათამაშოები</a> და <a href="https://superi.ge/hoverbordebi/">ჰოვერბორდები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'uto' SET cd.description = '<p>კარგი უთო ტანსაცმელს სწრაფად და უსაფრთხოდ ასწორებს — ნაოჭებს მარტივად აქრობს და ქსოვილს არ აზიანებს. Superi.ge-ზე იპოვით ორთქლის უთოებს, უსადენო უთოებსა და ორთქლის გენერატორებს ბრენდებისგან: <a href="https://superi.ge/braun/">Braun</a>, <a href="https://superi.ge/philips/">Philips</a>, <a href="https://superi.ge/gorenje/">Gorenje</a>, <a href="https://superi.ge/tefal/">Tefal</a>, <a href="https://superi.ge/beko/">Beko</a> და <a href="https://superi.ge/fakir/">Fakir</a>.</p>
<h2>როგორ შევარჩიოთ უთო</h2>
<ul>
<li><strong>ორთქლის უთო თუ ორთქლის გენერატორი:</strong> ორთქლის უთო კომპაქტური და ხელმისაწვდომია; ორთქლის გენერატორი (მაგ. Braun CareStyle) ცალკე ავზით ბევრად ძლიერ ორთქლს იძლევა — დიდი რაოდენობით დასაუთოებლად და მძიმე ქსოვილებისთვის.</li>
<li><strong>სიმძლავრე:</strong> 2000–2600 W-იანი უთო სწრაფად ცხელდება და ორთქლის სტაბილურ ნაკადს იძლევა.</li>
<li><strong>ძირი:</strong> კერამიკული და სპეციალური საფარის ძირი კარგად სრიალებს და ქსოვილს არ ეწებება.</li>
<li><strong>ორთქლის დარტყმა:</strong> მძლავრი ორთქლის დარტყმა მძიმე ნაოჭებსაც აქრობს; ვერტიკალური ორთქლი კი ფარდებისა და დაკიდებული ტანსაცმლისთვისაა.</li>
<li><strong>უსაფრთხოება:</strong> ავტომატური გათიშვა, თუ უთო დიდხანს უმოძრაოდ დარჩა.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/tsvrili-sakopatskhovrebo-teqnika/">წვრილი საყოფაცხოვრებო ტექნიკა</a>, <a href="https://superi.ge/mtversasrutebi/">მტვერსასრუტები</a> და <a href="https://superi.ge/saretskhi-manqanebi/">სარეცხი მანქანები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
SELECT s.name AS slug, CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) AS text_chars FROM cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE cd.lang_code = 'ka' AND s.name IN ('saretskhi-manqanebi', 'mtversasrutebi', 'gamtsovi', 'eleqtro-chaidnebi', 'samzareulos-danebi', 'proeqtorebi-da-aqsesuarebi', 'sakopatskhovrebo-teqnika', 'tsvrili-sakopatskhovrebo-teqnika', 'all-in-one', 'sabavshvo-produqtsia', 'batutebi', 'uto', 'aerogrilebi', 'sarbeni-bilikebi', 'noutbuqebi') ORDER BY s.name;
-- დაბრუნება: UPDATE cscart_category_descriptions cd JOIN superi_bk_cat_26 b ON b.category_id = cd.category_id AND b.lang_code = cd.lang_code SET cd.description = b.description;
