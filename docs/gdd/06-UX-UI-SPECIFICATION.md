# 06 — UX/UI SPECIFICATION

## 1. Experience Principles

A interface deve tornar infiltração, risco, graffiti, treasure, chase, score e retry legíveis em sessões curtas.[2] [3]

Feedback crítico não pode depender exclusivamente de cor, áudio ou reflexo rápido; deve possuir alternativa visual, textual, sonora ou de controle quando aplicável.[5]

## 2. Screen Contracts

| Screen ID | Purpose | Entry | Exit | Primary action | Data | Loading/Error/Offline | Accessibility |
|---|---|---|---|---|---|---|---|
| UX-001 HOME | Iniciar raid e acessar progressão/configurações | Cold start/return | PLAY | Play | Progressão resumida | Error/retry | Focus, scalable text |
| UX-002 RAID | Executar a infiltração | HOME | RESULT/RETRY | Move/jump/graffiti/steal | Time, treasure, heat, route, ghost | Pause/recovery | Keyboard/touch alternatives |
| UX-003 CHASE | Comunicar detecção e escape | Detecção | RAID/FAIL | Escape/alternative route | Heat, threat, route | Clear recovery | No color-only warning |
| UX-004 RESULT | Mostrar score, ghost comparison e reward | Completion/failure | HOME/RETRY/UPGRADE | Retry/upgrade | Score, time, treasure, failures | Safe fallback | Readable semantics |
| UX-005 HIDEOUT | Comunicar progressão e ownership | Result/Home | HOME/RAID | Upgrade/customize | Treasure/reputation/upgrades | Locked state explained | Contrast and labels |
| UX-006 SETTINGS | Controles, áudio e acessibilidade | Any safe state | Previous | Configure | Volume, motion, input | Defaults | Reduced motion, remapping |

## 3. Navigation Graph

```text
HOME ├── RAID ├── CHASE └── RESULT ├── RETRY
     ├── HIDEOUT
     └── SETTINGS
```

Shop/paywall permanece fora do MVP até monetização ser aprovada.[1]

## 4. Feedback

| Event | Visual | Textual | Audio/Haptic | Timing |
|---|---|---|---|---|
| Move/jump | Route/player response | Optional hint | Optional SFX | Immediate |
| Graffiti | Magenta/lime VFX and route change | `GRAFFITI ACTIVE/USED` | Optional SFX | Immediate |
| Detection | Banner, heat state, route cue | `DETECTED` | Alert with visual substitute | Immediate |
| Treasure | HUD increment and reward cue | Amount | Optional pickup SFX | Immediate |
| Result | Score breakdown and ghost | Completion/failure | Summary cue | End of raid |

## 5. Onboarding

| Step | Player learns | Action | Feedback | Exit criterion |
|---|---|---|---|---|
| 1 | Move and jump | Use directional/jump controls | Route changes | Player moves |
| 2 | Risk and chase | Enter/observe obstacle | Detection banner | Player identifies risk |
| 3 | Graffiti | Activate graffiti | VFX and route change | Player uses graffiti |
| 4 | Reward/retry | Collect treasure and complete/fail | Score/ghost/retry | Player understands next action |

## References

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[2]: ../concept-brief.md "Graffiti Ghosts concept brief"
[3]: ../core-loop-design.md "Graffiti Ghosts core-loop design"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
