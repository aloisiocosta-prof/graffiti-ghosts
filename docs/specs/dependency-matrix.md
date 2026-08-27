# Dependency and Platform Compatibility Matrix

## Policy

Application runtime code uses Dart native libraries and Flutter SDK native packages only, as required by the current project constraint.[GG-1]

Any exception requires a decision record covering Android, Web-JS, Web-WasmGC, Flutter/Dart versions, performance, bundle size, security, maintenance, license, and native alternatives.[GG-1]

## Approved baseline

| Dependency/API | Layer | Android | Web-JS | Web-WasmGC | Status |
|---|---|---:|---:|---:|---|
| `dart:async` | Shared | Yes | Yes | Yes | APPROVED |
| `dart:collection` | Shared | Yes | Yes | Yes | APPROVED |
| `dart:convert` | Shared | Yes | Yes | Yes | APPROVED |
| `dart:math` | Shared | Yes | Yes | Yes | APPROVED |
| `dart:typed_data` | Shared | Yes | Yes | Yes | APPROVED |
| `dart:isolate` | Shared/conditional | Yes | Validation required | Validation required | GATED |
| `package:flutter/*` | Shared/presentation | Yes | Yes | Yes | APPROVED |
| `package:web` | Web adapter only | No | Yes | Validation required | GATED |
| `dart:js_interop` | Web adapter only | No | Yes | Validation required | GATED |
| `MethodChannel` | Android adapter only | Yes | No | No | GATED |
| `dart:io` | Platform-specific only | Yes | No | No | FORBIDDEN in shared code |
| `dart:ffi` | Platform-specific only | Yes | No | No | FORBIDDEN in shared code |
| `dart:html` | Legacy Web API | No | Legacy | No | FORBIDDEN |
| `dart:js` / `dart:js_util` | Legacy JS interop | No | Legacy | No | FORBIDDEN |
| `package:js` | Legacy JS interop | No | Legacy | No | FORBIDDEN |
| RevenueCat SDK | External monetization | Conditional | Conditional | Conditional | VALIDATION REQUIRED |

## Build contract

The Web build must use `flutter build web --wasm --release` and produce validated artifacts under `build/web`.[GG-1]

The Cloudflare Worker must publish only the generated static artifact and must not introduce npm packages into the application dependency graph.[GG-1]

## Architecture boundary

```text
Shared domain/application
  ↓ ports
Infrastructure platform adapters
  ├─ Android: Flutter channels → Kotlin → Android SDK
  └─ Web/Wasm: package:web / dart:js_interop → browser APIs
```

## Acceptance criteria

Static analysis fails if forbidden APIs appear in shared domain/application code.[GG-1]

CI records Android and Web/Wasm build evidence for every platform-sensitive change.[GG-1]

A dependency cannot be added without a compatibility and maintenance decision.[GG-1]

## References

[GG-1]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic game-development skill"
