# Lifecycle Specification — Graffiti Ghosts

## Purpose

This specification defines application and game lifecycle behavior so pause, background, resume, recovery, persistence, and optional monetization do not remain implicit in widgets.[DR-1]

## States

| State | Entry trigger | Allowed actions | Exit condition | Recovery rule |
|---|---|---|---|---|
| `cold_start` | Process launch | Initialize services and immutable configuration | Initialization succeeds or fails | Failure enters `fatal_error` with retry/diagnostic path |
| `loading` | Initialization accepted | Load local assets, game configuration, and required fonts | Assets and config ready | Missing optional asset uses documented fallback |
| `ready` | Loading complete | Show menu, input focus, accessibility controls | Player starts raid | Preserve deterministic seed/config snapshot |
| `playing` | Raid starts | Movement, stealth, acrobatics, graffiti, theft, escape | Success, fail, pause, or lifecycle interruption | Snapshot safe state at checkpoint boundaries |
| `paused` | User pause or recoverable interruption | Resume, restart, quit | Resume or explicit navigation | Do not advance simulation while paused |
| `background` | App loses foreground | Persist safe state and release transient resources | App resumes or terminates | Resume through `syncing` only if a service requires it |
| `syncing` | Resume with approved sync requirement | Reconcile approved external state | Sync succeeds or fails | Gameplay may continue offline when design permits |
| `completed` | Escape and score resolution | Show score, ghost comparison, reward, upgrade/retry | Upgrade, retry, menu | Rewards are idempotent by attempt ID |
| `failed` | Detection/failure condition | Show feedback, retry, checkpoint, or exit | Retry or navigation | Failure cannot corrupt progression |
| `fatal_error` | Non-recoverable initialization/runtime error | Diagnostic, retry, safe exit | Retry succeeds or app exits | Never silently discard player progress |
| `terminated` | Process termination | None | New cold start | Persist only validated durable state |

## Transition invariants

The simulation timer and input processing stop in `paused` and `background` states.[DR-1]

The domain does not know Flutter lifecycle classes, Android contexts, browser APIs, platform channels, RevenueCat SDK types, or storage implementations.[GG-1]

Purchases and entitlements, if approved later, transition to active access only after authoritative confirmation, and restoration remains user-initiated.[DR-1]

Retry and reward processing must be idempotent so repeated lifecycle callbacks cannot duplicate score, treasure, or progression.[DR-1]

## Acceptance criteria

A unit test covers every state transition that affects score, reward, persistence, or retry.[GG-1]

A widget or integration test verifies pause/resume behavior on Android and Web where the test environment supports the lifecycle event.[GG-1]

A failure test demonstrates that an interrupted raid resumes or safely returns to a known checkpoint without corrupting progression.[DR-1]

## Status

`[CONFIRMED]` State modeling is adopted as project governance.[DR-1]

`[VALIDATION REQUIRED]` Exact persistence policy, checkpoint frequency, and offline behavior require product decisions before implementation.[DR-1]

## References

[DR-1]: ../references/deep-research-report.md "User-provided deep research report"
[GG-1]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic game-development skill"
