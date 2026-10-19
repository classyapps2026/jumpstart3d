set -e
cd "$(dirname "${BASH_SOURCE[0]}")"
. ./build.sh
mkdir -p dist
WASM="$TP/replicad-opencascadejs/dist/replicad_single.wasm"
[ -f dist/occt-gz.wasm ] || gzip -9 -n -c "$WASM" > dist/occt-gz.wasm
SIZE=$(stat -c %s dist/occt-gz.wasm)
$ESB tools/three-global.js --bundle --format=iife --minify --legal-comments=eof --target=es2020 --outfile=tools/three-global.min.js $ALIAS --log-level=error
python3 tools/make_flexigen.py
$ESB tools/three-global-orbit.js --bundle --format=iife --minify --legal-comments=eof --target=es2020 --outfile=tools/three-global-orbit.min.js $ALIAS --log-level=error
python3 tools/make_meshstep.py
python3 tools/make_chisel.py
$ESB src/app.js --loader:.html=text --bundle --format=esm --minify --legal-comments=eof --target=es2020 --outfile=dist/app.js $ALIAS --log-level=warning "--define:__WASM_PARTS__=[{\"url\":\"occt-gz.wasm\",\"gz\":true,\"size\":$SIZE}]"
$ESB src/worker.js --bundle --format=esm --minify --legal-comments=eof --target=es2020 --outfile=dist/worker.js --external:node:* $ALIAS --log-level=warning
cp src/index.html dist/index.html
ls -la dist
$ESB src/worker.js --bundle --format=iife --minify --legal-comments=eof --target=es2020 --outfile=dist/worker.iife.js --external:node:* $ALIAS --log-level=error
