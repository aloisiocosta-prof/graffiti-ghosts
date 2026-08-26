# Agent Skills — Graffiti Ghosts

## Purpose

This repository vendors a focused set of Agent Skills for autonomous development of Graffiti Ghosts. The project integrator is `.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md`; it routes game design, gameplay, art, audio, accessibility, Flutter/Dart implementation, testing, and autonomous engineering work.

## Verified sources

| Source | Role in this project | URL |
|---|---|---|
| `gamedev-skills/awesome-gamedev-agent-skills` | Engine-agnostic platformer, game feel, input, physics tuning, level design, UI/UX, assets, audio, performance | [GitHub repository](https://github.com/gamedev-skills/awesome-gamedev-agent-skills) |
| `dart-lang/skills` | Official Dart unit testing, static analysis, and language-pattern guidance | [GitHub repository](https://github.com/dart-lang/skills) |
| `flutter/agent-plugins` | Official Flutter architecture, widget testing, and integration testing guidance | [GitHub repository](https://github.com/flutter/agent-plugins) |
| `addyosmani/agent-skills` | Spec-driven development, planning, TDD, incremental implementation, code review, debugging | [GitHub repository](https://github.com/addyosmani/agent-skills) |
| Flutter documentation | Official installation and progressive-disclosure model for Dart/Flutter Agent Skills | [Agent skills for Flutter and Dart](https://docs.flutter.dev/ai/agent-skills) |

## Installed skills

| Area | Installed skills |
|---|---|
| Game development | `platformer`, `game-feel`, `input-systems`, `physics-tuning`, `level-design`, `game-ui-ux`, `create-game-assets`, `audio-design`, `performance-optimization` |
| Dart | `dart-add-unit-test`, `dart-run-static-analysis`, `dart-use-pattern-matching` |
| Flutter | `flutter-apply-architecture-best-practices`, `flutter-add-widget-test`, `flutter-add-integration-test` |
| Autonomous engineering | `spec-driven-development`, `planning-and-task-breakdown`, `test-driven-development`, `incremental-implementation`, `code-review-and-quality`, `debugging-and-error-recovery` |
| Graffiti Ghosts integration | `graffiti-ghosts-agentic-game-development` |

## Project-specific extensions

The integrator adds explicit roles and contracts not found as a complete upstream bundle: **Game Director**, **Game Designer**, **Game Programmer**, **Game Tester**, **Game Artist**, **Audio/Music Designer**, **Accessibility Designer**, **Loop Engineer**, and **Graph Engineer**. It also defines deterministic game math and physics requirements, Android Native API boundaries, Web/Wasm boundaries, accessibility gates, and a Flutter Clean Architecture/Ports & Adapters policy.

## Excluded skills

Engine-specific skills for Godot, Unity, Unreal, Phaser, PixiJS, Bevy, LÖVE, Pygame, Roblox, and other engines were intentionally excluded. They are not compatible with the current native Dart/Flutter implementation and could cause agents to introduce incorrect APIs or project structure.

## Compatibility and licensing rule

Vendored content is treated as upstream reference material and must not be silently modified. Before redistributing or changing a vendored skill, inspect the upstream repository license and preserve attribution. New Graffiti Ghosts-specific guidance belongs in the project integrator or its references. For every dependency or API proposed by an agent, record Android, Web, WasmGC, Dart/Flutter, performance, bundle-size, security, maintenance, and license impact.

## Validation

The project integrator passed the skill structure validator. The vendored skills are kept as Markdown `SKILL.md` files under `.agents/skills/` so compatible agents can discover them using the project-local convention documented by Flutter.
