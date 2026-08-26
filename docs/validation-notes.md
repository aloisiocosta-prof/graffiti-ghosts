# Mermaid Diagram Validation Notes

## Syntax

All four C4 source files and all fourteen UML source files rendered successfully with the project Mermaid renderer on 2026-08-26.

## Visual Inspection

The rendered C1 context diagram is legible at high resolution and clearly separates the player, Graffiti Ghosts system, Android platform, Web/Wasm platform, and optional rewarded-ad capability. The optional advertising relationship is labeled as a monetization-port interaction, preserving the native-only MVP boundary.

The rendered C3 component diagram is legible and communicates the separation between application use cases, domain services, and ports. It is vertically tall because the renderer lays out many components, but the labels and relationships remain readable at the generated resolution.

## Fidelity Notes

Mermaid provides native support for class, state, sequence, flowchart, and chart-style representations. Composite structure, deployment, object, package, profile, use case, communication, interaction overview, and timing are represented as explicitly labeled projections. The README and traceability matrix document these approximations rather than claiming native UML 2.x grammar support.

## Follow-up

If diagrams are used in a formal UML toolchain, the projection files should be treated as communication artifacts and optionally recreated in a dedicated UML modeling tool while preserving the same source requirements and identifiers.

## Alignment Increment Validation — 2026-08-26

The authoritative GitHub Actions run for PR #21 was `33006667875` on commit `8fb6ddc`. It passed the following gates: Flutter analyze, Flutter TDD tests, `dart format` check, `git diff --check`, Conventional Commits, secret scan, Web/Wasm release build, Android APK release build, and Web/Wasm smoke/bundle audit.

| Evidence | Result |
|---|---|
| Flutter analyze | PASS |
| Flutter unit/widget tests | PASS |
| Web/Wasm release build | PASS |
| Android APK release build | PASS |
| Web/Wasm HTTP/browser smoke | PASS |
| Web/Wasm bundle | 64,925 KB total; 29,751 KB Wasm; within 70,000 KB and 40,000 KB thresholds |
| Domain/application prohibited-import scan | PASS |
| Real-device gameplay and visual contrast audit | VALIDATION REQUIRED |

The initial performance gate failed because all concept references were bundled, producing 96,438 KB. Two Conventional Commits narrowed the runtime manifest to the five assets used by the current slice, reducing the final bundle to 64,925 KB and restoring the gate. This is evidence for the documented rule that concept references must not enter the production bundle unless used at runtime.

## Repository and Web/Wasm Hardening Validation — 2026-08-26

| Check | Result |
|---|---|
| `main` protection API | PASS: pull request review, one approval, strict required checks, admin enforcement, conversation resolution |
| Force push on `main` | BLOCKED |
| Deletion of `main` | BLOCKED |
| Required CI contexts | PASS: Flutter Analyze and TDD; Conventional Commits; Secret Scan; Build Web Wasm; Build Android APK; Web/Wasm Performance and Bundle Audit |
| Hardening CI run | PASS: [33008783709](https://github.com/aloisiocosta-prof/graffiti-ghosts/actions/runs/33008783709) |
| Web/Wasm custom bootstrap | PASS: `web/flutter_bootstrap.js` is preserved by the build and uses `forceSingleThreadedSkwasm: true` |
| Public Pages COOP/COEP headers | NOT PRESENT: expected for current GitHub Pages deployment; multithreaded Skwasm is not claimed |

The public Pages response returned `HTTP/2 200` but did not include `Cross-Origin-Opener-Policy` or `Cross-Origin-Embedder-Policy`. This confirms that the current deployment cannot enable WebAssembly threads. The explicit single-threaded bootstrap is therefore the correct compatibility behavior until a header-capable host is selected and validated.
