import json, sys, urllib.request
from concurrent.futures import ThreadPoolExecutor
UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Safari/537.36"
feed = json.load(open(sys.argv[1], encoding='utf-8'))['feed']
def chk(r):
    u = r['image_link']
    for _ in range(2):
        try:
            req = urllib.request.Request(u, method='HEAD', headers={'User-Agent': UA})
            with urllib.request.urlopen(req, timeout=30) as resp:
                return r['id'], u, resp.status, resp.headers.get('Content-Type', ''), resp.headers.get('Content-Length', '')
        except urllib.error.HTTPError as e:
            return r['id'], u, e.code, '', ''
        except Exception as e:
            err = repr(e)
    return r['id'], u, -1, err, ''
with ThreadPoolExecutor(8) as ex, open(sys.argv[2], 'w') as fo:
    for res in ex.map(chk, feed):
        fo.write(json.dumps(res) + '\n')
print('done')
