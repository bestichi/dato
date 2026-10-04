-- ============================================================================
-- superi.ge — ყველა სურათს alt ტექსტი (cscart_images_links-ის ყველა სურათი)
-- მხოლოდ ავსებს ცარიელ alt-ს. უკვე არსებულ alt-ს არ ეხება. არაფერი იშლება.
-- თუ რომელიმე ცხრილი ბაზაში არ არის, ის ნაბიჯი უბრალოდ გამოტოვდება.
-- ============================================================================

SET NAMES utf8mb4;
DROP TEMPORARY TABLE IF EXISTS tmp_img;
CREATE TEMPORARY TABLE tmp_img (img_id INT UNSIGNED NOT NULL, object_id INT UNSIGNED NOT NULL, object_type VARCHAR(64) NOT NULL, type CHAR(1) NOT NULL, position INT NOT NULL, pair_id INT UNSIGNED NOT NULL, KEY (img_id), KEY (object_type, object_id)) ENGINE=MEMORY;
INSERT INTO tmp_img SELECT image_id, object_id, object_type, type, position, pair_id FROM cscart_images_links WHERE image_id > 0;
INSERT INTO tmp_img SELECT detailed_id, object_id, object_type, type, position, pair_id FROM cscart_images_links WHERE detailed_id > 0;
DROP TEMPORARY TABLE IF EXISTS tmp_alt;
CREATE TEMPORARY TABLE tmp_alt (img_id INT UNSIGNED NOT NULL PRIMARY KEY, alt VARCHAR(500) NOT NULL) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- 1) საიტზე ხილული მენიუს აიქონები და ბანერები — ზუსტი ტექსტი საიტიდან
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'ტექნიკა' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type = 'abt__ut2/menu-with-icon' AND ti.img_id BETWEEN 37000 AND 37999 AND i.image_path IN ('tech-icon-be-ge.png', 'tech-icon-be-ge.png.webp');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'საბავშვო პროდუქცია' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type = 'abt__ut2/menu-with-icon' AND ti.img_id BETWEEN 37000 AND 37999 AND i.image_path IN ('toys.png', 'toys.png.webp');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'სახლი და სილამაზე' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type = 'abt__ut2/menu-with-icon' AND ti.img_id BETWEEN 37000 AND 37999 AND i.image_path IN ('furnitures.png', 'furnitures.png.webp');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'სპორტი და დასვენება' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type = 'abt__ut2/menu-with-icon' AND ti.img_id BETWEEN 37000 AND 37999 AND i.image_path IN ('sport.png', 'sport.png.webp');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'ბაღი და ეზო' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type = 'abt__ut2/menu-with-icon' AND ti.img_id BETWEEN 37000 AND 37999 AND i.image_path IN ('table.png', 'table.png.webp');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'სამშენებლო ხელსაწყოები' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type = 'abt__ut2/menu-with-icon' AND ti.img_id BETWEEN 37000 AND 37999 AND i.image_path IN ('hammer-drill.png', 'hammer-drill.png.webp');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'ცხოველთა სამყარო' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type = 'abt__ut2/menu-with-icon' AND ti.img_id BETWEEN 37000 AND 37999 AND i.image_path IN ('paw.png', 'paw.png.webp');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'ავეჯი' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type = 'abt__ut2/menu-with-icon' AND ti.img_id BETWEEN 37000 AND 37999 AND i.image_path IN ('sofa.png', 'sofa.png.webp');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'მობილური' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type LIKE 'abt__ut2/banners/%' AND ti.img_id BETWEEN 38000 AND 38999 AND i.image_path IN ('img_693139048ac5e1f7990f3-0acf-4014-90c9-48ef7afaa358-removebg-preview.png', 'img_693139048ac5e1f7990f3-0acf-4014-90c9-48ef7afaa358-removebg-preview.png');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'სპორტი' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type LIKE 'abt__ut2/banners/%' AND ti.img_id BETWEEN 27000 AND 27999 AND i.image_path IN ('b7e301f47da92a37ed2aa07fe1079eda-removebg-preview.webp', 'b7e301f47da92a37ed2aa07fe1079eda-removebg-preview');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'ტელევიზორი' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type LIKE 'abt__ut2/banners/%' AND ti.img_id BETWEEN 27000 AND 27999 AND i.image_path IN ('televizori.webp', 'televizori');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'ავეჯი' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type LIKE 'abt__ut2/banners/%' AND ti.img_id BETWEEN 27000 AND 27999 AND i.image_path IN ('aveji.webp', 'aveji');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'ნოუთბუქი' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type LIKE 'abt__ut2/banners/%' AND ti.img_id BETWEEN 27000 AND 27999 AND i.image_path IN ('notebook__1_.webp', 'notebook__1_');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'ტექსტილი' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type LIKE 'abt__ut2/banners/%' AND ti.img_id BETWEEN 27000 AND 27999 AND i.image_path IN ('Untitled-1.webp', 'Untitled-1');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'სამზარეულოს ტექნიკა' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type LIKE 'abt__ut2/banners/%' AND ti.img_id BETWEEN 27000 AND 27999 AND i.image_path IN ('SSSS-removebg-preview__1___1_.webp', 'SSSS-removebg-preview__1___1_');
INSERT IGNORE INTO tmp_alt SELECT DISTINCT ti.img_id, 'ჭურჭელი' FROM tmp_img ti JOIN cscart_images i ON i.image_id = ti.img_id WHERE ti.object_type LIKE 'abt__ut2/banners/%' AND ti.img_id BETWEEN 27000 AND 27999 AND i.image_path IN ('Untitled-1__1_.webp', 'Untitled-1__1_');

-- 2) პროდუქტები: მთავარი ფოტო = პროდუქტის სახელი; დამატებითი = სახელი – ფოტო 2, 3, ...
INSERT IGNORE INTO tmp_alt SELECT x.img_id, IF(x.type = 'M', x.product, CONCAT(x.product, ' – ფოტო ', x.n + 1)) FROM (
  SELECT ti.img_id, ti.type, pd.product, ROW_NUMBER() OVER (PARTITION BY ti.object_id, ti.type ORDER BY ti.position, ti.pair_id) AS n
  FROM tmp_img ti JOIN cscart_product_descriptions pd ON pd.product_id = ti.object_id AND pd.lang_code = 'ka'
  WHERE ti.object_type = 'product' AND TRIM(pd.product) <> '') x ORDER BY (x.type = 'M') DESC;
-- სახელი თუ ქართულად არ აქვს — სხვა ენიდან
INSERT IGNORE INTO tmp_alt SELECT ti.img_id, MAX(pd.product) FROM tmp_img ti JOIN cscart_product_descriptions pd ON pd.product_id = ti.object_id WHERE ti.object_type = 'product' AND TRIM(pd.product) <> '' GROUP BY ti.img_id;

-- 3) კატეგორიები და კატეგორიის ბანერები/აიქონები = კატეგორიის სახელი
INSERT IGNORE INTO tmp_alt SELECT ti.img_id, MAX(cd.category) FROM tmp_img ti JOIN cscart_category_descriptions cd ON cd.category_id = ti.object_id AND cd.lang_code = 'ka' WHERE ti.object_type IN ('category', 'category_banner', 'category_alt_banner', 'ab__lc_catalog_icon', 'ab__dotd_cat_filter') AND TRIM(cd.category) <> '' GROUP BY ti.img_id;

-- 4) ბრენდები / მახასიათებლის მნიშვნელობები = ბრენდის სახელი
INSERT IGNORE INTO tmp_alt SELECT ti.img_id, MAX(vd.variant) FROM tmp_img ti JOIN cscart_product_feature_variant_descriptions vd ON vd.variant_id = ti.object_id AND vd.lang_code = 'ka' WHERE ti.object_type = 'feature_variant' AND TRIM(vd.variant) <> '' GROUP BY ti.img_id;

-- 5) ლოგო
INSERT IGNORE INTO tmp_alt SELECT img_id, 'Superi.ge' FROM tmp_img WHERE object_type = 'logos';

-- 6) გადახდის მეთოდები, ბლოგი, მენიუები, ძველი ბანერები (თუ ცხრილი არსებობს)
SET @s := IF((SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'cscart_payment_descriptions') > 0,
  'INSERT IGNORE INTO tmp_alt SELECT ti.img_id, MAX(d.payment) FROM tmp_img ti JOIN cscart_payment_descriptions d ON d.payment_id = ti.object_id AND d.lang_code = ''ka'' WHERE ti.object_type = ''payment'' AND TRIM(d.payment) <> '''' GROUP BY ti.img_id',
  'DO 0');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
SET @s := IF((SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'cscart_page_descriptions') > 0,
  'INSERT IGNORE INTO tmp_alt SELECT ti.img_id, MAX(d.page) FROM tmp_img ti JOIN cscart_page_descriptions d ON d.page_id = ti.object_id AND d.lang_code = ''ka'' WHERE ti.object_type = ''blog'' AND TRIM(d.page) <> '''' GROUP BY ti.img_id',
  'DO 0');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
SET @s := IF((SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'cscart_static_data_descriptions') > 0,
  'INSERT IGNORE INTO tmp_alt SELECT ti.img_id, MAX(d.descr) FROM tmp_img ti JOIN cscart_static_data_descriptions d ON d.param_id = ti.object_id AND d.lang_code = ''ka'' WHERE ti.object_type IN (''abt__ut2/menu-with-icon'', ''static_data_icon'', ''menu_icon'') AND TRIM(d.descr) <> '''' GROUP BY ti.img_id',
  'DO 0');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
SET @s := IF((SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'cscart_banner_images') > 0 AND (SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'cscart_banner_descriptions') > 0,
  'INSERT IGNORE INTO tmp_alt SELECT ti.img_id, MAX(d.banner) FROM tmp_img ti JOIN cscart_banner_images bi ON bi.banner_image_id = ti.object_id JOIN cscart_banner_descriptions d ON d.banner_id = bi.banner_id AND d.lang_code = ''ka'' WHERE ti.object_type = ''promo'' AND TRIM(d.banner) <> '''' GROUP BY ti.img_id',
  'DO 0');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- 7) დანარჩენი ყველა (სტიკერები, პიქტოგრამები, სხვა აიქონები) — რომ არცერთს არ დააკლდეს
INSERT IGNORE INTO tmp_alt SELECT img_id, 'Superi.ge' FROM tmp_img;

-- 8) ჩაწერა: ცარიელი alt-ის შევსება + ახლის დამატება იქ, სადაც საერთოდ არ არის
UPDATE cscart_common_descriptions cd JOIN tmp_alt t ON t.img_id = cd.object_id SET cd.description = t.alt WHERE cd.object_holder = 'images' AND cd.lang_code = 'ka' AND TRIM(IFNULL(cd.description, '')) = '';
INSERT INTO cscart_common_descriptions (object_id, description, lang_code, object_holder) SELECT t.img_id, t.alt, 'ka', 'images' FROM tmp_alt t WHERE NOT EXISTS (SELECT 1 FROM cscart_common_descriptions x WHERE x.object_id = t.img_id AND x.object_holder = 'images' AND x.lang_code = 'ka');

-- 9) შემოწმება: no_alt სვეტი ყველგან 0 უნდა იყოს
SELECT ti.object_type, COUNT(*) AS images, SUM(TRIM(IFNULL(cd.description, '')) = '') AS no_alt FROM tmp_img ti LEFT JOIN cscart_common_descriptions cd ON cd.object_id = ti.img_id AND cd.object_holder = 'images' AND cd.lang_code = 'ka' GROUP BY ti.object_type ORDER BY images DESC;
DROP TEMPORARY TABLE IF EXISTS tmp_img;
DROP TEMPORARY TABLE IF EXISTS tmp_alt;
