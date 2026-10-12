"""Brand normalisation and detection from product titles."""
import re

STORE_BRAND = 'Superi'  # Google: store name allowed as brand for generic / unbranded products

# lowercased raw value -> canonical display form
CANON = {
    'bosch | ბოში': 'Bosch', 'bosch': 'Bosch', 'black & decker': 'BLACK+DECKER', 'black&decker': 'BLACK+DECKER',
    'black+decker': 'BLACK+DECKER', 'delonghi': "De'Longhi", "de'longhi": "De'Longhi",
    'hotpoint-ariston': 'Hotpoint-Ariston', 'harman/kardon': 'Harman Kardon', 'cooper & hunter': 'Cooper&Hunter',
    'konner&sohnen': 'Könner & Söhnen', 'al-ko': 'AL-KO', 'ingco': 'INGCO', 'lego': 'LEGO', 'jbl': 'JBL',
    'hyperx': 'HyperX', 'kingsmith': 'KingSmith', 'nordictrack': 'NordicTrack', 'ecoflow': 'EcoFlow',
    'thermaltake': 'Thermaltake', 'viewsonic': 'ViewSonic', 'oneplus': 'OnePlus', 'pro-form': 'ProForm',
    'proform': 'ProForm', 'chiq': 'CHiQ', '2e': '2E', '2k': '2K', 'xbox': 'Microsoft', 'microsoft': 'Microsoft',
    'google pixel': 'Google', 'google': 'Google', 'pro plan': 'Purina', 'purina': 'Purina', 'sanny': 'Sunny',
    'sunny': 'Sunny', 'ugreen': 'UGREEN', 'tcl': 'TCL', 'hmd': 'HMD', 'inno3d': 'INNO3D', 'amd': 'AMD',
    'intel': 'Intel', 'msi': 'MSI', 'urevo': 'UREVO', 'ilife': 'ILIFE', 'la sommelière': 'La Sommelière',
    'tp-link': 'TP-Link', 'tp-link ': 'TP-Link', 'lg': 'LG', 'hp': 'HP', 'aeg': 'AEG', 'dji': 'DJI', 'aoc': 'AOC',
    'aux': 'AUX', 'asus': 'ASUS', 'asustek': 'ASUS', 'vox': 'VOX', 'sony': 'Sony', 'beko': 'Beko', 'dell': 'Dell',
    'acer': 'Acer', 'gree': 'Gree', 'oppo': 'OPPO', 'honor': 'HONOR', 'apple': 'Apple', 'zte': 'ZTE',
    'dyson': 'Dyson', 'shark': 'Shark', 'smeg': 'Smeg', 'nokia': 'Nokia', 'tecno': 'TECNO', 'itel': 'itel',
    'realme': 'realme', 'vivo': 'vivo', 'iphone': 'Apple', 'playstation': 'Sony', 'ninebot': 'Segway',
    'segway': 'Segway', 'segway-ninebot': 'Segway', 'redmi': 'Xiaomi', 'poco': 'Xiaomi', 'xiaomi': 'Xiaomi',
    'mi': 'Xiaomi', 'amazfit': 'Amazfit', 'mibro': 'Mibro', 'lydsto': 'Lydsto', 'cmf': 'Nothing',
    'nothing': 'Nothing', 'soundcore': 'Anker', 'anker': 'Anker', 'meta': 'Meta', 'nintendo': 'Nintendo',
    'e-blue': 'E-Blue', 'xtrike me': 'XTRIKE ME', 'dark project': 'Dark Project', 'house of marley': 'House of Marley',
    'playseat': 'Playseat', 'razer': 'Razer', 'logitech': 'Logitech', 'gsc': 'Thermaltake',
    'karcher': 'Kärcher', 'kärcher': 'Kärcher', 'rattan': '', 'home decor': '', 'enchantimals': 'Mattel',
    'mattel': 'Mattel', 'blackview': 'Blackview', 'ulefone': 'Ulefone', 'oukitel': 'OUKITEL', 'doogee': 'DOOGEE',
    'cubot': 'CUBOT', 'infinix': 'Infinix', 'huawei': 'HUAWEI', 'motorola': 'Motorola', 'samsung': 'Samsung',
    'lenovo': 'Lenovo', 'thinkpad': 'Lenovo', 'hisense': 'Hisense', 'skyworth': 'Skyworth', 'colorview': 'ColorView',
    'allscreen': 'Allscreen', 'sbox': 'SBOX', 'jifa': 'JIFA', 'dingqi': 'DINGQI', 'wokin': 'Wokin', 'tolsen': 'TOLSEN',
    'total': 'TOTAL', 'ronix': 'RONIX', 'remeza': 'Remeza', 'schpindel': 'Schpindel', 'kotumy': 'KOTUMY',
    'gardex': 'GARDEX', 'lux garden': 'Lux Garden', 'royal turbo': 'Royal Turbo', 'royal': 'Royal', 'royal-2': 'Royal',
    'bauma': 'BAUMA', 'hecht': 'HECHT', 'eurosystems': 'Eurosystems', 'hyundai': 'Hyundai', 'storm': 'Storm',
    'aiko': 'AIKO', 'valberg': 'Valberg', 'safewell': 'Safewell', 'masterlock': 'Master Lock',
    'master lock': 'Master Lock', 'bofigo': 'BOFIGO', 'varta': 'VARTA', 'energizer': 'Energizer', 'exide': 'Exide',
    'autopower': 'AUTOPOWER', 'goodyear': 'Goodyear', 'riken': 'Riken', 'roadmarch': 'Roadmarch', 'trinx': 'TRINX',
    'totem': 'TOTEM', 'ado': 'ADO', 'kettler': 'Kettler', 'taoran': 'TAORAN', 'intex': 'Intex', 'bestway': 'Bestway',
    'llorens': 'Llorens', 'marazzi': 'Marazzi', 'brillop': 'Brillop', 'aimon': 'AIMON', 'reffon': 'Reffon',
    'fakir': 'Fakir', 'midea': 'Midea', 'zilan': 'Zilan', 'sencor': 'Sencor', 'ardesto': 'Ardesto', 'crown': 'Crown',
    'franko': 'Franko', 'ilitek': 'ILITEK', 'arshia': 'Arshia', 'kumtel': 'Kumtel', 'dysis': 'Dysis', 'nikai': 'Nikai',
    'gorenje': 'Gorenje', 'elenberg': 'Elenberg', 'itimat': 'Itimat', 'hoffmann': 'Hoffmann', 'millen': 'Millen',
    'ninja': 'Ninja', 'camry': 'Camry', 'nutribullet': 'NutriBullet', 'panasonic': 'Panasonic', 'galanz': 'Galanz',
    'stell': 'Stell', 'ultimate': 'Ultimate', 'reflecta': 'Reflecta', 'burio': 'BURIO', 'philips': 'Philips',
    'braun': 'Braun', 'remington': 'Remington', 'tefal': 'Tefal', 'rowenta': 'Rowenta', 'moulinex': 'Moulinex',
    'siemens': 'Siemens', 'korkmaz': 'Korkmaz', 'vileda': 'Vileda', 'kleaner': 'Kleaner', 'luminarc': 'Luminarc',
    'kenwood': 'Kenwood', 'epson': 'Epson', 'canon': 'Canon', 'aurzen': 'Aurzen', 'wanbo': 'Wanbo',
    'vivitek': 'Vivitek', 'yaber': 'Yaber', 'infocus': 'InFocus', 'byintek': 'BYINTEK', 'allx': 'ALLX',
    'hosseven': 'Hosseven', 'daikin': 'Daikin', 'celly': 'Celly', 'belkin': 'Belkin', 'canyon': 'Canyon',
    'genius': 'Genius', 'marvo': 'Marvo', 'havit': 'Havit', 'hoco': 'Hoco', 'nubi': 'Nubi', 'lagenio': 'Lagenio',
    'roborock': 'Roborock', 'dreame': 'Dreame', 'kukirin': 'Kukirin', 'kugoo': 'KUGOO', 'fujifilm': 'Fujifilm',
    'polaroid': 'Polaroid', 'scheppach': 'Scheppach', 'ego': 'EGO', 'dewalt': 'DEWALT', 'steamone': 'SteamOne',
    'yenkee': 'YENKEE', 'falez': 'Falez', 'naturel': 'Naturel', 'berllong': 'Berllong', 'aldridge': '',
    'deerma': 'Deerma', 'chuwi': 'CHUWI', 'manamo': 'MANAMO', 'vestel': 'Vestel', 'vestfrost': 'Vestfrost',
    'electrolux': 'Electrolux', 'indesit': 'Indesit', 'whirlpool': 'Whirlpool', 'hitachi': 'Hitachi',
    'toshiba': 'Toshiba', 'mitsubishi': 'Mitsubishi Electric', 'mitsubishi electric': 'Mitsubishi Electric',
    'haier': 'Haier', 'sharp': 'Sharp', 'grundig': 'Grundig', 'blaupunkt': 'Blaupunkt', 'thomson': 'Thomson',
    'janome': 'Janome', 'singer': 'Singer', 'brother': 'Brother', 'xerox': 'Xerox', 'gigabyte': 'GIGABYTE',
    'graetz': 'Graetz', 'fujiyama': 'Fujiyama', 'chigo': 'Chigo', 'domino': 'Domino', 'akog': 'AKOG',
    'ersel': 'Ersel', 'mayer': 'Mayer', 'hagen': 'Hagen', 'alneo': 'Alneo', 'gilan': 'Gilan', 'shinever': 'Shinever',
    'skytech': 'Skytech', 'arnica': 'Arnica', 'dixi': 'DIXI', 'kumtel ': 'Kumtel', 'keter': 'Keter',
    'luxell': 'Luxell', 'simfer': 'Simfer', 'tamkera': 'Tamkera', 'daewoo': 'Daewoo', 'regal': 'Regal',
    'arzum': 'Arzum', 'allibert': 'Allibert', 'lavor': 'Lavor', 'ariston': 'Ariston', 'zellmer': 'Zellmer',
    'tenda': 'Tenda', 'toorx': 'Toorx', 'evii': 'EVII', 'onvo': 'ONVO', 'garden star': 'Garden Star',
    'koopman': 'Koopman', 'thermex': 'Thermex', 'wadfow': 'WADFOW', 'sokany': 'Sokany', 'urevo ': 'UREVO',
    'leo': 'LEO', 'oz': 'Oz', 'group limited': '', 'nothing phone': 'Nothing', 'ud': 'UD', 'karma': 'Karma', 'hotpoint': 'Hotpoint', 'ariston thermo': 'Ariston',
    'demir dokum': 'Demirdöküm', 'nobo': 'Nobo', 'royal kludge': 'Royal Kludge', 'bort': 'BORT',
    'sigma': 'Sigma', 'iffalcon': 'iFFALCON', 'leader': 'Leader', 'dibea': 'Dibea', 'uwant': 'Uwant',
    'hobot': 'HOBOT', 'airforce': 'Airforce', 'fanon': 'Fanon', 'xtrike': 'XTRIKE ME', 'gravastar': 'GravaStar',
}

# sub-brands / product lines mentioned in titles that identify the real brand
LINE_TO_BRAND = [
    (r'\bamazfit\b', 'Amazfit'), (r'\bmibro\b', 'Mibro'), (r'\blydsto\b', 'Lydsto'),
    (r'\bredmi\b|\bpoco\b', 'Xiaomi'), (r'\bninebot\b|\bsegway\b', 'Segway'), (r'\bplaystation\b|\bdualsense\b', 'Sony'),
    (r'\bthinkpad\b|\bthinkcentre\b|\bideacentre\b|\blegion\b', 'Lenovo'), (r'\bxbox\b', 'Microsoft'),
    (r'\biphone\b|\bipad\b|\bmacbook\b|\bairpods\b|\bimac\b|\bapple\b', 'Apple'), (r'\bgalaxy\s+(?:[samz]\d|tab|buds|watch|note|fold|flip)', 'Samsung'),
    (r'\bpixel\b', 'Google'), (r'\bcmf\b', 'Nothing'), (r'\bsoundcore\b', 'Anker'), (r'\bquest\b', 'Meta'),
    (r'\benchantimals\b', 'Mattel'), (r'\bpro plan\b|\bpurina\b', 'Purina'),
]
_LINE = [(re.compile(p, re.I), b) for p, b in LINE_TO_BRAND]

# raw site brand values that are not real brands
BAD_SITE = {'', 'rattan', 'home decor', 'aldridge'}


def canon(raw):
    s = re.sub(r'\s+', ' ', (raw or '').split('|')[0]).strip()
    k = s.lower()
    if k in CANON:
        return CANON[k]
    if not s:
        return ''
    if s.isupper() and len(s) > 4:
        return ' '.join(w.capitalize() for w in s.split(' '))
    return s


def build_brand_index(names):
    """names: iterable of canonical brand names -> list of (regex, brand) longest first."""
    keys = {}
    for k, v in CANON.items():
        if v:
            keys[k.strip()] = v
    for n in names:
        if n:
            keys.setdefault(n.lower(), n)
    out = []
    for k in sorted(keys, key=len, reverse=True):
        if len(k) < 2:
            continue
        pat = re.compile(r'(?<![A-Za-z0-9])' + re.sub(r'(\\ |\\-|-| )', r'[\\s\\-]*', re.escape(k)) + r'(?![A-Za-z0-9])', re.I)
        out.append((pat, keys[k]))
    return out


def detect_from_title(title, index):
    lat = re.search(r'[A-Za-z]', title)
    if not lat:
        return ''
    for rx, b in _LINE:
        m = rx.search(title)
        if m and m.start() - lat.start() <= 12:
            return b
    best = None
    for rx, b in index:
        m = rx.search(title)
        if m and m.start() - lat.start() <= 12 and (best is None or m.start() < best[0]):
            best = (m.start(), b)
    return best[1] if best else ''
