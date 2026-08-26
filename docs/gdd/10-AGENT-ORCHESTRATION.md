# 10 — AGENT ORCHESTRATION

## 1. Agent Graph

```text
GAME DIRECTOR
  ↓
RESEARCH / EVIDENCE
  ↓
GAMEPLAY + LOOP
  ↓
SYSTEMS
  ↓
ECONOMY
  ↓
MONETIZATION (conditional)
  ↓
LIFECYCLE
  ↓
UX/UI + ACCESSIBILITY
  ↓
ASSET / AUDIO
  ↓
TECHNICAL / PLATFORM
  ↓
QA
  ↓
RELEASE
```

O fluxo é sequencial para decisões e incremental para implementação; um agente não pode mascarar uma lacuna como requisito.[1] [5]

## 2. Responsibilities

| Agent | Owns | Reads | Produces | Cannot silently change |
|---|---|---|---|---|
| Game Director | Vision/scope | Research, client decisions | GDD, decision log | Technical implementation |
| Research | Evidence | Sources | Extraction/evidence map | Product requirements |
| Gameplay/Loop | Mechanics/core loop | GDD | Game Spec, loop graph | Economy/monetization |
| Systems | States/entities | Game Spec | State/system spec | Player intent |
| Economy | Faucets/sinks | Game Spec | Economy Spec/simulation | Core fantasy |
| Monetization | Offers/entitlements | Economy/platform | Conditional RC spec | Gameplay rules |
| Lifecycle | App state/recovery | All specs | Lifecycle Spec | UX goals |
| UX/Accessibility | Screens/controls | Game Spec | UX Spec/tests | Domain rules |
| Asset | Visual/audio | GDD/UX | Asset Bible/registry | Mechanics |
| Technical | Architecture/platform | All specs | Tech Spec/CI | Game intent |
| QA | Verification | All specs | QA evidence | Acceptance truth |
| Release | Delivery | Verified artifacts | Release checklist | Source decisions |

## 3. Agent Handoff Contract

Every handoff contains `agent_id`, `role`, `skill_id`, `input_refs`, `output_refs`, `assumptions`, `unresolved_questions`, `decision_ids`, `dependencies`, `risks`, `status` and `acceptance_evidence`.[1]

## 4. Stop Conditions

The agent must stop and open a clarification/research task when a requirement conflicts, a rule is ambiguous, a dependency is unknown, platform compatibility is uncertain, monetization is undefined, or an acceptance test cannot be written.[1] [5]

## 5. Execution Gates

`SPECIFY → PLAN → TASKS → IMPLEMENT → TEST → REVIEW → VERIFY → DOCUMENT` is mandatory for changes larger than a trivial correction.[5]

## References

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
