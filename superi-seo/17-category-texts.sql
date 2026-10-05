-- ============================================================================
-- superi.ge — კატეგორიების ტექსტები (იმ კატეგორიებისთვის, რომლებიც Google-ის პირველ გვერდთან ახლოსაა)
-- სარბენი ბილიკები, აუზები, გაზის გამათბობლები, მიკროტალღური ღუმელები, ჰამაკები და საქანელები,
-- ჰაერის გამწმენდი და დამატენიანებლები, ნესტის შემწოვები + Smeg-ის ბრენდის გვერდი.
-- ტექსტი იწერება მხოლოდ იქ, სადაც აღწერა ცარიელია — არსებულ ტექსტს არ ეხება.
-- სახელის შეცვლა: „ტენის ამომშრობები“ -> „ნესტის შემწოვი აპარატები“ (ასე ეძებენ Google-ში),
--                   „ჰამაკები & საქანელები“ -> „ჰამაკები და საქანელები“. URL-ები არ იცვლება.
-- Smeg-ის სათაური: „Smeg საქართველოში — საუკეთესო ფასები | Superi.ge“ (ძიება „smeg georgia“).
-- ასლები: superi_bk_cat_17, superi_bk_brand_17. დაბრუნება ბოლოშია.
-- ============================================================================
SET NAMES utf8mb4;
SET @et := (SELECT s.type FROM cscart_seo_names s JOIN cscart_product_feature_variant_descriptions vd ON vd.variant_id = s.object_id AND vd.lang_code = 'ka' WHERE s.name = 'samsung' AND s.lang_code = 'ka' AND vd.variant = 'SAMSUNG' LIMIT 1);
CREATE TABLE IF NOT EXISTS superi_bk_cat_17 AS SELECT cd.category_id, cd.lang_code, cd.category, cd.description, cd.page_title, cd.meta_description FROM cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE cd.lang_code = 'ka' AND s.name IN ('sarbeni-bilikebi', 'auzebi', 'gazis-gamatboblebi', 'mikrotalghuri-ghumelebi', 'hamakebi-da-saqanelebi', 'haeris-gamtsmendi-da-damatenianeblebi', 'tenis-amomshrobebi');
CREATE TABLE IF NOT EXISTS superi_bk_brand_17 AS SELECT vd.variant_id, vd.lang_code, vd.description, vd.page_title FROM cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' WHERE vd.lang_code = 'ka' AND s.name = 'smeg';

-- 1) ტექსტები (მხოლოდ ცარიელ აღწერებში)
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'sarbeni-bilikebi' SET cd.description = '<p>სარბენი ბილიკი სახლში ვარჯიშის ყველაზე მოსახერხებელი საშუალებაა — ამინდისა და დროის მიუხედავად. Superi.ge-ზე იპოვით კომპაქტურ, დასაკეც Walking Pad-ებს სასიარულოდ და სრულფასოვან სარბენ ბილიკებს სირბილისთვის: UREVO, Kingsmith, Xiaomi და სხვა ბრენდების მოდელებს.</p>
<h2>როგორ შევარჩიოთ სარბენი ბილიკი</h2>
<ul>
<li><strong>დანიშნულება:</strong> მხოლოდ სიარულისთვის საკმარისია Walking Pad 6 კმ/სთ-მდე სიჩქარით; სირბილისთვის აირჩიეთ მოდელი 12 კმ/სთ და მეტი მაქსიმალური სიჩქარით.</li>
<li><strong>მაქსიმალური დატვირთვა:</strong> უმჯობესია, ბილიკის ზღვარი თქვენს წონას 15–20 კგ-ით აღემატებოდეს — ასე ძრავა ნაკლებად იტვირთება და დიდხანს ძლებს.</li>
<li><strong>სარბენი ზედაპირი:</strong> სირბილისთვის სასურველია ფართო და გრძელი ლენტი, სიარულისთვის კომპაქტური ზომაც საკმარისია.</li>
<li><strong>დახრა:</strong> დახრის ფუნქცია ვარჯიშს ართულებს და იმავე სიჩქარეზე მეტ კალორიას წვავს.</li>
<li><strong>შენახვა:</strong> თუ ადგილი ცოტაა, აირჩიეთ დასაკეცი მოდელი, რომელიც ვარჯიშის შემდეგ მარტივად ინახება.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. სახლის სპორტული კუთხისთვის იხილეთ ასევე <a href="https://superi.ge/trenazhorebi/">ტრენაჟორები</a>.</p>' WHERE cd.lang_code = 'ka' AND TRIM(REGEXP_REPLACE(IFNULL(cd.description,''), '<[^>]*>|&nbsp;|[[:space:]]', '')) = '';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'auzebi' SET cd.description = '<p>აუზი ზაფხულის საუკეთესო გამოსავალია საკუთარ ეზოში. Superi.ge-ზე წარმოდგენილია Bestway-ისა და Intex-ის კარკასული და გასაბერი აუზები სხვადასხვა ზომით, ასევე მინი აკვაპარკები, გასაბერი ლეიბები და აქსესუარები.</p>
<h2>როგორ შევარჩიოთ აუზი</h2>
<ul>
<li><strong>ტიპი:</strong> გასაბერი აუზი სწრაფად იდგმება და მარტივად ინახება; კარკასული, მათ შორის ფოლადის კარკასით, უფრო მყარია და დიდი ზომებისთვის უკეთესი არჩევანია.</li>
<li><strong>ზომა და მოცულობა:</strong> შეარჩიეთ ეზოს ფართისა და მოცურავეების რაოდენობის მიხედვით — მოცულობა ლიტრებში თითოეული აუზის აღწერაშია მითითებული.</li>
<li><strong>ფილტრი-ტუმბო:</strong> წყლის სისუფთავისთვის მნიშვნელოვანია; შეამოწმეთ, შედის თუ არა კომპლექტში.</li>
<li><strong>აქსესუარები:</strong> კიბე, საფარი (ტენტი) და საფენი აუზის ქვეშ აადვილებს მოვლას და ახანგრძლივებს აუზის სიცოცხლეს.</li>
<li><strong>ადგილი:</strong> აუზი დადგით სწორ, მყარ ზედაპირზე, ბასრი საგნებისგან გასუფთავებულ ადგილას.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. ეზოს მოსაწყობად იხილეთ <a href="https://superi.ge/bagis-aveji/">ბაღის ავეჯი</a> და <a href="https://superi.ge/hamakebi-da-saqanelebi/">ჰამაკები და საქანელები</a>.</p>' WHERE cd.lang_code = 'ka' AND TRIM(REGEXP_REPLACE(IFNULL(cd.description,''), '<[^>]*>|&nbsp;|[[:space:]]', '')) = '';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'gazis-gamatboblebi' SET cd.description = '<p>გაზის გამათბობელი ბუნებრივი აირით სწრაფად და ეკონომიურად ათბობს ოთახს. Superi.ge-ზე იპოვით Gilan-ის, Fujiyama-ს, Hosseven-ის, Ersel-ისა და AKOG-ის გამათბობლებს 40-დან 120 მ²-მდე ფართისთვის.</p>
<h2>როგორ შევარჩიოთ გაზის გამათბობელი</h2>
<ul>
<li><strong>ფართი:</strong> თითოეული მოდელის სახელში მითითებულია ფართი, რომლის გათბობაც შეუძლია — მაგალითად, 60, 80 ან 120 კვადრატული მეტრი. აირჩიეთ მცირე მარაგით, განსაკუთრებით მაღალჭერიანი ან ცუდად დათბუნებული სივრცისთვის.</li>
<li><strong>სიმძლავრე:</strong> საორიენტაციოდ, სტანდარტული სიმაღლის ოთახის ყოველ 10 მ²-ზე დაახლოებით 1 კვტ სიმძლავრეა საჭირო.</li>
<li><strong>უსაფრთხოება:</strong> უპირატესობა მიანიჭეთ გაზის კონტროლის მქონე მოდელებს — ალის ჩაქრობისას ის გაზის მიწოდებას ავტომატურად წყვეტს.</li>
<li><strong>თერმოსტატი:</strong> ინარჩუნებს სასურველ ტემპერატურას და ზოგავს გაზს.</li>
<li><strong>მონტაჟი:</strong> გაზის მოწყობილობის მონტაჟი და მიერთება ანდეთ სერტიფიცირებულ სპეციალისტს.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. გათბობის სხვა გადაწყვეტილებებისთვის იხილეთ <a href="https://superi.ge/eleqtro-gamatboblebi/">ელექტრო გამათბობლები</a>, <a href="https://superi.ge/tsentraluri-gatbobis-qvabi/">ცენტრალური გათბობის ქვაბები</a> და <a href="https://superi.ge/kondicionerebi/">კონდიციონერები</a>.</p>' WHERE cd.lang_code = 'ka' AND TRIM(REGEXP_REPLACE(IFNULL(cd.description,''), '<[^>]*>|&nbsp;|[[:space:]]', '')) = '';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'mikrotalghuri-ghumelebi' SET cd.description = '<p>მიკროტალღური ღუმელი საჭმლის გაცხელების, გალღობისა და სწრაფი მომზადების ყოველდღიური დამხმარეა. Superi.ge-ზე იპოვით Gorenje-ს, Midea-ს, Samsung-ის, Beko-სა და Bosch-ის ცალკე მდგომ და ჩასაშენებელ მოდელებს.</p>
<h2>როგორ შევარჩიოთ მიკროტალღური ღუმელი</h2>
<ul>
<li><strong>მოცულობა:</strong> 1–2 ადამიანისთვის საკმარისია 17–20 ლიტრი, ოჯახისთვის — 23–25 ლიტრი, დიდი კერძებისა და ცხობისთვის — 28 ლიტრი და მეტი.</li>
<li><strong>ტიპი:</strong> სოლო მოდელი აცხელებს და ალღობს; გრილიანით შემწვარ ქერქსაც მიიღებთ; კონვექციური კი ჩვეულებრივი ღუმელივით აცხობს.</li>
<li><strong>ჩასაშენებელი თუ ცალკე მდგომი:</strong> ჩასაშენებელი მოდელი სამზარეულოს კარადაში ჯდება და სამუშაო ზედაპირს ათავისუფლებს.</li>
<li><strong>მართვა:</strong> მექანიკური სახელურები მარტივია, ელექტრონული მართვა კი ავტომატური პროგრამებითა და ტაიმერით უფრო ზუსტია.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. სამზარეულოსთვის იხილეთ ასევე <a href="https://superi.ge/chasashenebeli-ghumelebi/">ჩასაშენებელი ღუმელები</a> და <a href="https://superi.ge/samzarelos-teqnika/">სამზარეულოს ტექნიკა</a>.</p>' WHERE cd.lang_code = 'ka' AND TRIM(REGEXP_REPLACE(IFNULL(cd.description,''), '<[^>]*>|&nbsp;|[[:space:]]', '')) = '';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'hamakebi-da-saqanelebi' SET cd.description = '<p>ეზოში ან აივანზე დასასვენებლად ჰამაკი ან ბაღის საქანელა საუკეთესო არჩევანია. Superi.ge-ზე იპოვით ორადგილიან ჰამაკებს, ჰამაკ-სავარძლებს, „ბუდე“ საქანელებს და მრავალადგილიან ბაღის საქანელებს.</p>
<h2>როგორ შევარჩიოთ ჰამაკი ან საქანელა</h2>
<ul>
<li><strong>ტიპი:</strong> ჰამაკ-სავარძელი და „ბუდე“ საქანელა ერთი ადამიანისთვის ან ბავშვისთვისაა, ბაღის საქანელაზე კი ერთად რამდენიმე ადამიანი ეტევა.</li>
<li><strong>მაქსიმალური დატვირთვა:</strong> ყურადღება მიაქციეთ მითითებულ ზღვარს, განსაკუთრებით მრავალადგილიან მოდელებზე.</li>
<li><strong>კარკასი:</strong> თუ ეზოში შესაფერისი ხეები არ გაქვთ, აირჩიეთ საკუთარი კარკასის მქონე მოდელი.</li>
<li><strong>მასალა:</strong> მეტალის კარკასი და გარე პირობებისადმი გამძლე ქსოვილი უფრო დიდხანს ძლებს; ჩრდილისთვის მოსახერხებელია ტენტიანი საქანელა.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. ეზოს მოსაწყობად იხილეთ <a href="https://superi.ge/bagis-aveji/">ბაღის ავეჯი</a> და <a href="https://superi.ge/auzebi/">აუზები</a>.</p>' WHERE cd.lang_code = 'ka' AND TRIM(REGEXP_REPLACE(IFNULL(cd.description,''), '<[^>]*>|&nbsp;|[[:space:]]', '')) = '';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'haeris-gamtsmendi-da-damatenianeblebi' SET cd.description = '<p>სუფთა და სათანადოდ დატენიანებული ჰაერი სახლში კომფორტისა და ჯანმრთელობისთვის მნიშვნელოვანია. Superi.ge-ზე იპოვით Beko-ს, Dreame-ს, Shark-ის, Rowenta-სა და Gorenje-ს ჰაერის გამწმენდებსა და დამატენიანებლებს.</p>
<h2>ჰაერის გამწმენდი: რას მივაქციოთ ყურადღება</h2>
<ul>
<li><strong>ოთახის ფართი:</strong> აირჩიეთ მოდელი, რომელიც თქვენი ოთახის ფართისთვისაა გათვლილი.</li>
<li><strong>ფილტრი:</strong> HEPA ფილტრი იჭერს მტვერს, ყვავილის მტვერს და სხვა წვრილ ნაწილაკებს, ნახშირის ფილტრი კი სუნს ამცირებს.</li>
<li><strong>ხმაური:</strong> საძინებლისთვის აირჩიეთ ჩუმი მოდელი ღამის რეჟიმით.</li>
</ul>
<h2>ჰაერის დამატენიანებელი: რას მივაქციოთ ყურადღება</h2>
<ul>
<li><strong>ტიპი:</strong> აორთქლებადი (Evaporative) დამატენიანებელი ავეჯზე თეთრ ნადებს არ ტოვებს.</li>
<li><strong>ავზის მოცულობა:</strong> დიდი ავზი იშვიათად საჭიროებს შევსებას, განსაკუთრებით ღამით.</li>
<li><strong>ოპტიმალური ტენიანობა:</strong> საცხოვრებელში ჩვეულებრივ 40–60%-ია რეკომენდებული.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. ჭარბი ნესტის შემთხვევაში იხილეთ <a href="https://superi.ge/tenis-amomshrobebi/">ნესტის შემწოვი აპარატები</a>.</p>' WHERE cd.lang_code = 'ka' AND TRIM(REGEXP_REPLACE(IFNULL(cd.description,''), '<[^>]*>|&nbsp;|[[:space:]]', '')) = '';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'tenis-amomshrobebi' SET cd.description = '<p>ნესტის შემწოვი აპარატი (ტენის ამომშრობი, ნესტის გამწოვი) ჰაერიდან ჭარბ ტენს იღებს და ხელს უშლის ობის, სოკოსა და უსიამოვნო სუნის გაჩენას. ის განსაკუთრებით სასარგებლოა სარდაფში, პირველ სართულზე, სააბაზანოსა და ნესტიან ოთახებში. Superi.ge-ზე იპოვით Midea-სა და Sencor-ის მოდელებს.</p>
<h2>როგორ შევარჩიოთ ნესტის შემწოვი</h2>
<ul>
<li><strong>წარმადობა:</strong> მითითებულია ლიტრებში დღე-ღამეში — რაც უფრო დიდი და ნესტიანია სივრცე, მით მეტი წარმადობაა საჭირო.</li>
<li><strong>წყლის ავზი:</strong> დიდი ავზი იშვიათად იცლება; ზოგ მოდელზე წყლის უწყვეტი გადინების მილის მიერთებაც შეიძლება.</li>
<li><strong>ჰიგროსტატი:</strong> აპარატი თავად ინარჩუნებს არჩეულ ტენიანობას და ელექტროენერგიას ზოგავს.</li>
<li><strong>ხმაური და ზომა:</strong> საცხოვრებელი ოთახისთვის აირჩიეთ ჩუმი, კომპაქტური მოდელი.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე <a href="https://superi.ge/haeris-gamtsmendi-da-damatenianeblebi/">ჰაერის გამწმენდი და დამატენიანებლები</a>.</p>' WHERE cd.lang_code = 'ka' AND TRIM(REGEXP_REPLACE(IFNULL(cd.description,''), '<[^>]*>|&nbsp;|[[:space:]]', '')) = '';

-- 2) სახელები (სათაური და მეტა აღწერაც)
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'tenis-amomshrobebi' SET cd.page_title = REPLACE(cd.page_title, 'ტენის ამომშრობები', 'ნესტის შემწოვი აპარატები'), cd.meta_description = REPLACE(cd.meta_description, 'ტენის ამომშრობები', 'ნესტის შემწოვი აპარატები'), cd.category = 'ნესტის შემწოვი აპარატები' WHERE cd.lang_code = 'ka' AND cd.category = 'ტენის ამომშრობები';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'hamakebi-da-saqanelebi' SET cd.page_title = REPLACE(REPLACE(cd.page_title, 'ჰამაკები &amp; საქანელები', 'ჰამაკები და საქანელები'), 'ჰამაკები & საქანელები', 'ჰამაკები და საქანელები'), cd.meta_description = REPLACE(REPLACE(cd.meta_description, 'ჰამაკები &amp; საქანელები', 'ჰამაკები და საქანელები'), 'ჰამაკები & საქანელები', 'ჰამაკები და საქანელები'), cd.category = 'ჰამაკები და საქანელები' WHERE cd.lang_code = 'ka' AND cd.category IN ('ჰამაკები & საქანელები', 'ჰამაკები &amp; საქანელები');

-- 3) Smeg-ის ბრენდის გვერდი
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'smeg' SET vd.description = '<p>Smeg იტალიური ბრენდია, რომელიც 1948 წლიდან ქმნის საოჯახო ტექნიკას და განსაკუთრებით ცნობილია 50-იანი წლების სტილის რეტრო დიზაინით. Superi.ge-ზე იპოვით Smeg-ის ელექტრო ჩაიდნებს, ტოსტერებს, მიქსერებს, ბლენდერებს, ციტრუსის წვენსაწურებს და სხვა ტექნიკას სხვადასხვა ფერში — კრემისფერი, წითელი, შავი, თეთრი, ვარდისფერი, პასტელური ცისფერი და მწვანე.</p>
<h2>რატომ ირჩევენ Smeg-ს</h2>
<ul>
<li><strong>ერთიანი სტილი:</strong> ერთი ფერის ჩაიდანი, ტოსტერი და მიქსერი სამზარეულოში ერთიან კომპლექტს ქმნის.</li>
<li><strong>დიზაინი:</strong> 50''s Style ხაზის ტექნიკა სამზარეულოს დეკორის ნაწილი ხდება.</li>
<li><strong>ფერის არჩევანი:</strong> ერთი და იგივე მოდელი რამდენიმე ფერშია ხელმისაწვდომი — შეარჩიეთ თქვენი ინტერიერის მიხედვით.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. იხილეთ ასევე ყველა <a href="https://superi.ge/eleqtro-chaidnebi/">ელექტრო ჩაიდანი</a> და <a href="https://superi.ge/miqserebi/">მიქსერი</a>.</p>' WHERE vd.lang_code = 'ka' AND TRIM(REGEXP_REPLACE(IFNULL(vd.description,''), '<[^>]*>|&nbsp;|[[:space:]]', '')) = '';
UPDATE cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'smeg' SET vd.page_title = 'Smeg საქართველოში — საუკეთესო ფასები | Superi.ge' WHERE vd.lang_code = 'ka' AND vd.page_title IN ('SMEG — საუკეთესო ფასები | Superi.ge', 'Smeg — საუკეთესო ფასები | Superi.ge', '');

-- 4) შედეგი
SELECT s.name, CHAR_LENGTH(cd.description) AS text_chars, cd.category FROM cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE cd.lang_code = 'ka' AND s.name IN ('sarbeni-bilikebi', 'auzebi', 'gazis-gamatboblebi', 'mikrotalghuri-ghumelebi', 'hamakebi-da-saqanelebi', 'haeris-gamtsmendi-da-damatenianeblebi', 'tenis-amomshrobebi') UNION ALL SELECT 'smeg', CHAR_LENGTH(vd.description), vd.page_title FROM cscart_product_feature_variant_descriptions vd JOIN cscart_seo_names s ON s.object_id = vd.variant_id AND s.type = @et AND s.lang_code = 'ka' AND s.name = 'smeg' WHERE vd.lang_code = 'ka';

-- დაბრუნება (კომენტარია):
-- UPDATE cscart_category_descriptions cd JOIN superi_bk_cat_17 b ON b.category_id = cd.category_id AND b.lang_code = cd.lang_code SET cd.category = b.category, cd.description = b.description, cd.page_title = b.page_title, cd.meta_description = b.meta_description;
-- UPDATE cscart_product_feature_variant_descriptions vd JOIN superi_bk_brand_17 b ON b.variant_id = vd.variant_id AND b.lang_code = vd.lang_code SET vd.description = b.description, vd.page_title = b.page_title;
