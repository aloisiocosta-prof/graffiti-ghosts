# Graffiti Ghosts — Diagram Traceability Matrix

## C4 Traceability

| Diagram | Source sections | Main concepts represented | Status |
|---|---|---|---|
| C1 Context | Technical Mandate; Platform Boundary; Monetization Boundary | Player, game system, Android, Web/Wasm, optional rewarded ads | GENERATED |
| C2 Containers | Architecture; Project Structure; Native API Policy | Presentation, application, domain, ports, infrastructure, platform adapters | GENERATED |
| C3 Components | Project Structure; Domain Model; TDD Strategy | Raid use cases, domain services, repositories, monetization port | GENERATED |
| C4 Code | Domain Model; Design Patterns; Data Structures; Algorithms | Entities, value objects, services, ports, factories and score model | GENERATED |

## UML Traceability

| UML diagram | Source sections | Main concepts represented | Mermaid fidelity | Status |
|---|---|---|---|---|
| Class | Domain Model and Invariants; Design Patterns | Raid, Thief, Fortress, GhostRun, GhostScore, progression | Native class semantics | GENERATED |
| Component | Architecture; Layer Responsibilities | Presentation, Application, Domain, Ports, Infrastructure | Component projection | GENERATED |
| Composite Structure | Architecture; Domain Model | Raid aggregate, internal parts and ports | Approximation with flowchart | GENERATED |
| Deployment | Platform Boundary; Native API Policy | Android device, browser, runtimes, artifacts and local saves | Approximation with flowchart | GENERATED |
| Object | Domain Model; Ghost Score | Concrete raid, thief, fortress, ghost and score instances | Approximation with class instances | GENERATED |
| Package | Project Structure | Presentation, application, domain and infrastructure packages | Approximation with subgraphs | GENERATED |
| Profile | SOLID; Design Patterns; Architecture | Entity, value object, service, port and adapter stereotypes | Stereotype projection | GENERATED |
| Activity | Core raid behavior; Domain invariants | Selection, infiltration, graffiti, chase, capture, escape and rewards | Native flowchart semantics | GENERATED |
| State Machine | Domain invariants; Raid outcome rules | Ready, infiltrating, chasing, captured, checkpoint, completed and rewarded | Native state semantics | GENERATED |
| Use Case | Core Loop; Monetization Boundary | Select, infiltrate, move, graffiti, escape, steal, compare, upgrade, customize | Actor/use-case projection | GENERATED |
| Communication | Application Components; Ports | Numbered collaboration among player, UI, use cases, domain and repository | Message-number projection | GENERATED |
| Interaction Overview | Core Loop; TDD acceptance flow | High-level interaction fragments for a raid | Activity-style projection | GENERATED |
| Sequence | Application Components; Domain invariants | Ordered raid collaboration and reward claim | Native sequence semantics | GENERATED |
| Timing | Raid duration; State Machine; Vertical Slice | Time-oriented state progression during a raid | Approximation with xychart | GENERATED |

## Requirement-to-Diagram Coverage

| Requirement / invariant | C4 diagrams | UML diagrams |
|---|---|---|
| `RAID-OUTCOME-001` Capture loses treasure and resets | C3, C4 | Activity, State, Sequence |
| `RAID-OUTCOME-002` Detection starts chase | C2, C3, C4 | Activity, State, Sequence |
| `RAID-OUTCOME-003` Alternative route enables escape | C3, C4 | Activity, State, Communication |
| `RAID-OUTCOME-004` Second chance resumes with penalties | C3, C4 | Activity, State, Sequence |
| `GHOST-SCORE-001` 40/40/20 score | C3, C4 | Class, Object, Sequence, Timing |
| `GHOST-SCORE-002` Ad bonus does not affect score | C1, C2, C3 | Use Case, Sequence, Activity |
| `GRAFFITI-001` Limited graffiti activation | C3, C4 | Activity, State, Sequence |
| `GRAFFITI-002` Route/platform/trap effects | C3, C4 | Composite Structure, Activity, Sequence |
| `GHOST-REPLAY-001` Ghost is recorded silhouette | C1, C3, C4 | Object, Class, Sequence |
| Native-only MVP boundary | C1, C2, C3 | Component, Package, Deployment, Profile |
| SOLID, ports and adapters | C2, C3, C4 | Component, Class, Package, Profile |
| TDD and spec-driven workflow | C3, C4 | Activity, Interaction Overview, Sequence |

## Refactored Context Traceability

| Context artifact | Source / decision | Implementation or validation target | Status |
|---|---|---|---|
| `docs/research/deep-research-report-extraction.md` | User-provided research report | Process rules, anti-patterns, gates | CREATED |
| `docs/governance/agent-orchestration.md` | FR-01, FR-02, FR-03; ADR-001, ADR-002 | Issue, PR, and agent handoff workflow | CREATED |
| `docs/governance/decision-register.yaml` | Client constraints and report-derived decisions | Review gate for design and technical changes | CREATED |
| `docs/governance/risk-register.yaml` | Report risk patterns and current project risks | Risk review before implementation/release | CREATED |
| `docs/specs/lifecycle.md` | FR-06; ADR-007 | Lifecycle unit/widget/integration tests | CREATED |
| `docs/specs/economy.md` | FR-04; ADR-003 | Economy simulation and reward tests | CREATED |
| `docs/specs/monetization-revenuecat.md` | FR-05; ADR-005 | Conditional RevenueCat adapter and entitlement tests | CREATED / VALIDATION REQUIRED |
| `docs/specs/telemetry.md` | FR-08; ADR-008 | Schema validation and privacy review | CREATED / VALIDATION REQUIRED |
| `docs/specs/dependency-matrix.md` | ADR-004, ADR-006 | Static analysis and Android/Web/WasmGC builds | CREATED |
| `docs/specs/asset-registry.json` | FR-07; existing visual-style guide | Asset provenance, license, and readability review | CREATED / VALIDATION REQUIRED |
| `docs/context-refactor.md` | All above artifacts | Master context and backlog routing | CREATED |

## Status semantics

`CONFIRMED` means the project has an explicit decision or existing GDD evidence.

`VALIDATION REQUIRED` means the item is intentionally documented but cannot enter implementation without client approval or evidence.

`ASSUMPTION` means a temporary working hypothesis that must not be treated as a requirement.

`NOT APPLICABLE` must include a reason and must not be silently omitted from the GDD.

## References

[DR-1]: references/deep-research-report.md "User-provided deep research report"
[GG-1]: core-loop-design.md "Graffiti Ghosts core-loop design"
[GG-2]: ../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic game-development skill"
