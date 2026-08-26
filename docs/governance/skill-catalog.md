# Skill Catalog — Graffiti Ghosts

Each skill is treated as a reusable capability with inputs, outputs, preconditions, failure modes, acceptance criteria, and references, following the research report’s contract model.[DR-1]

| Skill ID | Capability | Inputs | Outputs | Primary agent | Status |
|---|---|---|---|---|---|
| `SKILL-VISION` | Vision and concept | Client brief, audience, references | Vision, pillars, USP, scope gate | Game Director | ADOPTED |
| `SKILL-CORE-GAMEPLAY` | Core gameplay and loop | Vision, player verbs, mechanics | Core-loop spec, loop graph, failure/retry rules | Game Designer / Loop Engineer | ADOPTED |
| `SKILL-SYSTEMS` | Systems and state modeling | Loop graph, entities, invariants | State machine, system boundaries, tuning variables | Systems Designer | ADOPTED |
| `SKILL-PROGRESSION` | Progression and difficulty | Raid outcomes, rewards, content | Progression curves, difficulty gates, tests | Game Designer | ADOPTED |
| `SKILL-ECONOMY` | Economy balancing | Progression, rewards, costs | Faucet/sink model, simulation, balance evidence | Economy Designer | ADOPTED |
| `SKILL-MONETIZATION` | Ethical monetization | Approved economy and platform scope | Conditional monetization spec | Monetization Designer | CONDITIONAL |
| `SKILL-REVENUECAT` | Entitlement integration | Approved products and offers | Product→entitlement→feature mapping, adapter contract | Monetization / Technical Architect | CONDITIONAL |
| `SKILL-LIFECYCLE` | Lifecycle and recovery | Platform events, persistence policy | State machine, recovery tests | Lifecycle Engineer | ADOPTED |
| `SKILL-UX-ACCESSIBILITY` | UX, controls, accessibility | Player flows, mechanics, platform input | Screen spec, control alternatives, accessibility tests | UX / Accessibility Designer | ADOPTED |
| `SKILL-ASSET-PIPELINE` | Asset production and provenance | Visual target, asset registry | Metadata, source/license, import checklist | Asset Producer | ADOPTED |
| `SKILL-TELEMETRY` | Event and KPI design | Feature contracts, privacy policy | Event schema, KPI map, validation tests | Technical Architect / QA | CONDITIONAL |
| `SKILL-FLUTTER-ARCHITECTURE` | Clean Architecture and adapters | Approved specs, platform capabilities | Ports, adapters, dependency matrix | Technical Architect | ADOPTED |
| `SKILL-WASM-COMPATIBILITY` | Flutter Web/WasmGC compatibility | Dependency matrix, browser targets | Build evidence, forbidden-API checks | Web/Wasm Engineer | ADOPTED |
| `SKILL-TDD-VALIDATION` | Spec-driven test validation | Acceptance criteria, risks | Unit/widget/integration/smoke evidence | QA Engineer | ADOPTED |
| `SKILL-RELEASE` | Release and deployment | Verified artifacts, platform checklists | Android package, Worker deploy, rollback notes | Release Manager | ADOPTED |

## Skill reuse policy

Use existing vendored skills under `.agents/skills/` before creating a new skill, and put Graffiti Ghosts-specific rules in the integrator skill or project documents rather than modifying upstream skill content.[GG-1]

A new skill is justified only when its inputs, outputs, gate, and acceptance criteria are materially different from an existing capability.[DR-1]

## References

[DR-1]: ../references/deep-research-report.md "User-provided deep research report"
[GG-1]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic game-development skill"
