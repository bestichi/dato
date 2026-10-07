-- ============================================================================
-- superi.ge — 36: პროდუქტების სახელების 2 შეცდომა (კატალოგის შემოწმებიდან)
-- 1) 65" ტელევიზორს სახელში 55"-იანის კოდი უწერია: QE55QN70HAUXPY 65" → QE65QN70HAUXPY 65"
--    (აღწერაში სწორი კოდია: QE65QN70HAUXPY). მისამართი არ იცვლება.
-- 2) „კონდიციონრი“ → „კონდიციონერი“ (MAYER TAC-24MN1 INVERTER)
-- ასლი: superi_bk_prod_36. ხელახლა გაშვება უსაფრთხოა. დაბრუნება ბოლოშია.
-- ============================================================================
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS superi_bk_prod_36 AS SELECT pd.product_id, pd.lang_code, pd.product, pd.page_title, pd.meta_description FROM cscart_product_descriptions pd JOIN cscart_seo_names s ON s.object_id = pd.product_id AND s.type = 'p' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE pd.lang_code = 'ka' AND s.name IN ('samsung-qe55qn70hauxpy-65-163', 'mayer-tac-24mn1-80-inverter');

UPDATE cscart_product_descriptions pd JOIN cscart_seo_names s ON s.object_id = pd.product_id AND s.type = 'p' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'samsung-qe55qn70hauxpy-65-163'
SET pd.product = REPLACE(pd.product, 'QE55QN70HAUXPY 65', 'QE65QN70HAUXPY 65'), pd.page_title = REPLACE(pd.page_title, 'QE55QN70HAUXPY 65', 'QE65QN70HAUXPY 65'), pd.meta_description = REPLACE(pd.meta_description, 'QE55QN70HAUXPY 65', 'QE65QN70HAUXPY 65')
WHERE pd.lang_code = 'ka';

UPDATE cscart_product_descriptions pd JOIN cscart_seo_names s ON s.object_id = pd.product_id AND s.type = 'p' AND s.lang_code = 'ka' AND s.company_id = 1 AND s.name = 'mayer-tac-24mn1-80-inverter'
SET pd.product = REPLACE(pd.product, 'კონდიციონრი', 'კონდიციონერი'), pd.page_title = REPLACE(pd.page_title, 'კონდიციონრი', 'კონდიციონერი'), pd.meta_description = REPLACE(pd.meta_description, 'კონდიციონრი', 'კონდიციონერი')
WHERE pd.lang_code = 'ka';

-- შემოწმება
SELECT s.name, pd.product FROM cscart_product_descriptions pd JOIN cscart_seo_names s ON s.object_id = pd.product_id AND s.type = 'p' AND s.lang_code = 'ka' AND s.company_id = 1 WHERE pd.lang_code = 'ka' AND s.name IN ('samsung-qe55qn70hauxpy-65-163', 'mayer-tac-24mn1-80-inverter');

-- ============================================================================
-- დაბრუნება (კომენტარია, არ სრულდება):
-- UPDATE cscart_product_descriptions pd JOIN superi_bk_prod_36 b ON b.product_id = pd.product_id AND b.lang_code = pd.lang_code SET pd.product = b.product, pd.page_title = b.page_title, pd.meta_description = b.meta_description;
-- ============================================================================
