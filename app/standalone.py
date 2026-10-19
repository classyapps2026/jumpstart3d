import base64, os
ROOT = os.path.dirname(os.path.abspath(__file__))
d = ROOT + '/dist/'
html=open(d+'index.html').read()
app=open(d+'app.js').read(); worker=open(d+'worker.iife.js').read()
b64=base64.b64encode(open(d+'occt-gz.wasm','rb').read()).decode()
for s in (app,worker): assert '</script' not in s.lower()
inline=('<script type="text/plain" id="wp-worker-src">'+worker+'</script>\n<script type="text/plain" id="wp-occt">'+b64+'</script>\n<script type="module">'+app+'</script>')
tag='<script type="module" src="app.js"></script>'
assert tag in html
out='<!doctype html>\n<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,viewport-fit=cover"><meta name="apple-mobile-web-app-capable" content="yes"><meta name="mobile-web-app-capable" content="yes"><meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"><meta name="format-detection" content="telephone=no"></head><body>\n'+html.replace(tag,inline)+'\n</body></html>\n'
open(ROOT + '/jumpstart-3d.html','w').write(out)
open(d+'standalone.html','w').write(out)
print(round(len(out)/1e6,2),"MB")
