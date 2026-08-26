# 08 — TECHNICAL SPECIFICATION

## 1. Technology Constraints

| Item | Decision |
|---|---|
| Language | Dart |
| Framework | Flutter |
| Shared runtime dependencies | Dart native libraries and Flutter SDK native packages only |
| Android | Native Flutter app with platform adapters when capabilities are needed |
| Web | Flutter Web compiled with `flutter build web --wasm` / WasmGC |
| Hosting | Cloudflare Worker serving `build/web` |
| External SDKs | Prohibited in shared code; exceptions require ADR and compatibility matrix |

## 2. Architecture Contract

`[CONFLICT]` A arquitetura alvo é Clean Architecture + Ports & Adapters, mas a implementação atual inspecionada ainda está concentrada em `lib/main.dart`; a separação abaixo é o estado desejado e requer Issue/PR próprio antes de ser considerada implementada.[5]

```text
Presentation
    ↓
Application
    ↓ ports
Domain
    ↓ ports
Infrastructure
    ├── Android adapter → MethodChannel/EventChannel/BasicMessageChannel → Kotlin/Android SDK
    └── Web/Wasm adapter → package:web / dart:js_interop → Browser APIs
```

Domain and application must not import Android, Web, Wasm, Flutter platform channels, `dart:io`, `dart:ffi`, `dart:html`, `dart:js`, `dart:js_util` or `package:js`.[5]

## 3. Package Matrix

| Package/API | Purpose | Android | Web | WasmGC | Risk | Alternative | Status |
|---|---|---:|---:|---:|---|---|---|
| `dart:async`, `dart:collection`, `dart:convert`, `dart:math`, `dart:typed_data` | Shared logic | Yes | Yes | Yes | Low | None needed | APPROVED |
| `package:flutter/*` | UI/rendering/input | Yes | Yes | Yes | Low | None needed | APPROVED |
| `package:web` | Web adapter APIs | No | Yes | Validate | Medium | None legacy | GATED |
| `dart:js_interop` | Web adapter interop | No | Yes | Validate | Medium | None legacy | GATED |
| RevenueCat | Monetization | Conditional | Conditional | Conditional | High | Native store adapter | NOT APPROVED |

## 4. Platform Matrix

| Feature | Android | Web-JS | Web-WasmGC | Decision |
|---|---:|---:|---:|---|
| Raid rules/rendering | Yes | Yes | Yes | Shared Dart/Flutter |
| Android billing | Conditional | No | No | Only after monetization approval |
| Browser APIs | No | Yes | Validate | Web adapter only |
| Ghost replay/score | Yes | Yes | Yes | Deterministic shared logic |
| COOP/COEP | N/A | Hosting concern | Hosting concern | Worker headers configured |

## 5. Persistence

| Data | Format | Frequency | Recovery | Authority |
|---|---|---|---|---|
| Current raid snapshot | `[DECIDIR]` | Checkpoint/background | Retry or resume | Local until policy approved |
| Hideout progression | `[DECIDIR]` | Reward resolution | Restore from durable source | `[DECIDIR]` |
| Entitlement | Provider response if approved | On purchase/restore | User-triggered restore | External authority |

## 6. Performance Budgets

Startup, frame budget, memory, asset size and network budget remain `[VALIDATION REQUIRED]`; current Web/Wasm performance evidence is tracked by `docs/web-wasm-load-performance-plan.md`.[4]

## 7. Current Alignment Gap

The current repository contains a playable vertical slice in `lib/main.dart`, but it does not yet materialize the complete `domain/application/infrastructure/presentation` directory boundary described above.[4] [5]

This is an implementation gap, not a new design decision, and must be tracked separately from this documentation update.

## 8. Technical Decision Rule

Nenhuma dependência entra no projeto sem purpose, compatibility Android/Web/WasmGC, maintenance, risk, license, bundle impact e alternative.[1] [5]

## References

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[4]: ../technical-and-demo-spec.md "Graffiti Ghosts technical and demo specification"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
