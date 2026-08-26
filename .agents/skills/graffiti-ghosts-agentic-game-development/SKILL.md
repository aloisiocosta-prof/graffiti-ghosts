---
name: graffiti-ghosts-agentic-game-development
description: Orchestrates autonomous game-development agents for Graffiti Ghosts and similar Flutter Android/Web/Wasm games. Use when designing, implementing, testing, reviewing, balancing, documenting, or shipping gameplay with spec-driven development, loop engineering, graph engineering, Clean Architecture, SOLID, TDD, accessibility, and platform-specific adapters.
---

# Graffiti Ghosts Agentic Game Development

Use this skill as the project router and source of truth for autonomous work on **Graffiti Ghosts**, a short-session stealth platformer built with native Dart/Flutter for Android and Web/Wasm.

## Operating contract

1. Read the relevant project documents before changing behavior: `docs/concept-brief.md`, `docs/core-loop-design.md`, `docs/technical-and-demo-spec.md`, `docs/visual-style-guide.md`, `docs/traceability-matrix.md`, and the active task specification.
2. Classify every statement as `[SOURCE FACT]`, `[CLIENT DECISION]`, `[AGENT RECOMMENDATION]`, `[ASSUMPTION]`, `[VALIDATION REQUIRED]`, or `[RISK]`. Never convert a recommendation into a decision silently.
3. For any change larger than a trivial correction, run the gated sequence: **SPECIFY → PLAN → TASKS → IMPLEMENT → TEST → REVIEW → VERIFY**.
4. Preserve traceability: every implementation task references a specification, a decision ID, acceptance criteria, tests, and affected graph nodes.
5. Prefer a thin vertical slice. Keep the game playable after each increment.

## Role router

| Agent role | Primary responsibility | Required outputs |
|---|---|---|
| Game Director | Vision, scope, pillars, trade-offs, release criteria | Decision log, scope gate, milestone acceptance |
| Game Designer | Fantasy, core loop, mechanics, progression, economy, difficulty | Mechanics spec, tuning table, player-facing rationale |
| Loop Engineer | Formalize action-feedback-reward loops and retention loops | Loop graph, state transitions, measurable hypotheses |
| Graph Engineer | Model dependencies, C4/UML, traceability, build order, no-cycle boundaries | Mermaid source, dependency graph, impact map |
| Game Programmer | Dart/Flutter implementation and platform ports | Domain/application code, adapters, tests |
| Game Tester | TDD, widget/integration/smoke/performance/accessibility verification | Test matrix, evidence, regression report |
| Game Artist | Visual target, asset families, readability, production constraints | Asset brief, acceptance checklist, source-to-asset links |
| Audio/Music Designer | Musical identity, adaptive layers, feedback hierarchy, accessibility | Audio brief, event map, mute/volume fallback rules |
| Accessibility Designer | Inclusive controls, contrast, motion/audio alternatives, assistive semantics | Accessibility requirements and test cases |

One agent may hold several roles, but the role boundaries and outputs remain explicit.

## Game-design pipeline

Follow this order and stop when an upstream decision is unresolved:

`PLAYER → EXPERIENCE → GAMEPLAY → SYSTEMS → PROGRESSION → ECONOMY → MONETIZATION → REQUIREMENTS → ARCHITECTURE → PLATFORM → CODE`

For each mechanic, record player intent and fantasy; input, state, transition, feedback, reward, failure, recovery; interaction with stealth, acrobatics, magical graffiti, ghost replay, score, treasure, and base upgrades; accessibility alternatives; tuning variables and safe ranges; unit/widget/integration tests; and Android/Web/Wasm compatibility status.

### Core-loop contract

The short loop must remain legible:

`Infiltrate → Stealth/Acrobatics → Steal → Escape → Ghost Comparison → Upgrade/Retry`

The first 60 seconds must demonstrate movement, an obstacle, a reward, and one memorable magical-graffiti moment. A loop change is not complete until the action-feedback-reward chain is observable in the game and documented in `docs/core-loop-design.md`.

### Loop Engineer method

Represent every loop as a directed graph with named nodes and edges. For each edge define trigger, player decision, system response, feedback channel, reward, failure state, and retry path. Track hypotheses such as “route choice increases mastery” separately from measured results. Use deterministic IDs such as `LOOP-CORE-01`, `MECH-GRAFFITI-01`, and `REWARD-GHOST-01`.

Do not use engagement language as evidence. Validate fun, clarity, and pacing through playable tests, observation, and telemetry when available.

### Graph Engineer method

Maintain dependency direction:

`domain → application → infrastructure/platform → presentation`

The domain and application layers must not import Android, Web, Wasm, Flutter platform channels, SDK purchase APIs, `dart:io`, `dart:ffi`, `dart:html`, or legacy JavaScript interop. Model platform-specific behavior behind ports and adapters. Use Mermaid for accurate relationship diagrams and keep the source file beside the rendered artifact.

For a multi-capability change, create a capability map before implementation:

| Module | Responsibility | Depends on |
|---|---|---|
| player-movement | movement state and tuning | — |
| stealth-raid | detection, routes, pursuit | player-movement |
| ghost-replay | deterministic attempt recording and comparison | stealth-raid |
| progression-economy | treasure, reputation, storage, upgrades | ghost-replay |
| platform-adapters | Android channels and Web/Wasm APIs | application |

No dependency cycle is acceptable. If two modules require each other, reconsider the boundary before coding.

## Flutter/Dart implementation rules

- Use native Dart/Flutter SDK APIs by default; do not add a package without a compatibility and maintenance decision.
- Use Clean Architecture, Ports & Adapters, SOLID, small responsibilities, immutable value objects where practical, and Object Calisthenics as a review heuristic rather than a dogma.
- Use `dart:math`, `dart:convert`, `dart:typed_data`, `dart:async`, and official Flutter libraries only when justified by the design.
- Android: expose native capabilities through a domain port, an infrastructure adapter, Flutter `MethodChannel`/`EventChannel`/`BasicMessageChannel`, Kotlin, and Android SDK. Never leak `Activity`, `Context`, `FlutterEngine`, `FlutterJNI`, or channel types into domain/application.
- Web/Wasm: use `package:web` and `dart:js_interop` only in the Web adapter. Never introduce `dart:html`, `dart:js`, `dart:js_util`, `package:js`, `dart:io`, or `dart:ffi` into shared code.
- Keep game math deterministic where replay, score, ghost comparison, or tests depend on it. Define units, coordinate system, timestep, rounding policy, and random seed policy.
- Keep physics parameters data-driven: acceleration, terminal velocity, jump impulse, gravity, coyote time, wall-grab duration, slide duration, collision tolerance, and detection radius must be named and testable.
- Use factory methods for controlled creation and singleton only for a genuinely process-wide stateless service with a testable reset/injection strategy. Do not use singleton as a substitute for dependency injection.

## Accessibility gate

Every player-facing mechanic must provide an equivalent path where feasible: remappable controls and touch targets with sufficient size; no dependence on color alone for detection, score, or route readability; reduced motion for camera shake, graffiti effects, and chase feedback; independent music, ambience, SFX, and voice/alert volume controls; visual substitutes for critical audio cues and audio substitutes for critical visual cues; readable HUD, contrast, scalable text, focus/semantics behavior on Web; and pause, checkpoint, retry, and second-chance behavior understandable without reflex-only timing.

Accessibility is part of the acceptance criteria, not a post-release polish task. Add tests for semantics, keyboard/focus access where applicable, contrast/readability, and reduced-motion behavior.

## Art and audio gates

Art agents must start from the approved visual target and asset family. Every generated or imported asset records role, dimensions, transparency, animation frames, naming, license/source, and in-game readability. Do not generate a new visual style for a single asset without a style decision.

Audio agents must map each gameplay event to priority, channel, fallback, and interruption policy. Music must support the urban-fantasy identity and short sessions without masking critical stealth or detection cues. Players must be able to disable music and effects independently while retaining critical information through another channel.

## Testing and autonomous execution

Use TDD for behavioral changes:

1. Write a failing focused test from the specification.
2. Implement the smallest behavior that passes.
3. Refactor without changing behavior.
4. Run focused tests, then the full test suite.
5. Run analysis, Web/Wasm build, Android build, smoke test, bundle audit, and accessibility checks as applicable.
6. Have the code-review role evaluate correctness, architecture, security, performance, readability, and regression risk before merge.

For failures, stop feature work, preserve logs and reproduction steps, identify the root cause, add a regression test, and only then resume.

## Definition of done

A task is complete only when the specification and decision log are updated; acceptance criteria are testable and satisfied; domain/application boundaries remain platform independent; tests and static analysis pass; relevant Android and Web/Wasm compatibility is evidenced; performance and bundle impact are recorded; accessibility impact is reviewed; diagrams and traceability are updated when relationships change; and the change is reviewable as a small conventional-commit increment.

## Source routing

This integrator uses the project GDD as the authoritative design source and delegates procedural guidance to these vendored upstream skills in `.agents/skills/`:

- game-dev: `platformer`, `game-feel`, `input-systems`, `physics-tuning`, `level-design`, `game-ui-ux`, `create-game-assets`, `audio-design`, `performance-optimization`;
- official Dart: `dart-add-unit-test`, `dart-run-static-analysis`, `dart-use-pattern-matching`;
- official Flutter: `flutter-apply-architecture-best-practices`, `flutter-add-widget-test`, `flutter-add-integration-test`;
- engineering: `spec-driven-development`, `planning-and-task-breakdown`, `test-driven-development`, `incremental-implementation`, `code-review-and-quality`, `debugging-and-error-recovery`.

Treat vendored upstream content as reference material. Do not silently modify it; put Graffiti Ghosts-specific rules in this integrator or its references.
