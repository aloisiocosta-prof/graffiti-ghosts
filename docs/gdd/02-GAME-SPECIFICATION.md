# 02 — GAME SPECIFICATION

## Objetivo

Converter a intenção de design do Graffiti Ghosts em regras observáveis, determinísticas e testáveis.[3] [5]

## 1. Game Loop

```text
INFILTRATE
→ STEALTH / ACROBATICS
→ STEAL TREASURE
→ ESCAPE CHASE
→ GHOST COMPARISON
→ HIDEOUT UPGRADE / RETRY
```

A unidade mínima de interação é uma ação do jogador que transforma estado de rota, tempo, treasure, heat, graffiti readiness ou resultado da raid.[3]

## 2. Mechanic Contracts

| ID | Mecânica | Input | Estado e regra | Output/feedback | Falha/recovery |
|---|---|---|---|---|---|
| GD-MECH-001 | Movimento | Botões direcional/jump ou input equivalente | Avança ou recua o progresso de rota e reduz tempo conforme tuning atual. | Rota, posição e HUD mudam. | Input inválido não altera estado; retry reinicia tentativa. |
| GD-MECH-002 | Graffiti mágico | Ação `GRAFFITI` quando ready | Consome a carga, avança rota, reduz heat/chase conforme regra atual e produz VFX. | Feedback visual/textual de graffiti e mudança de rota. | Não disponível enquanto consumido; recarga/política futura é `[VALIDATION REQUIRED]`. |
| GD-MECH-003 | Detecção/chase | Entrada em zona de risco | Heat muda para HIGH e oferece alternativa de escape. | Banner de detecção e ação ESCAPE. | Captura e penalidade exata precisam de teste de domínio. |
| GD-MECH-004 | Roubo/coleta | Ação `STEAL` | Incrementa treasure e avança rota. | HUD de treasure e feedback de recompensa. | Sem treasure negativo; tentativa pode falhar se a raid não for concluída. |
| GD-MECH-005 | Score | Resultado da tentativa | O modelo aprovado pelos testes combina tempo, treasure e falhas em faixa de 0–1000. | Painel de resultado e ghost comparison. | `[CONFLICT]` O getter atual em `lib/main.dart` ainda não aplica clamp superior; `test/score_test.dart` já expressa o limite esperado. Abrir correção de código antes de considerar a regra implementada. |
| GD-MECH-006 | Retry | Ação `REPLAY RAID` | Reinicia estado da tentativa sem duplicar recompensa. | Retorno ao estado inicial. | Repetição deve ser idempotente por attempt ID quando persistência existir. |

## 3. Emergence vs Progression

O MVP é um híbrido: regras de movimento, detecção, graffiti e score são fixas, enquanto a escolha de rota, timing e comparação com ghost criam possibilidades emergentes.[3]

A progressão do hideout é conteúdo planejado e não pode ser necessária para compreender ou completar a raid básica.[2] [3]

## 4. Feedback Loops

| ID | Tipo | Investimento | Efeito | Velocidade | Countermeasure |
|---|---|---|---|---|---|
| FB-001 | Positivo | Melhor rota e menor tempo | Score e ghost comparison reforçam maestria | Imediato | Garantir que score explique contribuição de tempo/treasure/falhas. |
| FB-002 | Negativo | Detecção ou falha | Chase/penalidade aumenta tensão e ensina risco | Imediato | Oferecer rota/escape legível e retry rápido. |
| FB-003 | Progressão | Raid concluída | Treasure/reputation alimentam hideout | Entre tentativas | Não criar custo que bloqueie o core loop. |

## 5. State Machine

```text
READY → START_RAID → INFILTRATING → CHASING → ESCAPING → COMPLETED
                         └──────────→ FAILED → RETRY → READY
COMPLETED → SCORE/GHOST → UPGRADE → READY
```

| Estado | Entrada | Ações permitidas | Saída | Persistência |
|---|---|---|---|---|
| READY | App pronto | Iniciar raid/configurar | START_RAID | Nenhuma alteração de tentativa |
| INFILTRATING | Raid iniciada | Mover, jump, graffiti, steal | CHASING, COMPLETED, FAILED | Snapshot quando definido |
| CHASING | Detecção | Escape, movimento | ESCAPING, FAILED | Snapshot seguro |
| ESCAPING | Escape acionado | Movimento e conclusão | COMPLETED/FAILED | Resultado pendente |
| COMPLETED | Escape/rota concluída | Ver score, ghost, upgrade, retry | READY | Recompensa idempotente |
| FAILED | Captura/condição de falha | Feedback, retry, sair | READY/RETRY | Penalidade definida pelo GDD |

## 6. Progression

| Stage | Unlock | Challenge | Reward | New Rule |
|---|---|---|---|---|
| Vertical slice | Acesso à raid | Movimento, risco, graffiti, treasure | Score e ghost comparison | Core loop completo |
| MVP raid set | `[VALIDATION REQUIRED]` | Rotas e chase variados | Treasure/reputation | Conteúdo adicional a decidir |
| Hideout progression | Conclusão de raid | Escolha de melhoria | Visual + funcional | Custos e níveis ainda pendentes |

## 7. Anti-Ambiguity Gate

- [x] Input, estado, regra, output, feedback e score inicial documentados.[3]
- [CONFLICT] Score bounded 0–1000 está definido por teste, mas a implementação da UI precisa aplicar o clamp superior explicitamente.
- [ ] Timing, persistência, captura, recarga de graffiti e tuning final precisam de testes/decisões adicionais.
- [ ] Cada mecânica nova deve adicionar teste e Issue antes do código.[5]

## Referências

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[2]: ../concept-brief.md "Graffiti Ghosts concept brief"
[3]: ../core-loop-design.md "Graffiti Ghosts core-loop design"
[4]: ../technical-and-demo-spec.md "Graffiti Ghosts technical and demo specification"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
