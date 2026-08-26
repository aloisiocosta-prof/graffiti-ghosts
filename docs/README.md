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
