# 11 — TRACEABILITY + DECISION LOG

## 1. Requirement IDs

`GD` game design, `ECO` economy, `MON` monetization, `UX` UX/UI, `ART` assets, `AUD` audio, `LIF` lifecycle, `ENG` engineering, `QA` quality and `REL` release.[1]

## 2. Traceability Matrix

| Requirement | Source | Decision | Spec | Implementation | Test | Status |
|---|---|---|---|---|---|---|
| GD-001 Core loop | `docs/core-loop-design.md` | ADR-003 | GDD-01/GDD-02 | `lib/main.dart` | QA-001–QA-007 | CONFIRMED |
| GD-002 Score 40/40/20 model | Existing project tests | Existing decision | GDD-02 | `lib/main.dart`, `test/score_test.dart` | score tests | CONFLICT: UI getter lacks explicit upper clamp |
| GD-003 Graffiti action | Existing project context | Existing decision | GDD-02/GDD-07 | `lib/main.dart`, assets | QA-003 | CONFIRMED |
| ECO-001 Treasure/hideout | Existing GDD context | Open tuning | GDD-03 | Current raid state | QA-006/QA-007 | OPEN |
| MON-001 RevenueCat | Research pattern only | ADR-005 | GDD-04 | No adapter yet | Conditional tests | VALIDATION REQUIRED |
| LIF-001 Lifecycle | Research + project rules | ADR-007 | GDD-05 | Adapter/tests pending | Lifecycle matrix | OPEN |
| UX-001 Raid HUD | Existing visual references | Existing visual decision | GDD-06/GDD-07 | `lib/main.dart` | Widget/smoke | CONFIRMED |
| ENG-001 Native-only dependencies | Client constraint | ADR-004 | GDD-08 | `pubspec.yaml` | CI/import scan | CONFIRMED |
| ENG-003 Clean Architecture materialization | Project rules | ADR-006 | GDD-08 | `lib/main.dart` currently monolithic | Architecture review | CONFLICT / OPEN |
| ENG-002 WasmGC deployment | Client/platform context | Cloudflare ADR | GDD-08 | `tool/cloudflare/build.sh` | Workers Build | CONFIRMED |

## 3. Decision Log

| ID | Decision | Rationale | Evidence | Dependencies | Impact | Status |
|---|---|---|---|---|---|---|
| ADR-001 | Spec-driven workflow | Prevent code from silently deciding design | Research report | All GDD specs | Adds gates | ACCEPTED |
| ADR-002 | Question-driven GDD | Expose unknowns and acceptance | Research report | GDD sections | Standardizes docs | ACCEPTED |
| ADR-003 | Retain Graffiti Ghosts core loop | Generic report loop is not this game | Existing core loop | Game Spec | Protects identity | ACCEPTED |
| ADR-004 | Dart/Flutter SDK-only runtime | WasmGC/platform compatibility and client constraint | User context/Tech Spec | Dependency matrix | Rejects unapproved packages | ACCEPTED |
| ADR-005 | Monetization conditional | No explicit product/pricing decision | Research examples only | Economy/platform | Blocks RevenueCat code | VALIDATION REQUIRED |
| ADR-006 | Clean Architecture + adapters | Prevent platform leakage | Project rules | Tech Spec | Defines module boundaries | ACCEPTED / IMPLEMENTATION GAP |
| ADR-007 | Explicit lifecycle machine | Protect state/reward integrity | Research report | Persistence policy | Adds recovery tests | ACCEPTED |
| ADR-008 | Anonymous telemetry schema-first | Avoid privacy and coupling risks | Research report | Provider/consent | Instrumentation gated | VALIDATION REQUIRED |

## 4. ADR Template

### ADR-[NNN] — [TITLE]

**Context:** [SOURCE FACT]

**Problem:** [UNKNOWN/CONFLICT]

**Options:** documented alternatives.

**Decision:** `[CLIENT DECISION]` or `[AGENT RECOMMENDATION]`.

**Rationale:** evidence-linked explanation.

**Consequences:** implementation, platform, economy, UX and test impact.

**Status:** PROPOSED, ACCEPTED, SUPERSEDED or VALIDATION REQUIRED.

## References

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
