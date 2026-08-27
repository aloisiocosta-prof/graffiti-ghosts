# 09 — QA + ACCEPTANCE SPECIFICATION

## 1. Acceptance Criteria

Toda feature deve possuir critérios Given/When/Then, teste, evidência de plataforma e vínculo com Issue/PR.[1] [5]

## 2. Test Matrix

| ID | Scenario | Precondition | Action | Expected | Platform |
|---|---|---|---|---|---|
| QA-001 | Start app | Clean install/build | Launch | App reaches READY without crash | Android/Web/WasmGC |
| QA-002 | Movement | Raid READY | Move/jump | Route/progress changes deterministically | Android/Web/WasmGC |
| QA-003 | Graffiti | Charge ready | Activate graffiti | Charge consumed, VFX/route feedback, state changes | Android/Web/WasmGC |
| QA-004 | Detection | Risk zone reached | Continue route | Chase state and readable alert appear | Android/Web/WasmGC |
| QA-005 | Escape | Chase active | Escape | Chase resolves according to rule | Android/Web/WasmGC |
| QA-006 | Score | Completed attempt | Resolve score | Score remains deterministic and bounded 0–1000 | Android/Web/WasmGC |
| QA-007 | Retry | Result visible | Replay | Initial attempt state restored without duplicate reward | Android/Web/WasmGC |
| QA-008 | Wasm artifact | Flutter SDK available | Build `--wasm` | `main.dart.wasm` and bootstrap exist | Cloudflare |
| QA-009 | Architecture | Source changed | Analyze/import scan | No forbidden platform API in domain/application | CI |

## 3. Critical Monetization Tests

Purchase success, cancel, failure, retry, duplicate attempt, restore, refund/expiration, offline, reconnect, app kill, background, resume, reinstall and identity switch are required only if monetization is approved.[1]

## 4. Game Logic Tests

Tests must cover state transitions, invalid actions, resource bounds, progression unlocks, victory, defeat, save/load and deterministic rules.[1] [5]

## 5. Regression Gate

Nenhuma mudança pode quebrar core loop, economy invariants, entitlement invariants, lifecycle recovery, accessibility or platform compatibility.[5]

## 6. Definition of Evidence

A validation record must include command, commit, platform, result, log link or artifact path, and unresolved risks.[5]

## References

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
