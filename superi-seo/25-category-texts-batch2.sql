-- ============================================================================
-- superi.ge — 25: კატეგორიის ტექსტები (მეორე ჯგუფი, 11 კატეგორია)
-- ერთხაზიანი სლოგანი იცვლება სრული ტექსტით (მხოლოდ თუ ტექსტი 300 სიმბოლოზე მოკლეა).
-- „სპორტი და დასვენება“-ს ტექსტი მხოლოდ ჰოვერბორდებზე იყო — გასწორდა.
-- ძველი ტექსტები ინახება superi_bk_cat_25-ში. ხელახლა გაშვება უსაფრთხოა.
-- ============================================================================
SET NAMES utf8mb4;
CREATE TABLE IF NOT EXISTS superi_bk_cat_25 AS SELECT cd.category_id, cd.lang_code, s.name AS slug, cd.description FROM cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = cd.lang_code AND s.company_id = 1 WHERE cd.lang_code = 'ka' AND s.name IN ('blenderebi', 'xelis-traqtorebi', 'statsionaluri-teleponebi', 'qvabebisa-da-tapebis-nakrebebi', 'xorcis-sakepi-manqanebi', 'routers', 'kompresorebi', 'trenazhorebi', 'miqserebi', 'dispenserebi', 'sporti');
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'blenderebi' SET cd.description = '<p>ბლენდერი სამზარეულოს ერთ-ერთი ყველაზე უნივერსალური დამხმარეა — სმუზი, სუპ-პიურე, სოუსები, ცომი და ბავშვის საკვები წუთებში მზადდება. Superi.ge-ზე იპოვით ხელის, სტაციონარულ და პორციულ ბლენდერებს წამყვანი ბრენდებისგან: <a href="https://superi.ge/bosch/">Bosch</a>, <a href="https://superi.ge/braun/">Braun</a>, <a href="https://superi.ge/nutribullet/">NutriBullet</a>, <a href="https://superi.ge/ninja/">Ninja</a>, <a href="https://superi.ge/gorenje/">Gorenje</a>, <a href="https://superi.ge/midea/">Midea</a> და <a href="https://superi.ge/smeg/">Smeg</a>.</p>
<h2>როგორ შევარჩიოთ ბლენდერი</h2>
<ul>
<li><strong>ტიპი:</strong> ხელის (ჩასაშვები) ბლენდერი კომპაქტურია და პირდაპირ ქვაბში ასრესს; სტაციონარული ბლენდერი სასმისით კარგია სმუზისა და კოქტეილებისთვის; პორციული ბლენდერი სმუზს პირდაპირ სამოგზაურო ბოთლში ამზადებს.</li>
<li><strong>სიმძლავრე:</strong> ხელის ბლენდერისთვის 600–1000 W საკმარისია; ყინულისა და მყარი პროდუქტებისთვის აირჩიეთ 1000 W-ზე მეტი სიმძლავრის სტაციონარული მოდელი.</li>
<li><strong>სასმისის მასალა:</strong> მინის სასმისი მძიმე და გამძლეა, არ იკაწრება და სუნს არ იწოვს; პლასტმასის სასმისი მსუბუქი და უსაფრთხოა.</li>
<li><strong>სიჩქარეები და რეჟიმები:</strong> რამდენიმე სიჩქარე და იმპულსური (Turbo) რეჟიმი სხვადასხვა პროდუქტისთვის უკეთეს შედეგს იძლევა.</li>
<li><strong>კომპლექტაცია:</strong> ჩოფერი, სათქვეფი და საზომი ჭიქა ხელის ბლენდერს მინი-კომბაინად აქცევს.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/miqserebi/">მიქსერები</a>, <a href="https://superi.ge/samzareulos-kombainebi/">სამზარეულოს კომბაინები</a> და <a href="https://superi.ge/choferebi/">ჩოფერები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'xelis-traqtorebi' SET cd.description = '<p>ხელის ტრაქტორი (მოტობლოკი) ბაღისა და ბოსტნის მთავარი დამხმარეა — ხნავს და აფხვიერებს მიწას, დამატებითი დანადგარებით კი თიბავს და ტვირთსაც გადაზიდავს. Superi.ge-ზე იპოვით ბენზინისა და დიზელის მოტობლოკებს 7-დან 15 ცხენის ძალამდე, ასევე კულტივატორებსა და მისაბმელებს. ბრენდები: <a href="https://superi.ge/hyundai/">Hyundai</a>, <a href="https://superi.ge/bauma/">Bauma</a>, <a href="https://superi.ge/royal-turbo/">Royal Turbo</a>, <a href="https://superi.ge/storm/">Storm</a> და <a href="https://superi.ge/eurosystems/">Eurosystems</a>.</p>
<h2>როგორ შევარჩიოთ ხელის ტრაქტორი</h2>
<ul>
<li><strong>სიმძლავრე:</strong> 7 ცხ. ძ. მოტობლოკი საშუალო ზომის ბაღ-ბოსტნისთვისაა შესაფერისი; მძიმე, თიხნარი ნიადაგისა და დიდი ნაკვეთისთვის უმჯობესია 9–15 ცხ. ძ.</li>
<li><strong>საწვავი:</strong> ბენზინის ძრავა მსუბუქია და ადვილად იქოქება; დიზელის ძრავა უფრო ეკონომიურია და ხანგრძლივ დატვირთვას უკეთ უძლებს.</li>
<li><strong>ქოქვა:</strong> ელექტროსტარტერი ქოქვას ამარტივებს, განსაკუთრებით ცივ ამინდში.</li>
<li><strong>გადაცემათა კოლოფი:</strong> რამდენიმე სიჩქარე და უკუსვლა მანევრირებას ამარტივებს, განსაკუთრებით პატარა ნაკვეთზე.</li>
<li><strong>დანადგარები:</strong> ფრეზები, გუთანი, მისაბმელი და სათიბი ადაპტერი მოტობლოკს მრავალფუნქციურს ხდის — ყიდვისას შეამოწმეთ კომპლექტაცია.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/baghi-da-ezo/">ბაღი და ეზო</a>, <a href="https://superi.ge/gazonis-sakrechi-manqanebi/">გაზონის საკრეჭები</a>, <a href="https://superi.ge/satibebi/">სათიბები</a> და <a href="https://superi.ge/generatorebi/">გენერატორები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'statsionaluri-teleponebi' SET cd.description = '<p>სტაციონარული ტელეფონი კვლავ შეუცვლელია ოფისში, მაღაზიასა და სახლში — მკაფიო ხმა, მარტივი მართვა და საიმედოობა, რაც განსაკუთრებით მოსახერხებელია ასაკოვანი ადამიანებისთვის. Superi.ge-ზე წარმოდგენილია <a href="https://superi.ge/panasonic/">Panasonic</a>-ის სადენიანი და უსადენო (DECT) ტელეფონები.</p>
<h2>როგორ შევარჩიოთ სტაციონარული ტელეფონი</h2>
<ul>
<li><strong>სადენიანი თუ უსადენო:</strong> სადენიანი ტელეფონი (Panasonic KX-TS სერია) მარტივი და ხელმისაწვდომია; უსადენო DECT ტელეფონით (KX-TG სერია) სახლში ან ოფისში თავისუფლად გადაადგილდებით.</li>
<li><strong>ავტომოპასუხე:</strong> ავტომოპასუხიანი მოდელი (მაგ. KX-TGJ320) გამოტოვებულ ზარებს ჩაიწერს.</li>
<li><strong>ნომრის მაჩვენებელი და სატელეფონო წიგნი:</strong> ხედავთ, ვინ რეკავს, ხშირად გამოყენებულ ნომრებს კი მეხსიერებაში ინახავთ.</li>
<li><strong>სპიკერფონი:</strong> ზარზე ხელის გარეშე საუბრის საშუალებას იძლევა.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/mobiluri-teleponebi/">მობილური ტელეფონები</a> და <a href="https://superi.ge/saopise-da-qseluri-motskobilobebi/">საოფისე და ქსელური მოწყობილობები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'qvabebisa-da-tapebis-nakrebebi' SET cd.description = '<p>ხარისხიანი ქვაბებისა და ტაფების ნაკრები ყოველდღიური მომზადების საფუძველია: ერთი ყიდვით სამზარეულოს მთლიანად აღჭურავთ, ჭურჭელი კი ერთ სტილში იქნება. Superi.ge-ზე იპოვით უჟანგავი ფოლადის, გრანიტისა და არაწებოვანი საფარის ნაკრებებს ბრენდებისგან: <a href="https://superi.ge/korkmaz/">Korkmaz</a>, <a href="https://superi.ge/tefal/">Tefal</a>, <a href="https://superi.ge/berllong/">Berllong</a>, <a href="https://superi.ge/ardesto/">Ardesto</a>, <a href="https://superi.ge/arshia/">Arshia</a>, <a href="https://superi.ge/falez/">Falez</a> და <a href="https://superi.ge/gorenje/">Gorenje</a>.</p>
<h2>როგორ შევარჩიოთ ქვაბების ნაკრები</h2>
<ul>
<li><strong>მასალა:</strong> უჟანგავი ფოლადი (მაგ. 18/10) გამძლე და ჰიგიენურია; გრანიტისა და ბიო გრანიტის საფარი არაწებოვანია და ცოტა ზეთით მომზადების საშუალებას იძლევა.</li>
<li><strong>ქურის ტიპი:</strong> ინდუქციური ქურისთვის საჭიროა მაგნიტური ძირი — შეამოწმეთ, აღნიშნულია თუ არა ინდუქციასთან თავსებადობა.</li>
<li><strong>ნაკრების შემადგენლობა:</strong> ნაკრები, როგორც წესი, 5-დან 12 და მეტ ნაწილს მოიცავს — ქვაბებს, ტაფებსა და სახურავებს. აირჩიეთ ოჯახის ზომისა და მომზადების ჩვევების მიხედვით.</li>
<li><strong>სახურავები და სახელურები:</strong> მინის სახურავით მომზადებას აკონტროლებთ, სითბოგამძლე სახელურები კი ხელს არ გიწვავთ.</li>
<li><strong>მოვლა:</strong> შეამოწმეთ, შეიძლება თუ არა ნაკრების ჭურჭლის სარეცხ მანქანაში რეცხვა.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/churcheli/">ჭურჭელი</a>, <a href="https://superi.ge/samzareulos-aqsesuarebi/">სამზარეულოს აქსესუარები</a> და <a href="https://superi.ge/samzareulos-danebi/">სამზარეულოს დანები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'xorcis-sakepi-manqanebi' SET cd.description = '<p>ელექტრო ხორცსაკეპი მანქანა ფარშს წუთებში ამზადებს — კატლეტისთვის, ხინკლისა და ქაბაბისთვის, ასევე ბოსტნეულისა და ძეხვის მოსამზადებლად. Superi.ge-ზე იპოვით ხორცსაკეპებს ბრენდებისგან: <a href="https://superi.ge/bosch/">Bosch</a>, <a href="https://superi.ge/gorenje/">Gorenje</a>, <a href="https://superi.ge/kenwood/">Kenwood</a>, <a href="https://superi.ge/fakir/">Fakir</a> და <a href="https://superi.ge/sencor/">Sencor</a>.</p>
<h2>როგორ შევარჩიოთ ხორცსაკეპი მანქანა</h2>
<ul>
<li><strong>სიმძლავრე და წარმადობა:</strong> მნიშვნელოვანია არა მხოლოდ სიმძლავრე, არამედ წარმადობაც — რამდენ კილოგრამ ხორცს ფქვავს წუთში. ოჯახისთვის 1.5–2 კგ/წთ საკმარისია, ხშირი და დიდი რაოდენობით გამოყენებისთვის აირჩიეთ უფრო მძლავრი მოდელი.</li>
<li><strong>რევერსი:</strong> უკუსვლის ფუნქცია ძარღვიანი ხორცის ჩაჭედვისას მექანიზმს ათავისუფლებს.</li>
<li><strong>საქშენები:</strong> სხვადასხვა ზომის საცერები, ძეხვისა და კებეს საქშენი და ბოსტნეულის საჭრელი მანქანას მრავალფუნქციურს ხდის.</li>
<li><strong>მასალა:</strong> ლითონის კორპუსი და სახეხი ნაწილები უფრო გამძლეა.</li>
<li><strong>მოვლა:</strong> ალუმინის ნაწილები ხელით გარეცხეთ — ჭურჭლის სარეცხ მანქანაში შეიძლება გაშავდეს.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/blenderebi/">ბლენდერები</a>, <a href="https://superi.ge/samzareulos-kombainebi/">სამზარეულოს კომბაინები</a> და <a href="https://superi.ge/miqserebi/">მიქსერები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'routers' SET cd.description = '<p>კარგი როუტერი სწრაფი და სტაბილური ინტერნეტის საფუძველია მთელ სახლსა და ოფისში. Superi.ge-ზე იპოვით <a href="https://superi.ge/tp-link/">TP-Link</a>-ის, <a href="https://superi.ge/asus/">ASUS</a>-ის, <a href="https://superi.ge/xiaomi/">Xiaomi</a>-ს და <a href="https://superi.ge/tenda/">Tenda</a>-ს როუტერებს — Wi-Fi 6, 6E და Wi-Fi 7 მოდელებს, Mesh სისტემებს (TP-Link Deco, ASUS ZenWiFi), 4G და 5G SIM-ბარათიან და სათამაშო როუტერებს.</p>
<h2>როგორ შევარჩიოთ როუტერი</h2>
<ul>
<li><strong>Wi-Fi სტანდარტი:</strong> Wi-Fi 5 (AC) საბაზისო საჭიროებისთვის საკმარისია; Wi-Fi 6 (AX) უფრო სწრაფი და სტაბილურია, როცა ბევრი მოწყობილობაა ჩართული; Wi-Fi 7 (BE) კი ყველაზე ახალი სტანდარტია მაღალი სიჩქარისა და დაბალი დაყოვნებისთვის.</li>
<li><strong>დაფარვა:</strong> დიდი ბინისა თუ კერძო სახლისთვის აირჩიეთ Mesh სისტემა — რამდენიმე მოდული მთელ სახლს ერთი, უწყვეტი ქსელით ფარავს.</li>
<li><strong>ინტერნეტის ტიპი:</strong> თუ ოპტიკური ან სადენიანი ინტერნეტი არ გაქვთ, 4G/5G როუტერი SIM-ბარათით მუშაობს — კარგია აგარაკისა და დროებითი ოფისისთვის.</li>
<li><strong>პორტები:</strong> გიგაბიტიანი პორტები სწრაფი ინტერნეტისთვის აუცილებელია; სათამაშო როუტერებს ხშირად 2.5 Gbps პორტი და თამაშის ტრაფიკის პრიორიტეტი აქვს.</li>
<li><strong>სიხშირის ზოლები:</strong> ორზოლიანი (2.4 და 5 GHz) როუტერი სტანდარტია, სამზოლიანი (Tri-Band) კი უკეთ უმკლავდება ბევრ მოწყობილობას ერთდროულად.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/saopise-da-qseluri-motskobilobebi/">საოფისე და ქსელური მოწყობილობები</a>, <a href="https://superi.ge/noutbuqebi/">ნოუთბუქები</a> და <a href="https://superi.ge/kompiuteris-aqsesuarebi/">კომპიუტერის აქსესუარები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'kompresorebi' SET cd.description = '<p>ჰაერის კომპრესორი შეუცვლელია ავტოსერვისში, სახელოსნოსა და მშენებლობაზე — საბურავების გასაბერად, პნევმოინსტრუმენტებისა და საღებავის პულვერიზატორისთვის. Superi.ge-ზე იპოვით <a href="https://superi.ge/remeza/">Remeza</a>-ს დგუშიან კომპრესორებს, ასევე <a href="https://superi.ge/ingco/">Ingco</a>-ს, <a href="https://superi.ge/schpindel/">Schpindel</a>-ის, <a href="https://superi.ge/wokin/">Wokin</a>-ის, <a href="https://superi.ge/dingqi/">Dingqi</a>-ს, <a href="https://superi.ge/hecht/">Hecht</a>-ისა და <a href="https://superi.ge/ronix/">Ronix</a>-ის მოდელებს 24-დან 500 ლიტრამდე რესივერით და კომპრესორის მილებს.</p>
<h2>როგორ შევარჩიოთ კომპრესორი</h2>
<ul>
<li><strong>წარმადობა (ლ/წთ):</strong> კომპრესორის წარმადობა დაახლოებით 20–30%-ით უნდა აღემატებოდეს ინსტრუმენტის მიერ მოთხოვნილ ჰაერის ხარჯს.</li>
<li><strong>რესივერის მოცულობა:</strong> 24–50 ლიტრი საკმარისია საყოფაცხოვრებო სამუშაოებისა და საბურავების გაბერვისთვის; ავტოსერვისისა და პნევმოინსტრუმენტების ხანგრძლივი მუშაობისთვის აირჩიეთ 100–500 ლიტრი.</li>
<li><strong>ზეთიანი თუ უზეთო:</strong> ზეთიანი დგუშიანი კომპრესორი უფრო გამძლეა და ხანგრძლივ დატვირთვას უძლებს; უზეთო მოდელი მსუბუქია, ზეთის შეცვლა არ სჭირდება და ჰაერს ზეთის ნაწილაკების გარეშე იძლევა.</li>
<li><strong>კვება:</strong> ზოგ მძლავრ მოდელს სამფაზა (380 V) კვება სჭირდება — ყიდვამდე შეამოწმეთ, რა ქსელი გაქვთ.</li>
<li><strong>წნევა:</strong> საყოფაცხოვრებო და ნახევრად პროფესიული მოდელების უმეტესობა 8–10 ბარამდე მუშაობს, რაც პნევმოინსტრუმენტების უმეტესობისთვის საკმარისია.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/khelis-instrumentebi/">ხელის ინსტრუმენტები</a>, <a href="https://superi.ge/samsheneblo-khelsatskoebi/">სამშენებლო ხელსაწყოები</a>, <a href="https://superi.ge/tsnevit-saretskhi-aparatebi/">წნევით სარეცხი აპარატები</a> და <a href="https://superi.ge/avtosamkaro/">ავტოსამყარო</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'trenazhorebi' SET cd.description = '<p>სახლის ტრენაჟორით ნებისმიერ ამინდსა და დროს ივარჯიშებთ, დარბაზში სიარულის გარეშე. Superi.ge-ზე იპოვით სარბენ ბილიკებს, Walking Pad-ებს, ველოტრენაჟორებსა და ელიფსურ ტრენაჟორებს ბრენდებისგან: <a href="https://superi.ge/nordictrack/">NordicTrack</a>, <a href="https://superi.ge/pro-form/">ProForm</a>, <a href="https://superi.ge/kingsmith/">Kingsmith</a>, <a href="https://superi.ge/urevo/">UREVO</a>, <a href="https://superi.ge/kettler/">Kettler</a> და <a href="https://superi.ge/toorx/">Toorx</a>.</p>
<h2>რომელი ტრენაჟორი ავირჩიოთ</h2>
<ul>
<li><strong>სარბენი ბილიკი:</strong> სიარულისა და სირბილისთვის, წონის კლებისა და გამძლეობის გასაზრდელად. დეტალურად: <a href="https://superi.ge/rogor-shevarchiot-sarbeni-biliki/">როგორ შევარჩიოთ სარბენი ბილიკი</a>.</li>
<li><strong>Walking Pad:</strong> კომპაქტური ბილიკი სიარულისთვის — სამუშაო მაგიდასთან ან ტელევიზორის ყურებისას, მარტივად ინახება.</li>
<li><strong>ველოტრენაჟორი:</strong> სახსრებისთვის დაზოგვითი კარდიო ვარჯიში; ჰორიზონტალური (Recumbent) მოდელი ზურგს ნაკლებად ტვირთავს.</li>
<li><strong>ელიფსური ტრენაჟორი:</strong> ერთდროულად ავარჯიშებს ხელებსა და ფეხებს, სახსრებზე კი დატვირთვა მინიმალურია.</li>
</ul>
<h2>რას მივაქციოთ ყურადღება</h2>
<ul>
<li><strong>მაქსიმალური დატვირთვა:</strong> აირჩიეთ მოდელი, რომლის მაქსიმალური დატვირთვა თქვენს წონას 15–20 კგ-ით აღემატება.</li>
<li><strong>ადგილი:</strong> გაზომეთ ოთახი; მცირე ბინისთვის აირჩიეთ დასაკეცი მოდელი.</li>
<li><strong>ფუნქციები:</strong> დისპლეი, პულსის სენსორი, ვარჯიშის პროგრამები და აპლიკაციის მხარდაჭერა მოტივაციას ზრდის.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/sarbeni-bilikebi/">სარბენი ბილიკები</a>, <a href="https://superi.ge/velosipedebi/">ველოსიპედები</a> და <a href="https://superi.ge/sporti/">სპორტი და დასვენება</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'miqserebi' SET cd.description = '<p>მიქსერი ცომის მოზელის, კრემის ათქვეფისა და ნამცხვრის მომზადების შეუცვლელი დამხმარეა. Superi.ge-ზე იპოვით ხელის და სტაციონარულ (პლანეტარულ) მიქსერებს ბრენდებისგან: <a href="https://superi.ge/bosch/">Bosch</a>, <a href="https://superi.ge/kenwood/">Kenwood</a>, <a href="https://superi.ge/smeg/">Smeg</a>, <a href="https://superi.ge/beko/">Beko</a>, <a href="https://superi.ge/braun/">Braun</a>, <a href="https://superi.ge/gorenje/">Gorenje</a> და <a href="https://superi.ge/midea/">Midea</a>.</p>
<h2>როგორ შევარჩიოთ მიქსერი</h2>
<ul>
<li><strong>ხელის თუ სტაციონარული:</strong> ხელის მიქსერი კომპაქტური და ხელმისაწვდომია, კარგია კრემისა და თხელი ცომისთვის; სტაციონარული (პლანეტარული) მიქსერი თასით ხელის გარეშე მუშაობს და მძიმე, საფუვრიან ცომსაც უმკლავდება.</li>
<li><strong>სიმძლავრე:</strong> ხელის მიქსერისთვის 350–500 W საკმარისია, სტაციონარულისთვის — 700 W და მეტი.</li>
<li><strong>თასის მოცულობა:</strong> 3–4 ლიტრი პატარა ოჯახისთვისაა, 5–7 ლიტრი — ხშირი ცხობისა და დიდი პორციებისთვის.</li>
<li><strong>საქშენები:</strong> სათქვეფი, ცომის საზელი კაუჭები და დამატებითი აქსესუარები (ხორცსაკეპი, ბლენდერი) მიქსერს მინი-კომბაინად აქცევს.</li>
<li><strong>სიჩქარეები:</strong> რამდენიმე სიჩქარე და Turbo რეჟიმი სხვადასხვა რეცეპტისთვის მოქნილობას იძლევა.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/blenderebi/">ბლენდერები</a>, <a href="https://superi.ge/samzareulos-kombainebi/">სამზარეულოს კომბაინები</a> და <a href="https://superi.ge/xorcis-sakepi-manqanebi/">ხორცსაკეპი მანქანები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'dispenserebi' SET cd.description = '<p>წყლის დისპენსერი სახლსა და ოფისში ყოველთვის გაძლევთ ცივ და ცხელ წყალს — ჩაისა და ყავისთვის ჩაიდნის ადუღება აღარ დაგჭირდებათ. Superi.ge-ზე იპოვით დისპენსერებს ბრენდებისგან: <a href="https://superi.ge/midea/">Midea</a>, <a href="https://superi.ge/bosch/">Bosch</a>, <a href="https://superi.ge/beko/">Beko</a>, <a href="https://superi.ge/sharp/">Sharp</a>, <a href="https://superi.ge/toshiba/">Toshiba</a>, <a href="https://superi.ge/millen/">Millen</a>, <a href="https://superi.ge/dixi/">Dixi</a> და <a href="https://superi.ge/alneo/">Alneo</a>.</p>
<h2>როგორ შევარჩიოთ წყლის დისპენსერი</h2>
<ul>
<li><strong>ბოთლის მდებარეობა:</strong> ზედა ჩატვირთვისას ბოთლი დისპენსერზე თავდაყირა იდგმება; ქვედა ჩატვირთვის (დამალული ავზის) მოდელში ბოთლი კორპუსში იმალება — მძიმე ბოთლის აწევა აღარ გიწევთ და უფრო ლამაზადაც გამოიყურება.</li>
<li><strong>გაცივების ტიპი:</strong> კომპრესორული გაცივება წყალს უფრო სწრაფად და მეტად აცივებს, ელექტრონული კი ჩუმი და ხელმისაწვდომია.</li>
<li><strong>მაცივრის კამერა:</strong> ზოგ მოდელს ქვემოთ პატარა მაცივარი აქვს — მოსახერხებელია ოფისისთვის.</li>
<li><strong>ბავშვისგან დაცვა:</strong> ცხელი წყლის ონკანის დაბლოკვა აუცილებელია, თუ სახლში ბავშვები არიან.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/eleqtro-chaidnebi/">ელექტრო ჩაიდნები</a>, <a href="https://superi.ge/yavis-aparatebi/">ყავის აპარატები</a> და <a href="https://superi.ge/macivrebi/">მაცივრები</a>.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'sporti' SET cd.description = '<p>სპორტი და დასვენება ჯანსაღი ცხოვრების წესის ნაწილია — ყოველდღიური აქტივობიდან ოჯახურ გართობამდე. ამ კატეგორიაში იპოვით <a href="https://superi.ge/velosipedebi/">ველოსიპედებს</a>, <a href="https://superi.ge/hoverbordebi/">ჰოვერბორდებს</a>, <a href="https://superi.ge/batutebi/">ბატუტებს</a> და <a href="https://superi.ge/mogzauroba/">მოგზაურობის აქსესუარებს</a>, ხოლო სახლში სავარჯიშოდ — <a href="https://superi.ge/trenazhorebi/">ტრენაჟორებს</a> და <a href="https://superi.ge/sarbeni-bilikebi/">სარბენ ბილიკებს</a>.</p>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში.</p>' WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300;
SELECT s.name AS slug, CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) AS text_chars FROM cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE cd.lang_code = 'ka' AND s.name IN ('blenderebi', 'xelis-traqtorebi', 'statsionaluri-teleponebi', 'qvabebisa-da-tapebis-nakrebebi', 'xorcis-sakepi-manqanebi', 'routers', 'kompresorebi', 'trenazhorebi', 'miqserebi', 'dispenserebi', 'sporti') ORDER BY s.name;
-- დაბრუნება: UPDATE cscart_category_descriptions cd JOIN superi_bk_cat_25 b ON b.category_id = cd.category_id AND b.lang_code = cd.lang_code SET cd.description = b.description;
