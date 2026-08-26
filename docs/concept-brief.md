# Concept Brief — Working Draft

## Working Concept

A short-session stealth platformer for Android and Web/Wasm in which the player controls an agile thief infiltrating game-authored fortresses. Each raid is designed to be completed in under three minutes. The player learns and applies acrobatic movement abilities, avoids or manipulates security systems, steals treasure, and compares the result against recorded ghost attempts.

## Confirmed by Client

| Area | Confirmed direction |
|---|---|
| Genre | Platformer |
| Player fantasy | Agile explorer-thief becoming an infiltrator |
| Platforms | Android and Web/Wasm |
| Reference | King of Thieves |
| Session target | Under three minutes |
| Structure | Single-player |
| Raid content | Pre-built fortresses created by the game |
| Asynchronous competition | Ghost replays of previous attempts; performance is evaluated by a combined score |
| Opening sequence | Enter fortress, learn an acrobatic skill, overcome an obstacle, perform the first perfect heist |
| Reward categories | Treasure, reputation, base improvements, new abilities |

| Detection response | Detection triggers a chase, and escape depends on finding alternative routes | Direct user response |
| MVP movement kit | Jump/acrobatic movement, wall-grab, and slide | Direct user response |
| Base progression | Combination of visual and functional improvements | Direct user response |
| Art direction | Urban fantasy centered on magical graffiti | Direct user response |
| Monetization | Cosmetics combined with optional ads: second chance after capture or bonus treasure | Direct user response; implementation and frequency remain to validate |

## Working Design Hypothesis — Requires Validation

The strongest initial core loop is: **select fortress → scout the route → infiltrate using movement and stealth → steal treasure → escape → compare performance against ghosts → spend rewards on progression → attempt a harder fortress or improve the previous run**.

A potentially distinctive angle is to make stealth an active platforming verb rather than a pause-based state. The player could manipulate light, sound, line of sight, and movement momentum while maintaining a fast, readable flow suitable for sub-three-minute sessions. This is an agent recommendation, not a confirmed requirement.

## Open Design Questions

| ID | Question | Why it matters |
|---|---|---|
| Q-001 | How will the 40/40/20 ghost score be normalized and presented so players understand tradeoffs? | Defines player motivation, HUD, leaderboards, and reward rules |
| Q-002 | How many alternative routes and escape opportunities should a fortress provide? | Defines tension, failure cost, retry speed, and stealth readability |
| Q-003 | How are jump, wall-grab, and slide introduced and upgraded? | Defines controls, level grammar, tutorial pacing, and technical scope |
| Q-004 | Which visual and functional base improvements belong in the MVP? | Defines progression depth and economy sinks |
| Q-005 | How do magical graffiti function visually and mechanically? | Defines art direction and award presentation |
| Q-006 | How are cosmetic purchases, second chances, and treasure bonuses presented without affecting ghost competition unfairly? | Defines economy boundaries and player-trust constraints |

## Award-Focused Validation Targets

The vertical slice should make the following legible without explanation: movement feels responsive; stealth creates meaningful choices; a raid has a clear beginning, escalation, theft, and escape; the ghost comparison is immediately understandable; rewards visibly improve the thief or base; and the art direction has one memorable visual motif.
