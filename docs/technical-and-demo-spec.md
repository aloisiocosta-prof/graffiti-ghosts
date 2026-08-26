# Graffiti Ghosts — Technical and Demo Specification v0.2

## 1. Technical Mandate

Graffiti Ghosts será implementado em **Dart e Flutter usando somente bibliotecas nativas do Dart e APIs oficiais do Flutter**, sem pacotes externos no MVP. O objetivo é manter o domínio independente de plataforma, reduzir dependências, preservar compatibilidade entre Android, Web e WebAssembly e tornar cada regra do jogo verificável por testes.

A especificação adota **Clean Architecture, Clean Code, Object Calisthenics, SOLID, Test-Driven Development, Spec-Driven Development, Factory, Singleton controlado, estruturas de dados apropriadas e algoritmos determinísticos**.

A restrição “nativo” significa que o código de produção deve limitar imports a `dart:async`, `dart:collection`, `dart:convert`, `dart:math`, `dart:typed_data`, `dart:isolate` quando justificado, e APIs oficiais `package:flutter/*`. APIs específicas de plataforma só podem aparecer em adapters isolados, quando forem indispensáveis e compatíveis com o alvo correspondente.

## 2. Source of Truth and Specification Workflow

A especificação do GDD é a fonte de verdade do produto. Cada requisito implementável deve possuir um identificador, critérios de aceitação e testes associados.

```text
GDD / Product Spec
        ↓
Use-case specification
        ↓
Domain contracts and invariants
        ↓
Red test
        ↓
Minimal implementation
        ↓
Refactor under Clean Code and Object Calisthenics
        ↓
Acceptance test
        ↓
Platform verification
```

### Requirement Format

Cada requisito deverá seguir este formato:

| Campo | Conteúdo obrigatório |
|---|---|
| Requirement ID | Identificador estável, por exemplo `RAID-SCORE-001` |
| Intent | Comportamento que o jogador deve perceber |
| Preconditions | Estado necessário para executar o comportamento |
| Rules | Regras de domínio e invariantes |
| Acceptance criteria | Condições observáveis de sucesso |
| Test references | Testes unitários, de contrato e de widget relacionados |
| Platform notes | Diferenças Android, Web ou Wasm, quando existirem |
| Status | `DRAFT`, `CONFIRMED`, `IMPLEMENTED`, `VALIDATED` ou `BLOCKED` |

## 3. Architecture

A arquitetura é **Clean Architecture com Ports & Adapters**. Dependências apontam para dentro; o domínio não conhece Flutter, Android, Web, Wasm, armazenamento, anúncios ou APIs de compra.

```text
presentation
    ↓
application
    ↓
domain
    ↓
ports / abstractions
    ↑
infrastructure adapters
```

### Layer Responsibilities

| Camada | Responsabilidade | Pode conhecer |
|---|---|---|
| `domain` | Entidades, value objects, regras, invariantes e serviços puros | Apenas Dart permitido e abstrações internas |
| `application` | Casos de uso, orquestração, comandos, resultados e transações | `domain` e ports |
| `presentation` | Widgets, controllers de tela, estado de apresentação e acessibilidade | `application` e APIs Flutter |
| `infrastructure` | Persistência, clock, input, áudio futuro, integração de plataforma e composição | `domain`, `application`, Dart/Flutter nativos e APIs específicas isoladas |
| `core` | Erros, resultados, identificadores, serialização e utilidades mínimas | Dart nativo; não deve virar depósito genérico |

### Project Structure

```text
lib/
├── core/
│   ├── errors/
│   ├── result/
│   ├── identifiers/
│   ├── serialization/
│   └── time/
├── domain/
│   ├── entities/
│   │   ├── thief.dart
│   │   ├── fortress.dart
│   │   ├── raid.dart
│   │   ├── ghost_run.dart
│   │   ├── treasure.dart
│   │   ├── reputation.dart
│   │   └── base_progression.dart
│   ├── value_objects/
│   ├── services/
│   │   ├── ghost_score_service.dart
│   │   ├── raid_outcome_service.dart
│   │   ├── chase_service.dart
│   │   └── progression_service.dart
│   └── ports/
│       ├── ghost_repository.dart
│       ├── fortress_repository.dart
│       ├── progression_repository.dart
│       ├── monetization_port.dart
│       └── analytics_port.dart
├── application/
│   ├── start_raid/
│   ├── update_raid/
│   ├── resolve_detection/
│   ├── activate_graffiti/
│   ├── complete_heist/
│   ├── compare_ghost/
│   ├── claim_rewards/
│   └── upgrade_base/
├── infrastructure/
│   ├── clock/
│   ├── persistence/
│   ├── fortresses/
│   ├── ghosts/
│   ├── monetization/
│   └── platform/
│       ├── android/
│       └── web/
└── presentation/
    ├── raid/
    ├── fortress_select/
    ├── results/
    ├── base/
    └── cosmetics/
```

## 4. Native API Policy

The following APIs are preferred only when they solve an identified requirement:

| Need | Approved native option |
|---|---|
| Asynchronous commands and streams | `dart:async` |
| Ordered collections and queues | `dart:collection` |
| Save data and deterministic payloads | `dart:convert` |
| Randomization and geometry utilities | `dart:math` |
| Compact replay and binary buffers | `dart:typed_data` |
| Isolated CPU work | `dart:isolate`, only after profiling demonstrates need |
| Flutter UI and input | Official `package:flutter/*` APIs |
| Android platform integration | Isolated Flutter platform-channel adapter only when required |
| Web integration | `package:web` or `dart:js_interop` only inside Web adapters, if required |

The domain and application layers must not import `dart:io`, `dart:ffi`, `dart:html`, `dart:js`, `dart:js_util`, Android classes, `BuildContext`, platform channels, or SDK-specific types. No external game engine, state-management package, serialization package, ads package, purchase package, or collection package is part of the MVP baseline.

## 5. SOLID Application

**Single Responsibility** requires each class to have one reason to change. A score calculator must not persist scores or render HUD state. **Open/Closed** requires new fortress rules or reward policies to be added through abstractions rather than by editing unrelated systems. **Liskov Substitution** requires every repository or clock implementation to preserve the contract of its port. **Interface Segregation** requires narrow ports such as `GhostReader` and `GhostWriter` instead of a universal repository interface. **Dependency Inversion** requires use cases to depend on ports and factories rather than concrete persistence or platform implementations.

## 6. Clean Code Rules

Names must express domain intent. Methods should be short and cohesive, with guard clauses for invalid states. Mutable state must be minimized and confined to the owning aggregate or application operation. Magic numbers such as score weights, chase duration, or penalty values must be named configuration values or value objects. Serialization must be explicit and versioned. Errors must be typed and handled at the application boundary.

## 7. Object Calisthenics Constraints

The MVP should apply Object Calisthenics pragmatically rather than mechanically. The default rules are:

1. One level of indentation per method.
2. Avoid `else` by using guard clauses, polymorphism, or early returns.
3. Wrap primitive values that have domain meaning, such as `TreasureAmount`, `RaidScore`, `FailureCount`, and `FortressId`.
4. Use first-class collections for groups such as `GhostRuns`, `RouteOptions`, and `RewardBundle`.
5. Keep one dot per expression where practical; avoid train-wreck navigation.
6. Do not abbreviate names.
7. Keep entities small and behavior-oriented.
8. Avoid classes with more than two instance variables unless the aggregate boundary justifies it.
9. Prefer immutable value objects and explicit state transitions.

Exceptions require a short code comment explaining why a rule would reduce readability, performance, or correctness in that specific case.

## 8. Design Patterns

### Factory

Factories create valid domain objects and isolate construction rules. Examples include `FortressFactory`, `GhostRunFactory`, `RewardBundleFactory`, and `RaidFactory`. Factories must reject invalid configurations and must not hide I/O or platform calls.

```dart
abstract interface class GhostRunFactory {
  GhostRun create(GhostRunData data);
}
```

The concrete factory belongs in the composition root or infrastructure boundary when construction depends on serialized data.

### Singleton

Singletons are permitted only for **stateless, immutable, process-wide services** whose uniqueness is a real invariant, such as a read-only configuration registry or a deterministic algorithm registry. A Singleton must not own mutable gameplay state, user progression, current raid state, or test-sensitive global data.

Preferred implementation is a private constructor with a `static final` instance. Tests must be able to reset or replace behavior through ports; therefore, gameplay services should normally be instantiated and injected instead of being Singletons. The Singleton pattern is a constrained exception, not the default dependency mechanism.

## 9. Domain Model and Invariants

The following rules are mandatory domain behavior:

| Rule ID | Invariant |
|---|---|
| `RAID-OUTCOME-001` | Capture without second chance loses collected treasure and resets the raid to its start state. |
| `RAID-OUTCOME-002` | Detection starts a chase; it is not an automatic failure. |
| `RAID-OUTCOME-003` | Escape requires selecting and reaching a valid alternative route. |
| `RAID-OUTCOME-004` | A second chance resumes from a checkpoint and applies score, time, and treasure penalties. |
| `GHOST-SCORE-001` | Initial score weights are 40% time, 40% treasure, and 20% failures. |
| `GHOST-SCORE-002` | Optional-ad treasure bonuses do not modify ghost score. |
| `GRAFFITI-001` | Graffiti activation is gated by a limited ability. |
| `GRAFFITI-002` | Graffiti can reveal secret routes, create temporary platforms/shortcuts, or alter traps. |
| `GHOST-REPLAY-001` | A ghost represents a recorded attempt and is replayed as a silhouette. |

## 10. Data Structures

| Game problem | Native structure | Reason |
|---|---|---|
| Fortress graph | `Map<NodeId, List<RouteEdge>>` or immutable adjacency representation | Efficient route lookup and alternative-route traversal |
| Shortest or safest route | `Queue` for breadth-first search; custom small binary min-heap built with `List` when weighted search is required | Supports route search without external packages or non-existent native heap types |
| Ghost input stream | `List<ReplayEvent>` or typed binary buffer for compact encoding | Deterministic ordered playback |
| Active chase events | `Queue<ChaseEvent>` | First-in, first-out event processing |
| Collected rewards | First-class `RewardBundle` collection | Encapsulates aggregation and validation |
| Base unlocks | `Set<UnlockId>` plus dependency map | Fast membership checks and prerequisite validation |
| Score breakdown | Immutable value object with named components | Prevents accidental mixing of economic and competitive values |
| Input sampling | Fixed-size ring buffer | Bounds memory while preserving recent movement history |
| Level checkpoints | Ordered list indexed by checkpoint identifier | Deterministic restart and validation |

The implementation must choose structures based on measured access patterns. A structure must not be introduced merely because it is available.

## 11. Algorithms

### Ghost Score

The score service normalizes each component into a bounded range before applying the initial weights:

```text
combinedScore = 0.40 × normalizedTime
              + 0.40 × normalizedTreasure
              + 0.20 × normalizedFailures
```

The exact direction of the failure component, normalization bounds, caps, and tie-breaking remain **VALIDATION REQUIRED**. The algorithm must be deterministic and independent of optional-ad economic bonuses.

### Route Selection

Fortresses should be modeled as a directed graph of traversal nodes and route edges. Alternative routes can be selected using breadth-first search when all transitions have equal cost, or Dijkstra-style weighted search when danger, time, graffiti state, or traversal difficulty contributes to route cost. The MVP should prefer a small authored graph over procedural generation.

### Ghost Playback

A ghost replay is an ordered sequence of timestamped input or movement events. Playback uses a deterministic fixed-step simulation. Invalid or corrupted events must fail safely and cannot grant rewards. Replay format requires a version field so future changes do not silently invalidate old ghosts.

### Collision and Detection Queries

Collision and line-of-sight checks must use simple, testable geometry primitives appropriate to the selected Flutter rendering approach. Spatial partitioning is not required for the first fortress; if profiling shows excessive queries, a grid index can reduce checks without changing domain rules.

### Complexity Targets

| Operation | Target approach | Expected complexity |
|---|---|---|
| Unlock membership | Hash set | Average O(1) |
| Route adjacency lookup | Hash map | Average O(1) lookup |
| Unweighted route search | Breadth-first search | O(V + E) |
| Weighted route search | Custom binary min-heap priority queue | O((V + E) log V) |
| Ghost playback step | Sequential event cursor | Amortized O(1) |
| Reward aggregation | Immutable fold over reward items | O(n) |

## 12. TDD Strategy

Development begins with tests for domain behavior. The minimum sequence is:

1. Write a failing test for one invariant.
2. Implement the smallest valid behavior.
3. Refactor while preserving the test.
4. Add boundary and invalid-state tests.
5. Add application use-case tests with fake ports.
6. Add widget tests for player-visible state transitions.
7. Run platform verification on Android and Web/Wasm.

Test categories include domain unit tests, property-style invariant tests implemented with deterministic example sets, application contract tests, serialization round-trip tests, widget tests, and manual device acceptance tests. Randomness must be injected behind a port or seeded value so tests remain reproducible.

## 13. Spec-Driven Acceptance Scenarios

| Scenario ID | Given | When | Then |
|---|---|---|---|
| `AC-001` | The thief enters a fortress with the three MVP movement abilities | The player reaches the first obstacle | Movement is responsive and the obstacle can be solved using the taught ability |
| `AC-002` | A guard detects the thief | The player chooses a valid alternative route | A chase occurs and the player can escape without automatic failure |
| `AC-003` | The thief has collected treasure and is captured | No second chance is used | Treasure is lost and the raid returns to its initial state |
| `AC-004` | The thief is captured and accepts a second chance | The checkpoint restart completes | The raid resumes from checkpoint and records all defined penalties |
| `AC-005` | A magical-graffiti ability is available | The player activates it | A secret route, temporary shortcut/platform, or trap alteration becomes available according to the fortress rule |
| `AC-006` | A raid is completed | The result screen is shown | Ghost silhouette, combined score, treasure, reputation, and progression are visible |
| `AC-007` | An optional treasure bonus is accepted | The reward claim is processed | Economic treasure increases while ghost score remains unchanged |

## 14. Platform Boundary

Android and Web/Wasm share domain and application code. Input, persistence, browser integration, and optional monetization are adapters. `dart:io` and `dart:ffi` are not shared dependencies. Web code must avoid legacy `dart:html`, `dart:js`, and `dart:js_util`; any browser integration must remain isolated and use the approved modern boundary when necessary.

The first implementation should keep persistence local and ghosts bundled or locally recorded until platform capabilities and synchronization requirements are explicitly decided. Monetization ports may exist as no-op or test adapters in the native-only MVP; provider integration is deferred until a compatible platform strategy is approved.

## 15. Vertical Slice Demonstration Plan

The submission video must show real gameplay on the device used to build the game, not only menus or a cinematic mock-up.

| Time | Demonstration beat | Evidence |
|---|---|---|
| 0:00–0:08 | Enter a vibrant urban-fantasy fortress with magical graffiti | Immediate art direction and fantasy |
| 0:08–0:20 | Learn the first acrobatic movement interaction | Onboarding clarity and responsiveness |
| 0:20–0:38 | Use jump, wall-grab, and slide | Core platforming |
| 0:38–0:52 | Activate limited graffiti ability | Signature mechanic |
| 0:52–1:10 | Trigger a chase and choose an alternative route | Stealth and recovery |
| 1:10–1:25 | Steal treasure and escape | Clear payoff |
| 1:25–1:45 | Show ghost silhouette and score breakdown | Asynchronous competition |
| 1:45–2:05 | Show rewards and base changes | Progression and economy |
| 2:05–2:20 | Show optional-ad flow only if implemented | Monetization fit without forced interruption |

## 16. Technical Definition of Done

A feature is complete when its specification has a stable identifier, domain invariants are covered by tests, the application use case is covered by fake-port tests, serialization is versioned where applicable, the presentation state is observable through widget tests, no prohibited dependency enters shared code, Android and Web/Wasm builds pass, and the behavior is demonstrated in the vertical slice when relevant.

## 17. Open Technical Decisions

| ID | Question | Status |
|---|---|---|
| `T-001` | Which official Flutter rendering/game-loop approach will be used without external packages? | OPEN |
| `T-002` | Which Android device will be used for the recorded demo? | OPEN |
| `T-003` | Will persistence remain local for the MVP? | OPEN |
| `T-004` | Will Web monetization be deferred? | OPEN |
| `T-005` | Will initial ghosts be bundled, locally recorded, or both? | OPEN |
| `T-006` | What are the exact score normalization bounds and second-chance penalties? | OPEN |
| `T-007` | What is the implementation of the limited graffiti ability and its cooldown? | OPEN |
