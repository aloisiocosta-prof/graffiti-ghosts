# 07 — ASSET BIBLE

## 1. Art Direction

A direção visual é urban fantasy com contraste escuro, cyan, magenta, lime, silhuetas de ghost, fortaleza e graffiti mágico, conforme as referências visuais atuais do projeto.[2] [3]

Os assets existentes em `assets/` e `visual_assets/` são referências de projeto até que proveniência, licença, dimensões de uso e integração sejam validadas.[5]

## 2. Asset Contract

| ID | Type | Purpose | Dimensions | Format | State | Dependency | Acceptance |
|---|---|---|---:|---|---|---|---|
| ART-001 | sprite sheet | Thief animation | 1920×1920 source | PNG RGBA | PRESENT | `assets/thief-animation-spritesheet.png` | Readable player states |
| ART-002 | sprite sheet | Ghost replay | 1920×1920 source | PNG RGBA | PRESENT | `assets/ghost-replay-spritesheet.png` | Ghost distinguishable |
| ART-003 | sprite sheet | Graffiti VFX | 1920×1920 source | PNG RGBA | PRESENT | `assets/magical-graffiti-vfx-spritesheet.png` | Effect communicates action |
| ART-004 | sprite sheet | Fortress props | 1920×1920 source | PNG RGBA | PRESENT | `assets/fortress-props-spritesheet.png` | Environmental readability |
| ART-005 | UI reference | Raid HUD | 1440×2560 | PNG RGB | REFERENCE | `visual_assets/01-raid-gameplay-hud.png` | HUD hierarchy documented |
| ART-006 | UI reference | Chase alert | 1440×2560 | PNG RGB | REFERENCE | `visual_assets/06-chase-alert-hud.png` | Detection not color-only |
| ART-007 | UI reference | Second chance | 1440×2560 | PNG RGB | REFERENCE | `visual_assets/07-optional-second-chance-modal.png` | Optionality explicit |
| ART-008 | key art | Fortress vertical slice | 2560×1440 | PNG RGB | REFERENCE | `visual_assets/fortress-vertical-slice-key-art.png` | Style target |
| ART-009 | character reference | Thief | 1664×2080 | PNG RGB | REFERENCE | `visual_assets/thief-character-sheet.png` | Style/pose target |
| ART-010 | character reference | Ghost | 1664×2080 | PNG RGB | REFERENCE | `visual_assets/ghost-silhouette-sheet.png` | Silhouette readable |
| ART-011 | VFX reference | Magical effects | 1664×2080 | PNG RGB | REFERENCE | `visual_assets/magical-graffiti-effects-sheet.png` | VFX target |
| ART-012 | style reference | Overall visual identity | 2560×1440 | PNG RGB | REFERENCE | `visual_assets/graffiti-ghosts-visual-reference.png` | Palette/style consistency |

## 3. Sprite Sheet Contract

Cada sheet final deve documentar frame size, anchor/pivot, FPS, animation names, layout, naming, transparency e escala de exportação antes de ser usado em gameplay.[1]

## 4. UI Assets

UI deve contemplar HUD de raid, chase alert, result/score, hideout, settings, focus states, error states e qualquer shop/paywall somente após aprovação de monetização.[1] [5]

## 5. Audio

Áudio e música ainda não estão presentes como assets de runtime confirmados; eventos, prioridade, fallback visual e controles independentes devem ser especificados antes da produção.[1] [5]

## 6. Asset Production Gate

Nenhum asset final entra no runtime sem purpose, style, technical spec, usage context, acceptance criteria, source/license e registro em `docs/specs/asset-registry.json`.[1] [5]

## References

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[2]: ../visual-style-guide.md "Graffiti Ghosts visual style guide"
[3]: ../concept-brief.md "Graffiti Ghosts concept brief"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
