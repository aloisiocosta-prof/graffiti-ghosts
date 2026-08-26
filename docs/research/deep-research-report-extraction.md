# Deep Research Report — Structured Extraction

## Provenance

This extraction is derived from the versioned source [`docs/references/deep-research-report.md`](../references/deep-research-report.md), which is the user-provided research report for the Shipaton 2026 proposal.[DR-1]

The report is treated as a **methodological source**, not as an automatic product specification, because several examples refer to Shipaton, puzzle-platformers, ads, RevenueCat, and generic sample products rather than confirmed Graffiti Ghosts decisions.[DR-1]

## Core frameworks extracted

| ID | Framework | Operational rule | Application status |
|---|---|---|---|
| FR-01 | Spec-driven development | Model each feature as input, state, rules, output, feedback, failure, recovery, and acceptance criteria before implementation.[DR-1] | ADOPTED |
| FR-02 | Question-driven authoring | Every design section must state purpose, questions, decision, rationale, evidence, dependencies, and acceptance criteria.[DR-1] | ADOPTED |
| FR-03 | Agent contracts | Each agent must define role, inputs, outputs, preconditions, postconditions, failure modes, decision gates, and telemetry.[DR-1] | ADOPTED |
| FR-04 | Player-first sequencing | Advance through player, experience, gameplay, systems, progression, economy, monetization, requirements, architecture, platform, and code.[DR-1] | ADOPTED |
| FR-05 | Product-to-entitlement mapping | RevenueCat products must map to entitlements, and entitlements must gate features; products must not directly unlock domain behavior.[DR-1] | CONDITIONAL |
| FR-06 | Lifecycle state modeling | Cold start, loading, playing, pause, background, resume, sync, error, and termination must have explicit transitions and recovery rules.[DR-1] | ADOPTED |
| FR-07 | Asset contract | Every asset needs an ID, purpose, dimensions, format, naming, source/license, readability criteria, and code/document references.[DR-1] | ADOPTED |
| FR-08 | Telemetry-first KPIs | Events, triggers, parameters, privacy constraints, and KPI relationships are specified before instrumentation.[DR-1] | ADOPTED |
| FR-09 | Decision and risk register | Major decisions and risks use stable IDs, rationale, evidence, alternatives, dependencies, impact, owner, and status.[DR-1] | ADOPTED |

## Rules adopted for Graffiti Ghosts

The project will not treat generic report examples as Graffiti Ghosts requirements without explicit client confirmation.[DR-1]

The existing Graffiti Ghosts core loop remains the project-specific design authority: `Infiltrate → Stealth/Acrobatics → Steal → Escape → Ghost Comparison → Upgrade/Retry`.[GG-1]

The current dependency constraint is stricter than the generic report: the application runtime may use only Dart native libraries and Flutter SDK native packages unless a separate compatibility decision approves an exception.[GG-2]

The Web target is Flutter Web compiled with WasmGC, and Web/Wasm-specific APIs must remain behind platform adapters.[GG-2]

RevenueCat, ads, subscriptions, premium currencies, and other monetization examples remain **VALIDATION REQUIRED** unless the project decision register explicitly approves them.[DR-1]

## Anti-patterns identified

| Anti-pattern | Prevention |
|---|---|
| Coding before design gates | Require a specification, decision ID, acceptance criteria, and test plan before implementation.[DR-1] |
| Silent assumptions | Label every unresolved item as `[ASSUMPTION]` or `[VALIDATION REQUIRED]`.[GG-2] |
| Direct product-to-feature coupling | Use `Domain Port → Monetization Adapter → RevenueCat SDK` only if monetization is approved.[DR-1] |
| Platform APIs in shared domain code | Keep Android, Web, Wasm, channels, `dart:io`, `dart:ffi`, `dart:html`, and legacy JS interop outside domain/application.[GG-2] |
| Generic sample values becoming requirements | Preserve examples as examples and record project-specific decisions separately.[DR-1] |
| Telemetry without privacy boundaries | Use anonymous identifiers and avoid personal data unless a documented legal/privacy decision exists.[DR-1] |
| Asset production without a visual target | Require a visual-style decision and asset metadata before importing or generating assets.[GG-2] |

## Implementation gates

A feature may enter implementation only when its upstream design questions have answers, its decision status is explicit, its acceptance criteria are testable, and its platform impact is recorded.[DR-1]

A feature is complete only after focused tests, full tests, static analysis, relevant Android/Web/Wasm validation, accessibility review, and traceability updates pass.[GG-2]

## Source labels

`[DR-1]` identifies the user-provided research report.[DR-1]

`[GG-1]` identifies the existing Graffiti Ghosts core-loop contract.[GG-1]

`[GG-2]` identifies the existing Graffiti Ghosts agentic-development rules.[GG-2]

## References

[DR-1]: ../references/deep-research-report.md "User-provided deep research report"
[GG-1]: ../core-loop-design.md "Graffiti Ghosts core-loop design"
[GG-2]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic game-development skill"
