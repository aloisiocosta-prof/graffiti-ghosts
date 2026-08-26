# Asset Traceability

This document records how the visual assets described by `docs/visual-style-guide.md` map to files currently present in the repository. Concept references and implementation-facing spritesheets are intentionally distinguished.

| GDD asset role | Documented path | Repository file used or mapped | Classification | Status |
|---|---|---|---|---|
| Visual reference | `reference/graffiti-ghosts-visual-reference.png` | `visual_assets/graffiti-ghosts-visual-reference.png` | Concept reference | IMPLEMENTED as selection background/style reference |
| Raid HUD | `ui/01-raid-gameplay-hud.png` | `visual_assets/01-raid-gameplay-hud.png` | UX mockup | REFERENCED; reusable Flutter HUD implemented from tokens |
| Fortress selection | `ui/02-fortress-select.png` | No exact file present | Concept inventory gap | VALIDATION REQUIRED; selection screen uses fortress key art |
| Raid results | `ui/03-raid-results-ghost.png` | No exact file present | Concept inventory gap | VALIDATION REQUIRED; results UI implemented from GDD rules |
| Base progression | `ui/04-base-progression.png` | No exact file present | Concept inventory gap | VALIDATION REQUIRED; hideout UI implemented from GDD rules |
| Title screen | `ui/05-title-screen-key-art.png` | `visual_assets/fortress-vertical-slice-key-art.png` | Key art | MAPPED to available vertical-slice key art |
| Chase HUD | `ui/06-chase-alert-hud.png` | `visual_assets/06-chase-alert-hud.png` | UX mockup | REFERENCED; chase banner implemented as live state |
| Second chance modal | `ui/07-optional-second-chance-modal.png` | `visual_assets/07-optional-second-chance-modal.png` | UX mockup | REFERENCED; capture/choice panel implemented as live state |
| Thief sheet | `characters/thief-character-sheet.png` | `visual_assets/thief-character-sheet.png` and `assets/thief-animation-spritesheet.png` | Concept + spritesheet | IMPLEMENTED in raid header and hideout |
| Ghost sheet | `characters/ghost-silhouette-sheet.png` | `visual_assets/ghost-silhouette-sheet.png` and `assets/ghost-replay-spritesheet.png` | Concept + spritesheet | IMPLEMENTED in result and raid presentation |
| Magical graffiti VFX | `environment/magical-graffiti-effects-sheet.png` | `visual_assets/magical-graffiti-effects-sheet.png` and `assets/magical-graffiti-vfx-spritesheet.png` | Concept + spritesheet | IMPLEMENTED as visual family and route state |
| Fortress kit | `environment/urban-fortress-modular-kit.png` | `assets/fortress-props-spritesheet.png` | Spritesheet | IMPLEMENTED as repository asset family; exact documented file is absent |
| Icon pack | `icons/gameplay-icon-pack.png` | Flutter Material icons with GDD palette | Native UI fallback | IMPLEMENTED; custom icon pack remains VALIDATION REQUIRED |
| Vertical-slice key art | `environment/fortress-vertical-slice-key-art.png` | `visual_assets/fortress-vertical-slice-key-art.png` | Key art | IMPLEMENTED as selection background |

## Asset loading contract

The runtime declares five files currently used by the selection, raid, results and hideout screens in `pubspec.yaml`: two spritesheets and three visual references. The remaining concept sheets and unused spritesheets stay in the repository as design references without entering the runtime bundle. The application references runtime assets through `lib/core/config/asset_manifest.dart` rather than scattering string paths across widgets. Missing exact inventory paths are not silently treated as final production assets; they remain explicit validation items.

## Readability acceptance

The implementation preserves the documented deep-indigo, electric-cyan, hot-magenta, acid-lime, ghost-violet, warm-amber, and chalk-white roles. Critical route, danger, reward, player, and ghost information is also represented by labels, icons, geometry, and text so color is not the only channel.
