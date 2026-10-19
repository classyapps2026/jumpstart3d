# Shared build settings. The app folder and third_party/ sit side by side.
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TP="${THIRD_PARTY:-$HERE/../third_party}"
# esbuild: $ESBUILD if set, else one on the PATH, else npx downloads esbuild 0.28.2
if [ -n "$ESBUILD" ]; then ESB="$ESBUILD"; elif command -v esbuild >/dev/null 2>&1; then ESB=esbuild; else ESB="npx --yes esbuild@0.28.2"; fi
ALIAS="--alias:replicad=$TP/replicad/src/index.ts --alias:replicad/shape-functions=$TP/replicad/src/shapeFunctions/index.ts --alias:opentype.js=$TP/opentype.js/dist/opentype.module.js --alias:flatbush=$TP/flatbush/index.js --alias:flatqueue=$TP/flatqueue/index.js --alias:manifold-3d=$TP/manifold-3d/index.js --alias:replicad-opencascadejs=$TP/replicad-opencascadejs/dist/replicad_single.js --alias:three=$TP/three/build/three.module.js"
