#!/usr/bin/env bash
set -euo pipefail

# Cloudflare Workers build entrypoint for Graffiti Ghosts.
# Override FLUTTER_VERSION when the project intentionally upgrades Flutter.
FLUTTER_VERSION="${FLUTTER_VERSION:-3.35.2}"
FLUTTER_ROOT="${FLUTTER_ROOT:-${HOME}/flutter}"
FLUTTER_BASE_HREF="${FLUTTER_BASE_HREF:-/}"

if [[ ! -x "${FLUTTER_ROOT}/bin/flutter" ]]; then
  echo "Installing Flutter ${FLUTTER_VERSION} into ${FLUTTER_ROOT}..."
  rm -rf "${FLUTTER_ROOT}"
  git clone --depth 1 --branch "${FLUTTER_VERSION}" \
    https://github.com/flutter/flutter.git "${FLUTTER_ROOT}"
fi

export PATH="${FLUTTER_ROOT}/bin:${FLUTTER_ROOT}/bin/cache/dart-sdk/bin:${PATH}"

flutter config --enable-web
flutter --version
flutter pub get
flutter build web --wasm --release --base-href "${FLUTTER_BASE_HREF}"

# Fail early if Flutter did not produce the expected Wasm artifact.
test -s build/web/main.dart.wasm
test -s build/web/flutter_bootstrap.js

echo "Cloudflare Workers artifact ready: build/web"
echo "crossOriginIsolated requires the deployed response headers to be active."
