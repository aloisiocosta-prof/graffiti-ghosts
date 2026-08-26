# Project State — Game Design Document

## Intake Status

| Item | Status | Value | Evidence / Note |
|---|---|---|---|
| Genre | CLIENT DECISION | Platformer | Direct user response |
| Target platforms | CLIENT DECISION | Web/Wasm and Android | Direct user response |
| Primary reference | CLIENT INPUT | King of Thieves | Direct user response; use as a reference, not as an unconfirmed design constraint |
| Player fantasy | CLIENT DECISION | The player is an agile, exploratory thief becoming an infiltrator | Direct user response |
| First 60 seconds for judges | CLIENT DECISION | Enter fortress, learn an acrobatic skill, overcome an obstacle, complete the first perfect heist | Direct user response; exact implementation and pacing remain to validate |

## Initial Risks

| Risk ID | Risk | Impact | Status |
|---|---|---|---|
| R-001 | Platformer concept is not yet differentiated from the reference game | High | OPEN |
| R-002 | The first-minute experience still needs concrete timing, reward presentation, and a memorable visual/audio beat | Medium | OPEN |
| R-003 | Web/Wasm and Android constraints may affect controls, performance, and monetization integration | Medium | OPEN |

## Decision Log

| Decision ID | Decision | Reason | Source | Alternatives | Impact | Status |
|---|---|---|---|---|---|---|
| D-001 | The project will target a platformer experience | User selected the genre | Client response | Other genres | Defines gameplay and level-design exploration | CONFIRMED |
| D-002 | The project will support Web/Wasm and Android | User selected the platforms | Client response | Android only; Web only | Requires platform-neutral domain/application layers and adapter evaluation | CONFIRMED |
| D-003 | The game will center on stealth-oriented asynchronous raids | Fits the thief/infiltrator fantasy and short-session target | Client response | Precision platforming; puzzle-platforming; real-time multiplayer | Defines the core-loop candidates and content model | CONFIRMED |
| D-004 | The game will be single-player | User selected the structure | Client response | Asynchronous competitive; real-time multiplayer | Requires AI/ghost/opponent representation if raids are competitive | CONFIRMED |
| D-005 | Target sessions should be under three minutes | Supports mobile-friendly short sessions | Client response | 3–5 minutes; 5–10 minutes | Constrains level length, onboarding, reward cadence, and demo pacing | CONFIRMED |
| D-006 | The first-minute onboarding is a fortress entry, acrobatic skill tutorial, obstacle traversal, and first perfect heist | Creates a compact demonstration of movement, progression, challenge, and payoff | Client response | Alternative onboarding sequences | Becomes the primary vertical-slice showcase | CONFIRMED |
| D-007 | The reward system will include treasure, reputation, base improvements, and new abilities | Provides multiple progression dimensions aligned to the thief/infiltrator fantasy | Client response | Single reward track; cosmetic-only rewards | Requires economy and progression balancing | CONFIRMED |
| D-008 | Ghost competition will use a combined score | Allows time, treasure, and failures to contribute to a broader mastery measure | Client response | Single metric | Requires explicit scoring weights and clear feedback | CONFIRMED |
| D-009 | Detection creates a chase that can still be escaped | Preserves tension without making every mistake an immediate failure | Client response | Immediate failure; partial reward loss | Requires readable pursuit rules and fast retry flow | CONFIRMED |
| D-010 | MVP movement includes jump/acrobatic movement, wall-grab, and slide | Provides a compact traversal vocabulary for the opening raid | Client response | Other movement kits | Defines tutorial and level grammar | CONFIRMED |
| D-011 | Base progression combines visual and functional improvements | Connects emotional ownership with gameplay progression | Client response | Visual-only; functional-only | Requires economy sinks and balance safeguards | CONFIRMED |
| D-012 | The visual direction is urban fantasy | Supports a recognizable world for the thief/infiltrator fantasy | Client response | Medieval fantasy; gothic; steampunk | Requires a distinctive visual motif for award presentation | CONFIRMED |
| D-013 | Monetization combines cosmetics with optional ads | Fits a single-player short-session game while avoiding direct competitive power sales | Client response | No monetization; cosmetics only; forced ads | Requires careful ad placement and platform implementation | CONFIRMED |

## Next Adaptive Questions

1. What should the player feel like they are becoming or accomplishing? Examples: a thief escaping impossible traps, a daring explorer, a clever infiltrator, or a resilient survivor.
2. In the first 60 seconds, what should the judge do and feel? Specify the first interaction, the first challenge, and the first satisfying outcome.
3. Should the game focus on precision platforming, automatic running, trap avoidance, puzzle-platforming, stealth, competitive raids, or a hybrid?
4. What is the intended session length: under 2 minutes, 3–5 minutes, 5–10 minutes, or longer?
5. Is the game single-player, asynchronous competitive, real-time multiplayer, or undecided?

## Implementation Alignment — 2026-08-26

The first alignment increment replaces the single progress mock with a playable Flutter vertical slice. The implementation now contains a selection screen, deterministic raid state transitions, jump/move/wall-grab/slide controls, graffiti route/platform/trap effects, detection and chase, alternative escape, theft, extraction, ghost score breakdown, optional economic bonus boundary, result flow, and hideout progression.

| Classification | Record |
|---|---|
| `[SOURCE FACT]` | The GDD core loop is `Infiltrate → Stealth/Acrobatics → Steal → Escape → Ghost Comparison → Upgrade/Retry`. |
| `[CLIENT DECISION]` | The project targets Android and Web/Wasm, with short single-player stealth raids and urban-fantasy direction. |
| `[AGENT RECOMMENDATION]` | Use `CustomPainter` plus official Flutter widgets for the native-only MVP, with domain state separated from presentation. |
| `[IMPLEMENTED]` | `lib/domain`, `lib/application`, `lib/core`, and `lib/presentation` now follow the documented dependency direction. |
| `[VALIDATION REQUIRED]` | Flutter analyze, unit/widget tests, Android build, Web/Wasm build, visual readability, and real-device gameplay evidence require CI or a Flutter-enabled environment. |
| `[RISK]` | The current repository lacks exact production files for several inventory paths; see `docs/asset-traceability.md`. |

## Decision Log Addendum

| Decision ID | Decision | Reason | Source | Alternatives | Impact | Status |
|---|---|---|---|---|---|---|
| `D-014` | The native-only MVP uses Flutter widgets plus `CustomPainter` for the authored fortress scene and official input/accessibility APIs. | Keeps the vertical slice package-free while supporting Web/Wasm and Android. | `[AGENT RECOMMENDATION]` based on `T-001` | External game engine; package-based renderer | Defines presentation implementation and keeps gameplay rules in the domain | PROVISIONAL; platform validation required |
| `D-015` | The repository's existing `assets/` and `visual_assets/` families are loaded through a central asset manifest. | Prevents undocumented asset paths and makes GDD-to-code mapping reviewable. | `docs/visual-style-guide.md`; `docs/asset-traceability.md` | Scatter paths across widgets; regenerate all art | Makes approved references visible while preserving explicit inventory gaps | IMPLEMENTED |
| `D-016` | The optional bonus is represented as an economic reward boundary and never changes the competitive score. | Required by `GHOST-SCORE-002` and the monetization boundary. | `docs/core-loop-design.md` | Direct score multiplier; forced ad | Keeps monetization separate from mastery score | IMPLEMENTED |

## Open Questions

The following remain unresolved and must not be silently converted into product decisions: exact score normalization and tie-breaking, persistence strategy, bundled versus local ghost replay storage, Android demo device, production icon pack, exact route graph authored for the fortress, and provider implementation for optional advertisements. These are tracked by the existing technical decisions and issues `#17` through `#20`.
