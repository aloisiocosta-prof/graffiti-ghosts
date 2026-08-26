#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="${1:-build/web}"
REPORT_DIR="${2:-performance/reports}"
PORT="${PORT:-4173}"
mkdir -p "$REPORT_DIR"

if [[ ! -d "$BUILD_DIR" ]]; then
  echo "Build directory not found: $BUILD_DIR" >&2
  exit 2
fi

python3 -m http.server "$PORT" --directory "$BUILD_DIR" >"$REPORT_DIR/http-server.log" 2>&1 &
server_pid=$!
trap 'kill "$server_pid" 2>/dev/null || true' EXIT

started=$(date +%s%3N)
http_status=""
for _ in $(seq 1 60); do
  http_status=$(curl -sS -o /dev/null -w '%{http_code}' "http://127.0.0.1:${PORT}/" || true)
  [[ "$http_status" == "200" ]] && break
  sleep 0.25
done
finished=$(date +%s%3N)
ready_ms=$((finished - started))

browser_status="SKIP"
if command -v chromium >/dev/null 2>&1; then
  if chromium --headless --no-sandbox --disable-gpu --dump-dom "http://127.0.0.1:${PORT}/" >"$REPORT_DIR/browser-dom.html" 2>"$REPORT_DIR/browser.log"; then
    browser_status="PASS"
  else
    browser_status="FAIL"
  fi
fi

python3 - "$REPORT_DIR/smoke.json" "$BUILD_DIR" "$http_status" "$ready_ms" "$browser_status" <<'PY'
import json
import sys
from pathlib import Path

output, build_dir, http_status, ready_ms, browser_status = sys.argv[1:]
status = "PASS" if http_status == "200" and browser_status in ("PASS", "SKIP") else "FAIL"
payload = {
    "status": status,
    "httpStatus": int(http_status) if http_status.isdigit() else 0,
    "serverReadyMs": int(ready_ms),
    "buildDirectory": build_dir,
    "browserSmoke": browser_status,
}
Path(output).write_text(json.dumps(payload, indent=2) + "\n")
if status != "PASS":
    raise SystemExit("Web/Wasm smoke test failed")
PY
