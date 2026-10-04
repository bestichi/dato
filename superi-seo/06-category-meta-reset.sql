-- ============================================================================
-- superi.ge — კატეგორიების ძველი, ზოგადი სათაურებისა და აღწერების გასუფთავება,
-- რომ SEO-შაბლონმა (Overlap გამორთული) ისინი შეავსოს. სათაური: 72, აღწერა: 92.
-- ხელუხლებელი რჩება: 15 სათაური და 20 აღწერა, რომლებიც კონკრეტულ საკვანძო სიტყვებს შეიცავს.
-- მისამართები (SEO name) არ იცვლება. ძველი მნიშვნელობები ფაილის ბოლოშია (დასაბრუნებლად).
-- ============================================================================

-- 1) სათაურები
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1
SET cd.page_title = '' WHERE cd.lang_code = 'ka' AND s.name IN (
  'aerogrilebi',
  'akumulatorebi',
  'all-in-one',
  'auzebi',
  'aveji',
  'avtosamkaro',
  'baghi-da-ezo',
  'chasashenebeli-ghumelebi',
  'chasashenebeli-saretskhi-manqanebi',
  'dispenserebi',
  'eleqtro-chaidnebi',
  'eleqtro-gamatboblebi',
  'fotoaparatebi',
  'gasaberi-aveji',
  'gazis-gamatboblebi',
  'haeris-gamtsmendi-da-damatenianeblebi',
  'hoverbordebi',
  'kartrijebi-saghebavebi-qaghaldi',
  'klimaturi-teqnika',
  'kondicionerebi',
  'konsolebi-da-aqsesuarebi',
  'kutkhsakhekhi',
  'macivrebi',
  'mikrotalghuri-ghumelebi',
  'miqserebi',
  'mobiluri-aqsesuarebi',
  'mobiluri-teleponebi',
  'monitor',
  'mtversasrutebi',
  'nadzvisxe',
  'portatuli-damtenebi',
  'printerebi',
  'proeqtoris-ekranebi',
  'quris-zedapiri',
  'qvabebisa-da-tapebis-nakrebebi',
  'saakhaltslo',
  'sabavshvo-produqtsia',
  'saburavebi',
  'sakeravi-teqnika',
  'sakhli-da-dekori',
  'sakinule',
  'sakopatskhovrebo-teqnika',
  'samsheneblo-khelsatskoebi',
  'samzarelos-teqnika',
  'samzareulos-aqsesuarebi',
  'samzareulos-danebi',
  'saopise-da-qseluri-motskobilobebi',
  'saretskhi-manqanebi',
  'sashrobebi',
  'satamashoebi',
  'smart-watches',
  'sporti',
  'statsionaluri-teleponebi',
  'tabletebi',
  'telefonebi-tabletebi',
  'televizorebi',
  'televizoris-aqsesuarebi',
  'teqnika',
  'tskhovelta-da-prinvelta-kveba',
  'tskhovelta-samkaro',
  'tsvrili-sakopatskhovrebo-teqnika',
  'tv',
  'uto',
  'velosipedebi',
  'ventilatorebi',
  'yursasmenebi',
  'gaming',
  'noutbuqebi-kompiuterebi-monitorebi',
  'proeqtorebi-da-aqsesuarebi',
  'saretskh-satsmendi-sashualebebi',
  'shesawamli-aparatebi',
  'tsentraluri-gatbobis-qvabi');

-- 2) აღწერები
UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' AND s.company_id = 1
SET cd.meta_description = '' WHERE cd.lang_code = 'ka' AND s.name IN (
  'aerogrilebi',
  'akumulatorebi',
  'all-in-one',
  'auzebi',
  'aveji',
  'avtosamkaro',
  'baghi-da-ezo',
  'bagis-aveji',
  'batutebi',
  'chasashenebeli-ghumelebi',
  'chasashenebeli-saretskhi-manqanebi',
  'choferebi',
  'churcheli',
  'dispenserebi',
  'droni',
  'eleqtro-chaidnebi',
  'eleqtro-gamatboblebi',
  'eleqtro-gumelebi',
  'eleqtro-manqanebi',
  'fotoaparatebi',
  'gaming',
  'gamtsovi',
  'gasaberi-aveji',
  'gazis-gamatboblebi',
  'generatorebi',
  'haeris-gamtsmendi-da-damatenianeblebi',
  'hamakebi-da-saqanelebi',
  'hoverbordebi',
  'kartrijebi-saghebavebi-qaghaldi',
  'khelis-instrumentebi',
  'klimaturi-teqnika',
  'kompiuteris-aqsesuarebi',
  'kompiuteris-natsilebi',
  'kompresorebi',
  'kondicionerebi',
  'konsolebi-da-aqsesuarebi',
  'kutkhsakhekhi',
  'magida-da-skamebi',
  'mikrotalghuri-ghumelebi',
  'miqserebi',
  'mobiluri-aqsesuarebi',
  'mogzauroba',
  'motherboard',
  'mtversasrutebi',
  'noutbuqebi-kompiuterebi-monitorebi',
  'noutbuqebi',
  'portatuli-damtenebi',
  'printerebi',
  'proeqtorebi-da-aqsesuarebi',
  'proeqtori',
  'proeqtoris-ekranebi',
  'quris-zedapiri',
  'qvabebisa-da-tapebis-nakrebebi',
  'sabavshvo-produqtsia',
  'saburavebi',
  'sakeravi-teqnika',
  'sakhli-da-dekori',
  'sakinule',
  'sakopatskhovrebo-teqnika',
  'samsheneblo-khelsatskoebi',
  'samzarelos-teqnika',
  'samzareulos-aqsesuarebi',
  'samzareulos-danebi',
  'samzareulos-kombainebi',
  'saopise-da-qseluri-motskobilobebi',
  'saretskh-satsmendi-sashualebebi',
  'saretskhi-manqanebi',
  'satamashoebi',
  'smart-watches',
  'sporti',
  'statsionaluri-teleponebi',
  'tabletebi',
  'telefonebi-tabletebi',
  'televizoris-aqsesuarebi',
  'teqnika',
  'teqstili',
  'tmis-uto-staileri',
  'tosteri',
  'tsentraluri-gatbobis-qvabi',
  'tskhovelta-da-prinvelta-kveba',
  'tskhovelta-samkaro',
  'tsklis-gamatskheleblebi',
  'tsnevit-saretskhi-aparatebi',
  'tsvensatsurebi',
  'tsvrili-sakopatskhovrebo-teqnika',
  'tv',
  'uto',
  'velosipedebi',
  'ventilatorebi',
  'xelis-traqtorebi',
  'yavis-aparatebi',
  'yursasmenebi');

-- 3) შემოწმება: რამდენი დარჩა შევსებული (უნდა იყოს: სათაური 15+შაბლონით უკვე შევსებული, აღწერა 20)
SELECT SUM(page_title <> '') AS titles_filled, SUM(meta_description <> '') AS descriptions_filled, COUNT(*) AS categories FROM cscart_category_descriptions WHERE lang_code = 'ka';

-- ============================================================================
-- დაბრუნება (მხოლოდ საჭიროების შემთხვევაში; კომენტარია, არ სრულდება):
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'აეროგრილი | ონლაინ მაღაზია - Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'aerogrilebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'აკუმულატორები| Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'akumulatorebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'მონობლოკები All in One| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'all-in-one';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'აუზები და აქსესუარები| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'auzebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ავეჯი | Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'aveji';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ავტო სამყარო | Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'avtosamkaro';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ბაღი და ეზო| Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'baghi-da-ezo';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ჩასაშენებელი ღუმელები| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'chasashenebeli-ghumelebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ჩასაშენებელი სარეცხი მანქანები' WHERE cd.lang_code = 'ka' AND s.name = 'chasashenebeli-saretskhi-manqanebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'დისპენსერები | Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'dispenserebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ელექტრო ჩაიდნები| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'eleqtro-chaidnebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ელექტრო გამათბობლები| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'eleqtro-gamatboblebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ფოტოაპარატები' WHERE cd.lang_code = 'ka' AND s.name = 'fotoaparatebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'გასაბერი ავეჯი | Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'gasaberi-aveji';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'გაზის გამათბობლები | Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'gazis-gamatboblebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ჰაერის გამწმენდი და დამატენიანებლები' WHERE cd.lang_code = 'ka' AND s.name = 'haeris-gamtsmendi-da-damatenianeblebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ჰოვერბორდები' WHERE cd.lang_code = 'ka' AND s.name = 'hoverbordebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'კარტრიჯები, საღებავები, ქაღალდი | Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'kartrijebi-saghebavebi-qaghaldi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'კლიმატური ტექნიკა | Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'klimaturi-teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'კონდიციონერები | Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'kondicionerebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'კონსოლები და აქსესუარები' WHERE cd.lang_code = 'ka' AND s.name = 'konsolebi-da-aqsesuarebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'კუთხსახეხი' WHERE cd.lang_code = 'ka' AND s.name = 'kutkhsakhekhi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'მაცივრები | Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'macivrebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'მიკროტალღური ღუმელები| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'mikrotalghuri-ghumelebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'მიქსერები | Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'miqserebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'მობილური აქსესუარები| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'mobiluri-aqsesuarebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'მობილური ტელეფონები| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'mobiluri-teleponebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'მონიტორები | Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'monitor';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'მტვერსასრუტები| Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'mtversasrutebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ნაძვის ხეები | Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'nadzvisxe';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'პორტატული დამტენები | Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'portatuli-damtenebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'პრინტერები & მრავალფუნქციური მოწყობილობები' WHERE cd.lang_code = 'ka' AND s.name = 'printerebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'პროექტორის ეკრანები | Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'proeqtoris-ekranebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ქურის ზედაპირი| Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'quris-zedapiri';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ქვაბებისა და ტაფების ნაკრებები' WHERE cd.lang_code = 'ka' AND s.name = 'qvabebisa-da-tapebis-nakrebebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'საახალწლო | Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'saakhaltslo';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'საბავშვო პროდუქცია | Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'sabavshvo-produqtsia';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'საბურავები' WHERE cd.lang_code = 'ka' AND s.name = 'saburavebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'საკერავი ტექნიკა' WHERE cd.lang_code = 'ka' AND s.name = 'sakeravi-teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'სახლი და სილამაზე | Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'sakhli-da-dekori';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'საყინულეები | Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'sakinule';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'საყოფაცხოვრებო ტექნიკა| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'sakopatskhovrebo-teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'სამშენებლო ხელსაწყოები | Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'samsheneblo-khelsatskoebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'სამზარეულოს ტექნიკა| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'samzarelos-teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'სამზარეულოს აქსესაურები| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'samzareulos-aqsesuarebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'სამზარეულოს დანები| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'samzareulos-danebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'საოფისე და ქსელური მოწყობილობები' WHERE cd.lang_code = 'ka' AND s.name = 'saopise-da-qseluri-motskobilobebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'სარეცხი მანქანები| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'saretskhi-manqanebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'საშრობი მანქანები | Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'sashrobebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'სათამაშოები| Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'satamashoebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'SMART WATCHES| Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'smart-watches';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'სპორტი და დასვენება' WHERE cd.lang_code = 'ka' AND s.name = 'sporti';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'სტაციონალური ტელეფონები| Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'statsionaluri-teleponebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ტაბლეტები | Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'tabletebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ტელეფონები, ტაბლეტები, ელექტრონული წიგნები' WHERE cd.lang_code = 'ka' AND s.name = 'telefonebi-tabletebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ტელევიზორები' WHERE cd.lang_code = 'ka' AND s.name = 'televizorebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ტელევიზორის აქსესუარები' WHERE cd.lang_code = 'ka' AND s.name = 'televizoris-aqsesuarebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ტექნიკა | Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ცხოველთა და ფრინველთა კვება' WHERE cd.lang_code = 'ka' AND s.name = 'tskhovelta-da-prinvelta-kveba';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ცხოველთა სამყარო' WHERE cd.lang_code = 'ka' AND s.name = 'tskhovelta-samkaro';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'წვრილი საყოფაცხოვრებო ტექნიკა | Superi.ge | ონლაინ მაღაზია' WHERE cd.lang_code = 'ka' AND s.name = 'tsvrili-sakopatskhovrebo-teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'TV-ფოტო-ვიდეო | Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'tv';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'UTO' WHERE cd.lang_code = 'ka' AND s.name = 'uto';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ველოსიპედები' WHERE cd.lang_code = 'ka' AND s.name = 'velosipedebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ვენტილატორები | Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'ventilatorebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ყურსასმენები| Superi.ge | აღმოაჩინე საუკეთესო შეთავაზებები' WHERE cd.lang_code = 'ka' AND s.name = 'yursasmenebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'GAMING მაგიდა-სავარძლები -Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'gaming';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ნოუთბუქები, კომპიუტერები, მონიტორები-Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'noutbuqebi-kompiuterebi-monitorebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'პროექტორები და აქსესუარები-Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'proeqtorebi-da-aqsesuarebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'სარეცხ-საწმენდი საშუალებები-Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'saretskh-satsmendi-sashualebebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'შესაწამლი აპარატები - საუკეთესო ფასად' WHERE cd.lang_code = 'ka' AND s.name = 'shesawamli-aparatebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.page_title = 'ცენტრალური გათბობის ქვაბი-Superi.ge' WHERE cd.lang_code = 'ka' AND s.name = 'tsentraluri-gatbobis-qvabi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აღმოაჩინე Superi.ge - ზე საუკეთესო აეროგრილების არჩევანი – კომპაქტური, ეფექტური და თანამედროვე მოდელები, რომლებიც ხელს შეუწყობენ ჯანსაღი კერძების მომზადებას ნაკლები ცხიმით. შეადარეთ მახასიათებლები, ფასები და მოდელები, რათა გააკეთოთ საუკეთესო არჩევანი და მ' WHERE cd.lang_code = 'ka' AND s.name = 'aerogrilebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აკუმულატორების ფართო არჩევანი SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'akumulatorebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინე სუპერ ფასად All in One ები SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'all-in-one';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეხვდით ზაფხულის ცხელ დღეებს მომზადებული, შეიძინეთ აუზები და აქსესუარები სუპერ ფასად Superi.ge - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'auzebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'ავეჯის ფართო არჩევანი SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'aveji';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე ყველაფერი შენი ავტომობილისთვის SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'avtosamkaro';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​მოაწყე შენი ეზო და ბაღი SUPERI.GE -სთან ერთად,ყველაზე ფართო არჩევანი,სუპერ ფასები' WHERE cd.lang_code = 'ka' AND s.name = 'baghi-da-ezo';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​მოაწყე ბაღი საუკეთესო ხარისხის ავეჯით სუპერ ფასად! შეიძინე ბაღის და ეზოს ავეჯი სახლიდან გაუსვლელად. ჩვენთან მოქმედებს 0% განვადება. მიწოდება საქართველოს მასშტაბით' WHERE cd.lang_code = 'ka' AND s.name = 'bagis-aveji';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​ბატუტების ყველაზე ფართო არჩევანი, სუპერ ფასად Superi.ge _ ზე ' WHERE cd.lang_code = 'ka' AND s.name = 'batutebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე ჩასაშენებელი ღუმელები SUPER ფასად SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'chasashenebeli-ghumelebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინეთ წამყვანი ბრენდის ჩასაშენებელი სარეცხი მანქანები SUPER ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'chasashenebeli-saretskhi-manqanebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინეთ ჩოფერები SUPERI.GE-ზე. სხვადასხვა სიმძლავრისა და მოცულობის მოდელები პროდუქტების სწრაფად დასაჭრელად და დასაქუცმაცებლად, ცნობილი ბრენდები და საუკეთესო ფასები საქართველოში.' WHERE cd.lang_code = 'ka' AND s.name = 'choferebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძნე პრემიუმ ხარისხის თეფშები SUPER ფასად​' WHERE cd.lang_code = 'ka' AND s.name = 'churcheli';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე შენთვის სასურველი პრემიუმ ბრენდის დისპენსერები SUPER ფასად​' WHERE cd.lang_code = 'ka' AND s.name = 'dispenserebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'იყიდე სასურველი დრონი სუპერ​' WHERE cd.lang_code = 'ka' AND s.name = 'droni';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'ელექტრო ჩაიდნების ფართო არჩევანი, სუპერ ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'eleqtro-chaidnebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეხვდი ზამთარს მომზადებული, შეიძინე ელექტრო გამათბობლები სუპერ ფასად SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'eleqtro-gamatboblebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'იყიდეთ ელექტრო ღუმელები და მინი ღუმელები Superi.ge-ზე. შეარჩიეთ სასურველი მოცულობის, ფუნქციებისა და დიზაინის ელექტრო ღუმელი ცხობის, გრილისა და ყოველდღიური მომზადებისთვის' WHERE cd.lang_code = 'ka' AND s.name = 'eleqtro-gumelebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'გაულამაზე შენს პატარას ყოველი დღე, შეიძნე ელექტრო მანქანები Super ფასად Superi.ge ზე' WHERE cd.lang_code = 'ka' AND s.name = 'eleqtro-manqanebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე ფოტოაპარატები სუპერ ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'fotoaparatebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'GAMING სავარძლები' WHERE cd.lang_code = 'ka' AND s.name = 'gaming';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინე შენთვის სასურველი გამწოვი სუპერ ფასად Superi.ge - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'gamtsovi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აღმოაჩინე გასაბერი ავეჯი Superi.ge - საუკეთესო ფასად, შეიქმენი კომფორტი შეიძინე ნივთები სუპერ ფასად!' WHERE cd.lang_code = 'ka' AND s.name = 'gasaberi-aveji';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეხვდით ზამთარს მომზადებული, შეიძინე გაზის გამათბობლები სუპერ ფასად SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'gazis-gamatboblebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეარჩიეთ სხვადასხვა სიმძლავრის გენერატორი სახლისთვის, სამშენებლო სამუშაოებისა და ბიზნესისთვის. ნახეთ მოდელები, მახასიათებლები და ფასები SUPERI.GE-ზე.' WHERE cd.lang_code = 'ka' AND s.name = 'generatorebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინე შენთვის სასურველი ჰაერის დამატენიანებელი super ფასად!' WHERE cd.lang_code = 'ka' AND s.name = 'haeris-gamtsmendi-da-damatenianeblebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეხვდი თბილ დღეებს მომზადებული☀ შეიძინე შენთვის სასურველი პროდუქცია სუპერ ფასად Superi.ge - ზე​​' WHERE cd.lang_code = 'ka' AND s.name = 'hamakebi-da-saqanelebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აღმოაჩინე პრემიუმ ხარისხის ჰოვერბორდერბი Superi.ge - ზე საუკეთესო ფასად! აჩუქეთ ბავშვებს ბედნიერება! მიიეთ შეკვეთა უსწრაფერსად.' WHERE cd.lang_code = 'ka' AND s.name = 'hoverbordebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე თქვენი პრინტერისათვის თავსებადი საუკეთესო ხარისხის კარტრიჯები და საღებავები Superi.ge - ზე და მიიღე შეკვეთა უსწრაფესად.' WHERE cd.lang_code = 'ka' AND s.name = 'kartrijebi-saghebavebi-qaghaldi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​გაიმარტივე სამუშაო გარემო, შეიძინე პრემიუმ ბრენდის ინსტრუმენტები SUPER ფასად!' WHERE cd.lang_code = 'ka' AND s.name = 'khelis-instrumentebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'კლიმატური ტექნიკის ყველაზე დიდი არჩევანი სუპერ ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'klimaturi-teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე შენთვის სასურველი პრემიუმ ბრენდების კომპიუტერის აქსესუარები SUPER ფასად!​' WHERE cd.lang_code = 'ka' AND s.name = 'kompiuteris-aqsesuarebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'კომპიუტერის ნაწილები Superi.ge-ზე – პროცესორები, ვიდეო ბარათები, SSD, დედაპლატები. ხარისხიანი არჩევანი, ხელმისაწვდომი ფასი და სწრაფი მიწოდება.' WHERE cd.lang_code = 'ka' AND s.name = 'kompiuteris-natsilebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინე შენთვის სასურველი კომპრესორი სუპერ ფასად Superi.ge - ზე ' WHERE cd.lang_code = 'ka' AND s.name = 'kompresorebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე კონდიციონერები სუპერ ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'kondicionerebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აღმოაჩინე უახლესი კონსოლები Super ფასად,დაიწყე ახალი თავგადასავლები ჩვენთან ერთად' WHERE cd.lang_code = 'ka' AND s.name = 'konsolebi-da-aqsesuarebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე პრემიუმ ხარისხის კუთხსახეხი ჩვენთან Super - ფასად!' WHERE cd.lang_code = 'ka' AND s.name = 'kutkhsakhekhi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აღმოაჩინე პრემიუმ ხარისხის მაგიდები და სკამები Superi.ge - ზე საუკეთესო ფასად, შეიქმენი მყუდრო გარემო. ' WHERE cd.lang_code = 'ka' AND s.name = 'magida-da-skamebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინეთ თქვენთვის სასურველი მიკროტალღური ღუმელი SUPER ფასად SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'mikrotalghuri-ghumelebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინე შენთვის სასურველი მიქსერი SUPER ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'miqserebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინე ყველა საჭირო აქსესუარი მობილურისთვის სუპერ ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'mobiluri-aqsesuarebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'იმოგზაურე კომფორტულად, შეიძინე SUPER ფასად ყველა საჭირო აქსესუარი​' WHERE cd.lang_code = 'ka' AND s.name = 'mogzauroba';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'დედა დაფები საუკეთესო ბრენდებისგან – Intel და AMD პლატფორმებისთვის. ხარისხი, თანამედროვე ინტერფეისები და სწრაფი მიწოდება Superi.ge-ზე.' WHERE cd.lang_code = 'ka' AND s.name = 'motherboard';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინე შენთვის სასურველი მტვერსასრუტი სუპერ ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'mtversasrutebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე ნოუთბუქი სუპერ ფასად SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'noutbuqebi-kompiuterebi-monitorebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე ნოუთბუქები და ლეპტოპები საუკეთესო ფასად Superi.ge-ზე – Asus, HP, Lenovo, Apple და სხვა ტოპ ბრენდები. ოფიციალური გარანტია და სწრაფი მიწოდება საქართველოს მასშტაბით.' WHERE cd.lang_code = 'ka' AND s.name = 'noutbuqebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აღმოაჩინე საუკეთესო ხარისხის პორტატული დამტენები Superi.ge - სუპერ ფასად! მიიღე შეკვეთა უსწრაფესად.' WHERE cd.lang_code = 'ka' AND s.name = 'portatuli-damtenebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინე შენთვის სასურველი მრავალფუნქციური მოწყობილობები სუპერ ფასად!' WHERE cd.lang_code = 'ka' AND s.name = 'printerebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აღმოაჩინეთ საუკეთესო პროექტორები და აქსესუარები სუპერ ფასად - superi.ge. მიიღე შეძენილი პროდუქტი უსწრაფესად.' WHERE cd.lang_code = 'ka' AND s.name = 'proeqtorebi-da-aqsesuarebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე შენთვის სასურველი პროექტორი S​uper - ფასად' WHERE cd.lang_code = 'ka' AND s.name = 'proeqtori';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აღმოაჩინე საუკეთესო ფასად სასურველი პროექტორის ეკრანები Superi.ge - ზე და მიიღე შეკვეთა უსწრაფესად.' WHERE cd.lang_code = 'ka' AND s.name = 'proeqtoris-ekranebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აღმოაჩინე Superi.ge - ზე მსოფლიო ბრენდის პრემიუმ ხარისხის ქურის ზედაპირი საუკეთესო ფასად!' WHERE cd.lang_code = 'ka' AND s.name = 'quris-zedapiri';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინეთ უმაღლესი ხარისხის ტაფა-ქვაბის ნაკრებები SUPER ფასად ' WHERE cd.lang_code = 'ka' AND s.name = 'qvabebisa-da-tapebis-nakrebebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე საბავშვო პროდუქცია SUPERI.GE - ზე და გააბედნიერე შენი პატარა' WHERE cd.lang_code = 'ka' AND s.name = 'sabavshvo-produqtsia';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'მოემზადე ყველა სეზონისთვის, შეიძინე სუპერ ფასად საბურავები SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'saburavebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე საკერავი მანქანები სუპერ ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'sakeravi-teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე ყველაფერი რაც გსურს შენი სახლისთვის SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'sakhli-da-dekori';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'საყინულე მაცივრების ყველაზე დიდი არჩევანი SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'sakinule';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'საყოფაცხოვრებო ტექნიკის ყველაზე დიდი არჩევანი სუპერ ფასად SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'sakopatskhovrebo-teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'სამშენებლო ხელსაწყოების ყველაზე ფართო არჩევანი SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'samsheneblo-khelsatskoebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე სამზარეულოს ტექნიკა სუპერ ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'samzarelos-teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'გაიმარტივე ცხოვრება, შეიძინე პრემიუმ ხარისხის ჭურჭელი SUPE​R ფასად' WHERE cd.lang_code = 'ka' AND s.name = 'samzareulos-aqsesuarebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აიმაღლეთ თქვენი კულინარიული გამოცდილება განსაკუტრებული ხარისხის დანების საშუალებით,რომელიც საშუალებას მოგცემთ მიაღწიოთ სასურველ შედეგს ძალისხმევის გარეშე, დაათვალიერე ჩვენი კატალოგი და შეიძინე სამზარეულოს დანები super ფასად!' WHERE cd.lang_code = 'ka' AND s.name = 'samzareulos-danebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინეთ სამზარეულოს კომბაინები SUPERI.GE-ზე. მრავალფეროვანი მოდელები სხვადასხვა ფუნქციით, სიმძლავრითა და მოცულობით, ცნობილი ბრენდები და საუკეთესო ფასები საქართველოში' WHERE cd.lang_code = 'ka' AND s.name = 'samzareulos-kombainebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინე საოფისე და ქსელური მოწყობილობები სუპერ ფასად!' WHERE cd.lang_code = 'ka' AND s.name = 'saopise-da-qseluri-motskobilobebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე შენთვის სასურველი სარეცხ-საწმენდი საშუალებები Super ფასად!​​' WHERE cd.lang_code = 'ka' AND s.name = 'saretskh-satsmendi-sashualebebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინე სარეცხი მანქანები სუპერ ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'saretskhi-manqanebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​გაულამაზეთ თქვენს პატარას თითოეული დღე, შეიძინე სათამაშოები სუპერ ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'satamashoebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძინე შენთვის სასურველი სმარტ საათი სუპერ ფასად SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'smart-watches';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'გთავაზობთ ჰოვერბორდების ფართო არჩევანს SUPERI.GE-ზე. ჩვენ გვაქვს ჰოვერბორდები ყველა ასაკისა და საჭიროებისათვის, საუკეთესო ფასებში და სწრაფი მიწოდებით.' WHERE cd.lang_code = 'ka' AND s.name = 'sporti';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აღმოაჩინე სახლის ტელეფონების ყველაზე ფართო არჩევანი Superi.ge - ზე საუკეთესო ფასად.' WHERE cd.lang_code = 'ka' AND s.name = 'statsionaluri-teleponebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეიძნე სუპერ ფასად შენთვის სასურველი ტაბლეტი SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'tabletebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'ტელეფონები, ტაბლეტები, ელექტრონული წიგნების ფართო არჩევანი SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'telefonebi-tabletebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'SUPERI.GE-ს ტელევიზორის აქსესუარების კატეგორია გთავაზობთ მრავალფეროვან არჩევანს საუკეთესო ფასად.' WHERE cd.lang_code = 'ka' AND s.name = 'televizoris-aqsesuarebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე ტექნიკა სუპერ ფასად, SUPERI.GE - ზე და აიხდინე სურვილები' WHERE cd.lang_code = 'ka' AND s.name = 'teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე შენთვის სასურველი ტექსტილი სუპერ ფასად Superi.ge - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'teqstili';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '' WHERE cd.lang_code = 'ka' AND s.name = 'tmis-uto-staileri';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე საუკეთესო ფასად შენთვის სასურველი ტოსტერი!' WHERE cd.lang_code = 'ka' AND s.name = 'tosteri';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძნე ცენტრალური გათბობის ქვაბი SUPER ფასად!​' WHERE cd.lang_code = 'ka' AND s.name = 'tsentraluri-gatbobis-qvabi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე შენი საყვარელი მეგობრისთვის საკვები სუპერ ფასად SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'tskhovelta-da-prinvelta-kveba';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე ყველაფერი შენი საყვარელი მეგობრისთვის SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'tskhovelta-samkaro';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე საუკეთესო ფასად თქვენთვის სასურველი წყლის გამაცხელებელი!' WHERE cd.lang_code = 'ka' AND s.name = 'tsklis-gamatskheleblebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე სასურველი წნევით სარეცხი სუპერ ფასად!' WHERE cd.lang_code = 'ka' AND s.name = 'tsnevit-saretskhi-aparatebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'აღმოაჩინე ახალი და ნატურალური გემო ჩვენი პრემიუმ ხარისხის წვენსაწურების საშუალებით, გაიუმჯობესე ჯანმრთელობა და შეიძინეწვენსაწური სუპერ ფასად!' WHERE cd.lang_code = 'ka' AND s.name = 'tsvensatsurebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე შენთვის სასურველი ნივთი სუპერ ფასად SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'tsvrili-sakopatskhovrebo-teqnika';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'ტელევიზორების,ფოტო და ვიდეო ტექნიკის ფართო არჩევანი' WHERE cd.lang_code = 'ka' AND s.name = 'tv';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​შეარჩიეთ თქვენთვის საუკეთესო უთო ჩვენს კატეგორიაში! ორთქლის, მშრალი, სამოგზაურო და სხვა ტიპის უთოები პრემიუმ ბრენდებისგან. იხილეთ დეტალური აღწერილობა და შეადარეთ ფასები. გააუთოვეთ თქვენი ტანსაცმელი მარტივად და ეფექტურად!​' WHERE cd.lang_code = 'ka' AND s.name = 'uto';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = '​ველოსიპედების ფართო არჩევანი SUPERI.GE - ზე' WHERE cd.lang_code = 'ka' AND s.name = 'velosipedebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე ვენტილატორები Superi.ge-ზე საუკეთესო ფასად. იატაკის, მაგიდის და სადგამი ვენტილატორები ძლიერი ჰაერის ნაკადით, დაბალი ხმაურით და სწრაფი მიწოდებით.' WHERE cd.lang_code = 'ka' AND s.name = 'ventilatorebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე ხელის ტრაქტორები სუპერ ფასად Superi.ge - ზე და დაზოგე ენერგია​' WHERE cd.lang_code = 'ka' AND s.name = 'xelis-traqtorebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინეთ ყავის აპარატები SUPERI.GE-ზე. მრავალფეროვანი მოდელები სახლისა და ოფისისთვის, ცნობილი ბრენდები, სხვადასხვა ფუნქციები და საუკეთესო ფასები საქართველოში.' WHERE cd.lang_code = 'ka' AND s.name = 'yavis-aparatebi';
-- UPDATE cscart_category_descriptions cd JOIN cscart_seo_names s ON s.object_id = cd.category_id AND s.type = 'c' AND s.lang_code = 'ka' SET cd.meta_description = 'შეიძინე შენთვის სასურველი ყურსასმენები სუპერ ფასად SUPERI.GE - ზე​' WHERE cd.lang_code = 'ka' AND s.name = 'yursasmenebi';
