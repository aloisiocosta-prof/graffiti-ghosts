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
