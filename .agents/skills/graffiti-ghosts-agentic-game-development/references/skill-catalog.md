# Graffiti Ghosts Agent Skill Catalog

## Upstream sources

| Source | Use | License/status |
|---|---|---|
| [gamedev-skills/awesome-gamedev-agent-skills](https://github.com/gamedev-skills/awesome-gamedev-agent-skills) | Engine-agnostic game disciplines and platformer workflow | Apache-2.0 repository; vendored skills are reference material |
| [dart-lang/skills](https://github.com/dart-lang/skills) | Dart tests, analysis, patterns, documentation | Official Dart skills; verify upstream license before redistribution |
| [flutter/agent-plugins](https://github.com/flutter/agent-plugins) | Flutter architecture and widget/integration testing | Official Flutter skills; verify upstream license before redistribution |
| [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | SDD, TDD, planning, incremental implementation, review, debugging | Public GitHub skill source; preserve attribution and review license before redistribution |
| [Flutter Agent Skills documentation](https://docs.flutter.dev/ai/agent-skills) | Official installation/discovery conventions and progressive disclosure | Primary documentation |

## Installed routing set

- Game disciplines: `platformer`, `game-feel`, `input-systems`, `physics-tuning`, `level-design`, `game-ui-ux`, `create-game-assets`, `audio-design`, `performance-optimization`.
- Dart: `dart-add-unit-test`, `dart-run-static-analysis`, `dart-use-pattern-matching`.
- Flutter: `flutter-apply-architecture-best-practices`, `flutter-add-widget-test`, `flutter-add-integration-test`.
- Autonomous engineering: `spec-driven-development`, `planning-and-task-breakdown`, `test-driven-development`, `incremental-implementation`, `code-review-and-quality`, `debugging-and-error-recovery`.
- Project integrator: `graffiti-ghosts-agentic-game-development`.

## Explicit gaps covered by the project integrator

The upstream set does not provide a complete Flutter-specific game-physics contract, accessibility gate, music accessibility fallback, Android Native API boundary, Web/Wasm boundary, or named Loop Engineer/Graph Engineer roles. These are defined in the project integrator rather than fabricated as upstream capabilities.

## Compatibility policy

An upstream skill is not proof that an API, dependency, or engine is compatible with this project. Before adding code, verify Android, Web, WasmGC, Dart/Flutter version, performance, bundle-size, security, maintenance, and license impact. Engine-specific skills for Godot, Unity, Unreal, Phaser, PixiJS, Bevy, or other engines are not installed because Graffiti Ghosts is a native Dart/Flutter project.

## Autonomous routing

Use the project integrator first. Then load the smallest relevant upstream skills. For a movement feature, use `spec-driven-development`, `platformer`, `input-systems`, `physics-tuning`, `dart-add-unit-test`, and the Flutter test skill. For a visual asset, use `create-game-assets`, `game-ui-ux`, and the visual style guide. For a release or regression, use `code-review-and-quality`, `debugging-and-error-recovery`, `performance-optimization`, and the project CI evidence.
