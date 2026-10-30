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
    'leo': 'LEO', 'oz': 'Oz', 'group limited': '', 'nothing phone': 'Nothing',
    'zalman': 'Zalman',
    'deepcool': 'DeepCool',
    'kingston': 'Kingston',
    'babyliss': 'BaByliss',
    'cuisinart': 'Cuisinart',
    'sandisk': 'SanDisk',
    'atem': 'ATEM',
    'apacer': 'Apacer',
    'fsp': 'FSP',
    'moes': 'MOES',
    'kakusiga': 'KAKUSIGA',
    'ddpai': 'DDPAI',
    'panzerglass': 'PanzerGlass',
    'tvc': 'TVC',
    'kandao': 'Kandao',
    'svc': 'SVC',
    'apc': 'APC',
    'nilox': 'NILOX',
    'arctic': 'ARCTIC',
    'nzxt': 'NZXT',
    'sonorous': 'Sonorous',
    '70mai': '70mai',
    'dimplex': 'Dimplex',
    'hutools': 'HuTools',
    'aquafilter': 'Aquafilter',
    'krups': 'Krups',
    'gigaset': 'Gigaset',
    'xilence': 'Xilence',
    'borofone': 'Borofone',
    'oudiobop': 'OUDIOBOP',
    'tecnoware': 'Tecnoware',
    'chieftec': 'Chieftec',
    'thomas': 'Thomas',
    'crucial': 'Crucial',
    'adata': 'ADATA',
    'western digital': 'WD',
    'wd': 'WD',
    'seagate': 'Seagate',
    'transcend': 'Transcend',
    'lexar': 'Lexar',
    'corsair': 'Corsair',
    'cooler master': 'Cooler Master',
    'be quiet!': 'be quiet!',
    'be quiet': 'be quiet!',
    'thermalright': 'Thermalright',
    'lian li': 'Lian Li',
    'montech': 'Montech',
    'gamemax': 'GameMax',
    '1stplayer': '1STPLAYER',
    'aerocool': 'Aerocool',
    'eaton': 'Eaton',
    'powercom': 'Powercom',
    'mercusys': 'Mercusys',
    'id-cooling': 'ID-COOLING',
    'fractal design': 'Fractal Design',
    'phanteks': 'Phanteks',
    'patriot': 'Patriot',
    'teamgroup': 'TEAMGROUP',
    'verbatim': 'Verbatim',
    'toshiba': 'Toshiba',
    'hikvision': 'Hikvision',
    'xiaomi 70mai': '70mai',
    'tuya': 'Tuya',
    'gigamax': 'GigaMax',
    'snaige': 'Snaige',
    'amica': 'Amica',
    'wmf': 'WMF',
    'kodak': 'Kodak',
    'd-link': 'D-Link',
    'unitek': 'Unitek',
    'mdv': 'MDV',
    'varmilo': 'Varmilo',
    'lambert': 'Lambert',
    'eca': 'ECA',
    'parex': 'Parex',
    'aquaverso': 'AquaVerso',
    'topstrong': 'Topstrong',
    "li'l woodzeez": "Li'l Woodzeez",
    'driven': 'Driven',
    'foxy dry': 'Foxydry',
    'foxydry': 'Foxydry',
    'screechers wild': 'Screechers Wild',
    'squirrel': 'Squirrel',
    'hotelline': 'Hotelline',
    'edifier': 'Edifier',
    'runo': 'Runo',
    'ttec': 'ttec',
    'hansa': 'Hansa',
    'steelseries': 'SteelSeries',
    'mchose': 'MCHOSE',
    'terra': 'Terra',
    'infinity nado': 'Infinity Nado',
    'topmaster': 'Topmaster',
    'magplayer': 'Magplayer',
    'gadget': 'Gadget',
    'dobe': 'DOBE',
    'b.toys': 'B. toys',
    'b. toys': 'B. toys',
    'lori': 'Lori',
    'vievo': 'VIEVO',
    'rev&roll': 'Rev&Roll',
    'arya': 'Arya',
    'ballu': 'Ballu',
    'weofly': 'Weofly',
    'tesy': 'Tesy',
    'italtherm': 'Italtherm',
    'ducky': 'Ducky',
    'goldstar': 'Goldstar',
    'veito': 'Veito',
    'monkart': 'Monkart',
    'truper': 'Truper',
    'shuft': 'Shuft',
    'potensic': 'Potensic',
    'sollex': 'Sollex',
    'aeno': 'AENO',
    'weibopro': 'WEIBOPRO',
    'baymak': 'Baymak',
    'eurogold': 'EuroGold',
    'xtrfy': 'Xtrfy',
    'dream machines': 'Dream Machines',
    'gazillion': 'Gazillion',
    'janod': 'Janod',
    'prity': 'Prity',
    'mova': 'MOVA',
    'andaseat': 'AndaSeat',
    'zanussi': 'Zanussi',
    'ferroli': 'Ferroli',
    'louis pascal': 'Louis Pascal',
    'goliath': 'Goliath',
    'shilz': 'SHILZ',
    'toolmak': 'Toolmak',
    'biostar': 'BIOSTAR',
    'cron': 'Cron',
    'sime': 'Sime',
    'airfel': 'Airfel',
    'decorall': 'Decorall',
    'metabo': 'Metabo',
    'sarayli': 'Sarayli',
    'zotac': 'ZOTAC',
    'tineco': 'Tineco',
    'mizudo': 'Mizudo',
    'jabra': 'Jabra',
    'cemsan': 'Cemsan',
    'baxi': 'BAXI',
    'goki': 'goki',
    'kieslect': 'Kieslect',
    'viper': 'Viper',
    'deli': 'Deli',
    'pretul': 'Pretul',
    'stanley': 'Stanley',
    'termica': 'Termica',
    'cansus': 'Cansus',
    'maysa': 'Maysa',
    'silverlit': 'Silverlit',
    'lexmark': 'Lexmark',
    'jedel': 'Jedel',
    'kratki': 'Kratki',
    'koss': 'Koss',
    'ricoh': 'Ricoh',
    'viessmann': 'Viessmann',
    'make it real': 'Make It Real',
    'same toy': 'Same Toy',
    'super wings': 'Super Wings',
    'zeno': 'Zeno',
    'macro': 'Macro',
    'ea sports': 'EA',
    'la sommeliere': 'La Sommelière',
    'home line': 'Home Line', 'ud': 'UD', 'karma': 'Karma', 'hotpoint': 'Hotpoint', 'ariston thermo': 'Ariston',
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


# video games: publisher is the brand
GAMES = [
    (r'last of us|horizon|gran turismo|uncharted|god of war|spider-man|ratchet|astro bot|ghost of|demon.s souls|returnal|death stranding', 'Sony'),
    (r"assassin.?s creed|far cry|watch dogs|prince of persia|just dance", 'Ubisoft'),
    (r'\bgta\b|grand theft auto|red dead', 'Rockstar Games'), (r'mafia|nba 2k|borderlands|wwe 2k', '2K'),
    (r'need for speed|ea sports|\bfc ?2\d\b|\bufc\b|battlefield|\bfifa\b|it takes two|star wars jedi', 'EA'),
    (r'witcher|cyberpunk', 'CD PROJEKT RED'), (r'hogwarts|mortal kombat|lego batman|suicide squad', 'Warner Bros. Games'),
    (r'resident evil|street fighter|monster hunter|devil may cry', 'Capcom'), (r'hitman', 'IO Interactive'),
    (r'plague tale', 'Focus Entertainment'), (r'hot wheels unleashed|motogp|ride \d', 'Milestone'),
    (r'minecraft', 'Mojang'), (r'elden ring|tekken|dragon ball|ace combat', 'Bandai Namco'),
    (r'final fantasy|kingdom hearts', 'Square Enix'), (r'call of duty|crash bandicoot|tony hawk', 'Activision'),
    (r'mario|zelda|pok[eé]mon|kirby|splatoon', 'Nintendo'),
]
_GAMES = [(re.compile(p, re.I), b) for p, b in GAMES]
_GAME_CTX = re.compile(r'\bgame\b|\bps[45]\b|playstation [45]|nintendo switch|xbox|^თამაში', re.I)
_GENERIC_LEAD = re.compile(r'^(?:(?:bluetooth|usb|wi-?fi|mesh|adsl2\+|all[\s-]*in[\s-]*one|[345]g|lte|type-c|rgb|ssd|hdd|m\.2|nvme)[\s,/-]*)+', re.I)
WINDOW = 14


def detect_from_title(title, index):
    if _GAME_CTX.search(title):
        for rx, b in _GAMES:
            if rx.search(title):
                return b
    lat = re.search(r'[A-Za-z0-9]*[A-Za-z]', title)
    if not lat:
        return ''
    start = lat.start()
    # skip generic Latin words that often precede the brand ("Bluetooth მაუსი HP ...")
    rest = title[start:]
    g = _GENERIC_LEAD.match(rest)
    if g:
        m2 = re.search(r'[A-Za-z]', rest[g.end():])
        if m2:
            start = start + g.end() + m2.start()
    for rx, b in _LINE:
        m = rx.search(title)
        if m and abs(m.start() - start) <= WINDOW:
            return b
    best = None
    for rx, b in index:
        m = rx.search(title, max(0, start - 1))
        if m and m.start() - start <= WINDOW and (best is None or m.start() < best[0]):
            best = (m.start(), b)
    return best[1] if best else ''
