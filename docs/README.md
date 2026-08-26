# Graffiti Ghosts — Mermaid Architecture and UML Catalog

## Purpose

This directory converts the current technical specification of Graffiti Ghosts into Mermaid source diagrams. The catalog covers all four levels of the C4 model used by this project and the 14 UML 2.x diagram types.

## Source of Truth

Primary source: `technical-and-demo-spec.md` v0.2. The diagrams are visual projections of the specification and must not introduce new product requirements. Unresolved items remain marked as open or validation-required in the accompanying notes.

## C4 Coverage

| Level | File | Mermaid representation |
|---|---|---|
| C1 — System Context | `c4/c1-system-context.mmd` | `C4Context` |
| C2 — Containers | `c4/c2-containers.mmd` | `C4Container` |
| C3 — Components | `c4/c3-components.mmd` | `C4Component` |
| C4 — Code | `c4/c4-code.mmd` | `classDiagram` as code-level projection |

## UML 2.x Coverage

The UML 2.x catalog contains the 14 standard diagram types. Mermaid has native support for only a subset, so unsupported types are represented with the closest semantically honest Mermaid syntax and explicitly labeled as an approximation.

| # | UML 2.x type | File | Mermaid strategy |
|---:|---|---|---|
| 1 | Class | `uml/01-class.mmd` | Native `classDiagram` |
| 2 | Component | `uml/02-component.mmd` | Native `C4Component` / component-style projection |
| 3 | Composite Structure | `uml/03-composite-structure.mmd` | `flowchart` with ports and internal parts |
| 4 | Deployment | `uml/04-deployment.mmd` | `flowchart` with nodes and artifacts |
| 5 | Object | `uml/05-object.mmd` | `classDiagram` with object instances |
| 6 | Package | `uml/06-package.mmd` | `flowchart` subgraphs |
| 7 | Profile | `uml/07-profile.mmd` | `classDiagram` stereotypes and extensions |
| 8 | Activity | `uml/08-activity.mmd` | Native `flowchart` |
| 9 | State Machine | `uml/09-state-machine.mmd` | Native `stateDiagram-v2` |
| 10 | Use Case | `uml/10-use-case.mmd` | `flowchart` actor/use-case projection |
| 11 | Communication | `uml/11-communication.mmd` | `flowchart` numbered message links |
| 12 | Interaction Overview | `uml/12-interaction-overview.mmd` | `flowchart` interaction fragments |
| 13 | Sequence | `uml/13-sequence.mmd` | Native `sequenceDiagram` |
| 14 | Timing | `uml/14-timing.mmd` | `xychart-beta` timing projection, labeled approximation |

## Approximation Policy

Mermaid is not a complete UML 2.x authoring tool. For UML types without a dedicated Mermaid diagram grammar, the files preserve the relevant semantics—elements, relationships, ordering, states, nodes, ports, stereotypes, or timing—while labeling the notation as a projection. These diagrams should be treated as architecture communication artifacts, not as claims that Mermaid natively implements every UML 2.x metamodel construct.

## Validation

Each `.mmd` source should be rendered with the project utility or Mermaid-compatible renderer. Validation must check syntax, readable labels, directionality, and consistency with the technical specification. The traceability matrix is in `traceability-matrix.md`.

## Refactored Context Catalog

The operational context is indexed by [`context-refactor.md`](context-refactor.md), which separates product decisions from research methods, assumptions, risks, and validation gates.

The research source and structured extraction are [`references/deep-research-report.md`](references/deep-research-report.md) and [`research/deep-research-report-extraction.md`](research/deep-research-report-extraction.md).

Governance artifacts are [`governance/agent-orchestration.md`](governance/agent-orchestration.md), [`governance/skill-catalog.md`](governance/skill-catalog.md), [`governance/decision-register.yaml`](governance/decision-register.yaml), and [`governance/risk-register.yaml`](governance/risk-register.yaml).

Design and platform specifications are cataloged in [`specs/README.md`](specs/README.md), including lifecycle, economy, conditional RevenueCat monetization, telemetry, dependency compatibility, and asset metadata.

The traceability matrix now maps these artifacts to GDD sources, implementation targets, tests, Issues, Pull Requests, and status semantics.

## GDD Master Package

The adapted 13-document GDD package is available under [`gdd/`](gdd/), beginning with [`00-GDD-MASTER-README.md`](gdd/00-GDD-MASTER-README.md). The package is aligned with the current Graffiti Ghosts core loop, vertical slice, native Dart/Flutter dependency constraint, Android/Web/WasmGC targets, Cloudflare deployment, and current open decisions.
