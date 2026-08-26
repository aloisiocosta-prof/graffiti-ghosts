# Graffiti Ghosts — Visual Style and UX/UI Guide v0.1

## Visual Direction

Graffiti Ghosts uses a **vibrant urban-fantasy** direction built around a deep indigo night city, strong silhouettes, neon paint, rooftop fortresses, and magical graffiti. The visual language should feel kinetic, readable, playful, mysterious, and premium without becoming grim or visually noisy.

> Core visual rule: the player must understand the thief, the ghost, the route choice, the danger, and the reward within a quick glance on a mobile screen.

## Palette

| Role | Color direction | Usage |
|---|---|---|
| Deep indigo | Near-black blue | Backgrounds, fortress depth, modal surfaces |
| Electric cyan | Bright blue-cyan | Player identity, movement, safe routes, primary actions |
| Hot magenta | Saturated pink-purple | Heist payoff, temporary platforms, danger emphasis |
| Acid lime | Bright yellow-green | Trap changes, treasure bonuses, functional progression |
| Ghost violet | Pale luminous violet | Ghost silhouettes, replay trails, spectral information |
| Warm amber | Lantern orange | Windows, environmental contrast, city life |
| Chalk white | High-contrast white | Critical labels and readable interface copy |

## UI Principles

The interface uses large touch targets, high-contrast labels, rounded translucent panels, neon edge accents, and a small number of simultaneous priorities. Gameplay HUD should keep treasure, time, score, heat, movement, and graffiti ability visible without obscuring the route. Results screens should separate competitive score from economic rewards. Optional-ad surfaces must be clearly optional and must show the penalties or tradeoffs before confirmation.

## UX Flow

```text
Title Screen
  ↓
Fortress Selection
  ↓
Raid HUD
  ├── Graffiti activation
  ├── Chase and alternative route
  └── Capture / optional second chance
  ↓
Raid Results + Ghost Comparison
  ↓
Rewards
  ↓
Hideout / Base Progression
  ↓
Wardrobe / Cosmetics
```

## Asset Inventory

| Asset | File | Purpose |
|---|---|---|
| Visual reference | `reference/graffiti-ghosts-visual-reference.png` | Master style reference for color, character, ghost, graffiti, and environment |
| Raid HUD | `ui/01-raid-gameplay-hud.png` | Core gameplay screen and touch control layout |
| Fortress selection | `ui/02-fortress-select.png` | Raid selection, reward preview, ghost benchmark |
| Raid results | `ui/03-raid-results-ghost.png` | Perfect heist payoff, score comparison, rewards |
| Base progression | `ui/04-base-progression.png` | Hideout, storage, new area, wardrobe progression |
| Title screen | `ui/05-title-screen-key-art.png` | Brand and first-launch visual direction |
| Chase HUD | `ui/06-chase-alert-hud.png` | Detection, pursuit, route selection, heat state |
| Second-chance modal | `ui/07-optional-second-chance-modal.png` | Ethical optional-ad flow and explicit penalties |
| Thief sheet | `characters/thief-character-sheet.png` | Animation and silhouette reference |
| Ghost sheet | `characters/ghost-silhouette-sheet.png` | Replay silhouette and motion reference |
| Graffiti VFX | `environment/magical-graffiti-effects-sheet.png` | Route, platform, trap, activation, and impact effects |
| Fortress kit | `environment/urban-fortress-modular-kit.png` | Modular environment and level-design reference |
| Icon pack | `icons/gameplay-icon-pack.png` | HUD, progression, route, trap, and reward icon reference |
| Vertical-slice key art | `environment/fortress-vertical-slice-key-art.png` | End-to-end raid composition and award presentation |

## Production Notes

These images are concept references and UX/UI mockups, not final production sprites, atlases, vector icons, or implementation-ready Flutter layouts. Before implementation, the team should convert the approved visual language into reusable tokens, responsive layout constraints, icon assets, animation specifications, and accessible color/contrast variants.

The title screen and interface text are concept-level generated content. Product copy, localization, legal notices, store metadata, and exact typography must be reviewed separately before shipping.

## Vertical Slice Visual Checklist

The first playable slice should include a recognizable thief silhouette, a violet ghost that remains legible against the background, one cyan route mark, one magenta temporary platform, one lime trap interaction, a clear heat indicator, an obvious alternative route during pursuit, a results screen with score breakdown, and a visible base improvement after the heist.
