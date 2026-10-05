-- ============================================================================
-- superi.ge — 5 კატეგორიას მოკლე სარეკლამო წინადადება აქვს (68–120 სიმბოლო). მას ვტოვებთ და
-- ქვემოთ ვამატებთ შერჩევის გზამკვლევს: აუზები, გაზის გამათბობლები, მიკროტალღური ღუმელები,
-- ჰამაკები და საქანელები, ჰაერის გამწმენდი და დამატენიანებლები.
-- სარბენ ბილიკებს და ნესტის შემწოვებს უკვე აქვთ გრძელი ტექსტი — მათ არ ვეხებით.
-- უსაფრთხოება: მხოლოდ თუ არსებული ტექსტი მოკლეა (300 სიმბოლომდე) და გზამკვლევი ჯერ არ არის დამატებული.
-- ძველი ტექსტები უკვე ინახება superi_bk_cat_17-ში (დაბრუნება ბოლოშია).
-- ============================================================================
SET NAMES utf8mb4;
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'auzebi' SET cd.description = CONCAT(IFNULL(cd.description, ''), '\n', '<p>აუზი ზაფხულის საუკეთესო გამოსავალია საკუთარ ეზოში. Superi.ge-ზე წარმოდგენილია Bestway-ისა და Intex-ის კარკასული და გასაბერი აუზები სხვადასხვა ზომით, ასევე მინი აკვაპარკები, გასაბერი ლეიბები და აქსესუარები.</p>
<h2>როგორ შევარჩიოთ აუზი</h2>
<ul>
<li><strong>ტიპი:</strong> გასაბერი აუზი სწრაფად იდგმება და მარტივად ინახება; კარკასული, მათ შორის ფოლადის კარკასით, უფრო მყარია და დიდი ზომებისთვის უკეთესი არჩევანია.</li>
<li><strong>ზომა და მოცულობა:</strong> შეარჩიეთ ეზოს ფართისა და მოცურავეების რაოდენობის მიხედვით — მოცულობა ლიტრებში თითოეული აუზის აღწერაშია მითითებული.</li>
<li><strong>ფილტრი-ტუმბო:</strong> წყლის სისუფთავისთვის მნიშვნელოვანია; შეამოწმეთ, შედის თუ არა კომპლექტში.</li>
<li><strong>აქსესუარები:</strong> კიბე, საფარი (ტენტი) და საფენი აუზის ქვეშ აადვილებს მოვლას და ახანგრძლივებს აუზის სიცოცხლეს.</li>
<li><strong>ადგილი:</strong> აუზი დადგით სწორ, მყარ ზედაპირზე, ბასრი საგნებისგან გასუფთავებულ ადგილას.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. ეზოს მოსაწყობად იხილეთ <a href="https://superi.ge/bagis-aveji/">ბაღის ავეჯი</a> და <a href="https://superi.ge/hamakebi-da-saqanelebi/">ჰამაკები და საქანელები</a>.</p>') WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300 AND IFNULL(cd.description, '') NOT LIKE '%შევარჩიოთ%' AND IFNULL(cd.description, '') NOT LIKE '%რას მივაქციოთ ყურადღება%';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'gazis-gamatboblebi' SET cd.description = CONCAT(IFNULL(cd.description, ''), '\n', '<p>გაზის გამათბობელი ბუნებრივი აირით სწრაფად და ეკონომიურად ათბობს ოთახს. Superi.ge-ზე იპოვით Gilan-ის, Fujiyama-ს, Hosseven-ის, Ersel-ისა და AKOG-ის გამათბობლებს 40-დან 120 მ²-მდე ფართისთვის.</p>
<h2>როგორ შევარჩიოთ გაზის გამათბობელი</h2>
<ul>
<li><strong>ფართი:</strong> თითოეული მოდელის სახელში მითითებულია ფართი, რომლის გათბობაც შეუძლია — მაგალითად, 60, 80 ან 120 კვადრატული მეტრი. აირჩიეთ მცირე მარაგით, განსაკუთრებით მაღალჭერიანი ან ცუდად დათბუნებული სივრცისთვის.</li>
<li><strong>სიმძლავრე:</strong> საორიენტაციოდ, სტანდარტული სიმაღლის ოთახის ყოველ 10 მ²-ზე დაახლოებით 1 კვტ სიმძლავრეა საჭირო.</li>
<li><strong>უსაფრთხოება:</strong> უპირატესობა მიანიჭეთ გაზის კონტროლის მქონე მოდელებს — ალის ჩაქრობისას ის გაზის მიწოდებას ავტომატურად წყვეტს.</li>
<li><strong>თერმოსტატი:</strong> ინარჩუნებს სასურველ ტემპერატურას და ზოგავს გაზს.</li>
<li><strong>მონტაჟი:</strong> გაზის მოწყობილობის მონტაჟი და მიერთება ანდეთ სერტიფიცირებულ სპეციალისტს.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. გათბობის სხვა გადაწყვეტილებებისთვის იხილეთ <a href="https://superi.ge/eleqtro-gamatboblebi/">ელექტრო გამათბობლები</a>, <a href="https://superi.ge/tsentraluri-gatbobis-qvabi/">ცენტრალური გათბობის ქვაბები</a> და <a href="https://superi.ge/kondicionerebi/">კონდიციონერები</a>.</p>') WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300 AND IFNULL(cd.description, '') NOT LIKE '%შევარჩიოთ%' AND IFNULL(cd.description, '') NOT LIKE '%რას მივაქციოთ ყურადღება%';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'mikrotalghuri-ghumelebi' SET cd.description = CONCAT(IFNULL(cd.description, ''), '\n', '<p>მიკროტალღური ღუმელი საჭმლის გაცხელების, გალღობისა და სწრაფი მომზადების ყოველდღიური დამხმარეა. Superi.ge-ზე იპოვით Gorenje-ს, Midea-ს, Samsung-ის, Beko-სა და Bosch-ის ცალკე მდგომ და ჩასაშენებელ მოდელებს.</p>
<h2>როგორ შევარჩიოთ მიკროტალღური ღუმელი</h2>
<ul>
<li><strong>მოცულობა:</strong> 1–2 ადამიანისთვის საკმარისია 17–20 ლიტრი, ოჯახისთვის — 23–25 ლიტრი, დიდი კერძებისა და ცხობისთვის — 28 ლიტრი და მეტი.</li>
<li><strong>ტიპი:</strong> სოლო მოდელი აცხელებს და ალღობს; გრილიანით შემწვარ ქერქსაც მიიღებთ; კონვექციური კი ჩვეულებრივი ღუმელივით აცხობს.</li>
<li><strong>ჩასაშენებელი თუ ცალკე მდგომი:</strong> ჩასაშენებელი მოდელი სამზარეულოს კარადაში ჯდება და სამუშაო ზედაპირს ათავისუფლებს.</li>
<li><strong>მართვა:</strong> მექანიკური სახელურები მარტივია, ელექტრონული მართვა კი ავტომატური პროგრამებითა და ტაიმერით უფრო ზუსტია.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. სამზარეულოსთვის იხილეთ ასევე <a href="https://superi.ge/chasashenebeli-ghumelebi/">ჩასაშენებელი ღუმელები</a> და <a href="https://superi.ge/samzarelos-teqnika/">სამზარეულოს ტექნიკა</a>.</p>') WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300 AND IFNULL(cd.description, '') NOT LIKE '%შევარჩიოთ%' AND IFNULL(cd.description, '') NOT LIKE '%რას მივაქციოთ ყურადღება%';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'hamakebi-da-saqanelebi' SET cd.description = CONCAT(IFNULL(cd.description, ''), '\n', '<p>ეზოში ან აივანზე დასასვენებლად ჰამაკი ან ბაღის საქანელა საუკეთესო არჩევანია. Superi.ge-ზე იპოვით ორადგილიან ჰამაკებს, ჰამაკ-სავარძლებს, „ბუდე“ საქანელებს და მრავალადგილიან ბაღის საქანელებს.</p>
<h2>როგორ შევარჩიოთ ჰამაკი ან საქანელა</h2>
<ul>
<li><strong>ტიპი:</strong> ჰამაკ-სავარძელი და „ბუდე“ საქანელა ერთი ადამიანისთვის ან ბავშვისთვისაა, ბაღის საქანელაზე კი ერთად რამდენიმე ადამიანი ეტევა.</li>
<li><strong>მაქსიმალური დატვირთვა:</strong> ყურადღება მიაქციეთ მითითებულ ზღვარს, განსაკუთრებით მრავალადგილიან მოდელებზე.</li>
<li><strong>კარკასი:</strong> თუ ეზოში შესაფერისი ხეები არ გაქვთ, აირჩიეთ საკუთარი კარკასის მქონე მოდელი.</li>
<li><strong>მასალა:</strong> მეტალის კარკასი და გარე პირობებისადმი გამძლე ქსოვილი უფრო დიდხანს ძლებს; ჩრდილისთვის მოსახერხებელია ტენტიანი საქანელა.</li>
</ul>
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. ეზოს მოსაწყობად იხილეთ <a href="https://superi.ge/bagis-aveji/">ბაღის ავეჯი</a> და <a href="https://superi.ge/auzebi/">აუზები</a>.</p>') WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300 AND IFNULL(cd.description, '') NOT LIKE '%შევარჩიოთ%' AND IFNULL(cd.description, '') NOT LIKE '%რას მივაქციოთ ყურადღება%';
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'haeris-gamtsmendi-da-damatenianeblebi' SET cd.description = CONCAT(IFNULL(cd.description, ''), '\n', '<p>სუფთა და სათანადოდ დატენიანებული ჰაერი სახლში კომფორტისა და ჯანმრთელობისთვის მნიშვნელოვანია. Superi.ge-ზე იპოვით Beko-ს, Dreame-ს, Shark-ის, Rowenta-სა და Gorenje-ს ჰაერის გამწმენდებსა და დამატენიანებლებს.</p>
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
<p>შეძენა Superi.ge-ზე შეგიძლიათ ნაწილ-ნაწილ გადახდით; თბილისში მიწოდება უფასოა 100₾-დან, ასევე ვაწვდით მთელ საქართველოში. ჭარბი ნესტის შემთხვევაში იხილეთ <a href="https://superi.ge/tenis-amomshrobebi/">ნესტის შემწოვი აპარატები</a>.</p>') WHERE cd.lang_code = 'ka' AND CHAR_LENGTH(REGEXP_REPLACE(IFNULL(cd.description, ''), '<[^>]*>', '')) < 300 AND IFNULL(cd.description, '') NOT LIKE '%შევარჩიოთ%' AND IFNULL(cd.description, '') NOT LIKE '%რას მივაქციოთ ყურადღება%';

SELECT s.name, CHAR_LENGTH(cd.description) AS axali_len FROM cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE cd.lang_code = 'ka' AND s.name IN ('auzebi', 'gazis-gamatboblebi', 'mikrotalghuri-ghumelebi', 'hamakebi-da-saqanelebi', 'haeris-gamtsmendi-da-damatenianeblebi');

-- დაბრუნება (კომენტარია):
-- UPDATE cscart_category_descriptions cd JOIN superi_bk_cat_17 b ON b.category_id = cd.category_id AND b.lang_code = cd.lang_code SET cd.description = b.description;
