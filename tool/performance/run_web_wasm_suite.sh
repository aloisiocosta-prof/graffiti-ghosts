#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="${1:-build/web}"
REPORT_DIR="${2:-performance/reports}"
mkdir -p "$REPORT_DIR"

export MAX_TOTAL_KB="${MAX_TOTAL_KB:-60000}"
export MAX_WASM_KB="${MAX_WASM_KB:-40000}"
export MAX_REGRESSION_PERCENT="${MAX_REGRESSION_PERCENT:-15}"

./tool/performance/web_wasm_smoke.sh "$BUILD_DIR" "$REPORT_DIR"
./tool/performance/audit_bundle_size.sh "$BUILD_DIR" "$REPORT_DIR"

wasm_count=$(find "$BUILD_DIR" -type f -name '*.wasm' | wc -l | tr -d ' ')
if [[ "$wasm_count" -lt 1 ]]; then
  echo "No Wasm artifact found in $BUILD_DIR" >&2
  exit 1
fi

python3 - "$REPORT_DIR/smoke.json" "$REPORT_DIR/bundle-size.json" "$REPORT_DIR/performance-summary.md" "$wasm_count" <<'PY'
import json
import sys
from pathlib import Path

smoke = json.load(open(sys.argv[1]))
bundle = json.load(open(sys.argv[2]))
wasm_count = sys.argv[4]
status = "PASS" if smoke["status"] == "PASS" else "FAIL"
lines = [
    "# Web/Wasm Performance Suite",
    "",
    f"**Status:** `{status}`",
    "",
    "This PR gate validates deterministic build/runtime smoke and bundle-size constraints. Frame-time profiling remains a scheduled or manual profile-mode activity on real hardware.",
    "",
    "| Check | Result |",
    "|---|---|",
    f"| Local HTTP server response | {smoke['httpStatus']} |",
    f"| Server ready time | {smoke['serverReadyMs']} ms |",
    f"| Wasm artifacts | {wasm_count} |",
    f"| Total bundle | {bundle['totalKb']} KB / {bundle['thresholds']['maxTotalKb']} KB |",
    f"| Wasm bundle | {bundle['wasmKb']} KB / {bundle['thresholds']['maxWasmKb']} KB |",
    f"| Bundle regression | {bundle['regressionPercent']:.2f}% / {bundle['thresholds']['maxRegressionPercent']:.2f}% |",
    "",
    "## Interpretation",
    "",
    "The gate is intentionally deterministic for pull requests. Use Chrome DevTools Performance recordings and a physical Android device for frame pacing, input latency, memory and jank analysis described in the performance plan.",
]
Path(sys.argv[3]).write_text("\n".join(lines) + "\n")
PY
