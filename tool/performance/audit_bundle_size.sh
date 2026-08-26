#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="${1:-build/web}"
REPORT_DIR="${2:-performance/reports}"
MAX_TOTAL_KB="${MAX_TOTAL_KB:-60000}"
MAX_WASM_KB="${MAX_WASM_KB:-25000}"
MAX_REGRESSION_PERCENT="${MAX_REGRESSION_PERCENT:-15}"
BASELINE_FILE="${BASELINE_FILE:-performance/baselines/web-wasm-bundle.json}"

mkdir -p "$REPORT_DIR"

if [[ ! -d "$BUILD_DIR" ]]; then
  echo "Build directory not found: $BUILD_DIR" >&2
  exit 2
fi

bytes_sum=0
file_count=0
wasm_bytes=0
largest_file=""
largest_bytes=0

while IFS= read -r -d '' file; do
  size=$(wc -c < "$file")
  bytes_sum=$((bytes_sum + size))
  file_count=$((file_count + 1))
  if [[ "$file" == *.wasm ]]; then
    wasm_bytes=$((wasm_bytes + size))
  fi
  if (( size > largest_bytes )); then
    largest_bytes=$size
    largest_file="${file#$BUILD_DIR/}"
  fi
done < <(find "$BUILD_DIR" -type f -print0)

total_kb=$(( (bytes_sum + 1023) / 1024 ))
wasm_kb=$(( (wasm_bytes + 1023) / 1024 ))

python3 - "$REPORT_DIR/bundle-size.json" "$BUILD_DIR" "$bytes_sum" "$total_kb" "$wasm_kb" "$file_count" "$largest_file" "$largest_bytes" "$MAX_TOTAL_KB" "$MAX_WASM_KB" "$MAX_REGRESSION_PERCENT" "$BASELINE_FILE" <<'PY'
import json
import pathlib
import sys
from datetime import datetime, timezone

(
    output, build_dir, total_bytes, total_kb, wasm_kb, file_count,
    largest_file, largest_bytes, max_total_kb, max_wasm_kb,
    max_regression_percent, baseline_file,
) = sys.argv[1:]

payload = {
    "generatedAt": datetime.now(timezone.utc).isoformat(),
    "buildDirectory": build_dir,
    "fileCount": int(file_count),
    "totalBytes": int(total_bytes),
    "totalKb": int(total_kb),
    "wasmKb": int(wasm_kb),
    "largestFile": largest_file,
    "largestFileBytes": int(largest_bytes),
    "thresholds": {
        "maxTotalKb": int(max_total_kb),
        "maxWasmKb": int(max_wasm_kb),
        "maxRegressionPercent": float(max_regression_percent),
    },
    "baselineFile": baseline_file,
}
pathlib.Path(output).write_text(json.dumps(payload, indent=2) + "\n")
PY

baseline_total_kb=""
if [[ -f "$BASELINE_FILE" ]]; then
  baseline_total_kb=$(python3 - "$BASELINE_FILE" <<'PY'
import json, sys
try:
    data = json.load(open(sys.argv[1]))
    print(data.get("totalKb", ""))
except Exception:
    print("")
PY
)
fi

regression_percent="0"
if [[ -n "$baseline_total_kb" && "$baseline_total_kb" != "0" ]]; then
  regression_percent=$(python3 - "$total_kb" "$baseline_total_kb" <<'PY'
import sys
current, baseline = map(float, sys.argv[1:])
print(f"{((current - baseline) / baseline) * 100:.2f}")
PY
)
fi

python3 - "$REPORT_DIR/bundle-size.json" "$baseline_total_kb" "$regression_percent" <<'PY'
import json, sys
path, baseline, regression = sys.argv[1:]
data = json.load(open(path))
data["baselineTotalKb"] = int(baseline) if baseline else None
data["regressionPercent"] = float(regression)
json.dump(data, open(path, "w"), indent=2)
open(path, "a").write("\n")
PY

python3 - "$REPORT_DIR/bundle-size.md" "$REPORT_DIR/bundle-size.json" <<'PY'
import json, sys
from pathlib import Path
report = json.load(open(sys.argv[2]))
status = "PASS" if report["totalKb"] <= report["thresholds"]["maxTotalKb"] and report["wasmKb"] <= report["thresholds"]["maxWasmKb"] and report["regressionPercent"] <= report["thresholds"]["maxRegressionPercent"] else "FAIL"
lines = [
    "# Web/Wasm Bundle Size Audit",
    "",
    f"**Status:** `{status}`",
    "",
    "| Metric | Value | Limit |",
    "|---|---:|---:|",
    f"| Files | {report['fileCount']} | — |",
    f"| Total | {report['totalKb']} KB | {report['thresholds']['maxTotalKb']} KB |",
    f"| Wasm | {report['wasmKb']} KB | {report['thresholds']['maxWasmKb']} KB |",
    f"| Regression | {report['regressionPercent']:.2f}% | {report['thresholds']['maxRegressionPercent']:.2f}% |",
    f"| Largest file | `{report['largestFile']}` | — |",
    "",
    "The limits are engineering gates, not measured baselines. Update the baseline only through an explicit performance decision.",
]
Path(sys.argv[1]).write_text("\n".join(lines) + "\n")
if status != "PASS":
    raise SystemExit("Bundle size gate failed")
PY
