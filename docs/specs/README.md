# Graffiti Ghosts — Specifications Catalog

## Operating rule

Each specification answers purpose, questions, decision, rationale, evidence, dependencies, acceptance criteria, status, and references, following the question-driven model extracted from the research report.[DR-1]

Generic examples from the report are never copied into production requirements without a Graffiti Ghosts decision ID.[DR-1]

## Catalog

| Specification | Scope | Gate | Status |
|---|---|---|---|
| [`lifecycle.md`](lifecycle.md) | Application/game states and recovery | Lifecycle tests | CREATED |
| [`economy.md`](economy.md) | Resources, faucets, sinks, pacing, scarcity | Economy simulation | CREATED / OPEN QUESTIONS |
| [`monetization-revenuecat.md`](monetization-revenuecat.md) | Product → entitlement → feature | Client approval | CREATED / VALIDATION REQUIRED |
| [`telemetry.md`](telemetry.md) | Events, parameters, privacy, KPIs | Provider and consent approval | CREATED / VALIDATION REQUIRED |
| [`dependency-matrix.md`](dependency-matrix.md) | Dart/Flutter/Android/Web/WasmGC compatibility | Static analysis and platform builds | CREATED |
| [`asset-registry.json`](asset-registry.json) | Asset metadata, usage, provenance, license | Asset review | CREATED / VALIDATION REQUIRED |

## Feature contract template

```markdown
## Feature ID and name

**Purpose:** Why the feature exists for the player.

**Questions:** What player intent, input, state, transition, feedback, reward, failure, recovery, accessibility, and platform behavior must be clarified?

**Decision:** [CLIENT DECISION] or [AGENT RECOMMENDATION].

**Evidence:** GDD section, prototype result, test, telemetry, or external source.

**Dependencies:** Specs, graph nodes, assets, adapters, and issues.

**Acceptance criteria:** Observable and testable conditions.

**Status:** CONFIRMED, ASSUMPTION, CONFLICT, RISK, or VALIDATION REQUIRED.
```

## References

[DR-1]: ../references/deep-research-report.md "User-provided deep research report"
