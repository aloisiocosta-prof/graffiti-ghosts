# 03 — ECONOMY SPECIFICATION

## Objetivo

Projetar a economia do Graffiti Ghosts como um sistema de recursos relacionado à atividade de raid, treasure, reputation, hideout e escolhas de progressão.[1] [2]

## 1. Economy Model

```text
RAID PERFORMANCE → TREASURE / REPUTATION → HIDEOUT UPGRADE → NEW CAPABILITY OR CUSTOMIZATION
```

A economia não deve corrigir um core loop que não funciona, e nenhum recurso premium é criado por inferência dos exemplos do relatório.[1]

## 2. Currency Catalog

| ID | Nome | Tipo | Sources | Sinks | Cap | Objetivo | Status |
|---|---|---|---|---|---|---|---|
| ECO-CUR-001 | Treasure | Recurso de raid | Roubo/coleta e conclusão conforme GDD | Hideout upgrades e conteúdo aprovado | `[DECIDIR]` | Reforçar sucesso da raid | CONFIRMED concept / TUNING OPEN |
| ECO-CUR-002 | Reputation | Progression signal | Performance/resultado conforme GDD | Unlocks de hideout/conteúdo | `[DECIDIR]` | Comunicar crescimento | OPEN |
| ECO-CUR-003 | Premium currency | `[DECIDIR]` | Nenhuma aprovada | Nenhum aprovado | N/A | Não adicionar sem decisão | VALIDATION REQUIRED |

## 3. Resource Catalog

| ID | Resource | Produção | Consumo | Permanência | Limite | Status |
|---|---|---|---|---|---|---|
| ECO-RES-001 | Graffiti charge | Regra da raid | Ativação de graffiti | Durante tentativa | `[DECIDIR]` | CONFIRMED behavior / recharge OPEN |
| ECO-RES-002 | Time | Progressão de raid | Movimento, graffiti e escape conforme tuning atual | Durante tentativa | Zero inferior | CONFIRMED behavior / tuning OPEN |
| ECO-RES-003 | Heat | Detecção/chase | Escape ou recuperação | Durante tentativa | LOW/HIGH atual | CONFIRMED behavior / transitions OPEN |

## 4. Progression Economy

| Stage | Earn Rate | Spend Rate | Time-to-Unlock | Player Choice | Status |
|---|---:|---:|---:|---|---|
| Vertical slice | Definida pelo resultado atual | Sem custo obrigatório | Imediato | Retry/upgrade demonstrativo | CONFIRMED |
| MVP | `[DECIDIR]` | `[DECIDIR]` | `[DECIDIR]` | Upgrades do hideout | OPEN |

## 5. Balance Hypotheses

- `H-ECO-001`: Uma raid bem-sucedida deve gerar progresso perceptível sem exigir repetição excessiva; evidência necessária: playtest e tabela de recompensas.[1]
- `H-ECO-002`: Treasure deve recompensar exploração sem permitir score infinito; evidência necessária: testes de bounds e simulação.[3]

## 6. Simulation Requirements

A simulação deve conter inputs de habilidade baixa, média e alta, duração, treasure ganho, falhas, custos, unlock time, saldo final, gargalos e inflação/deflação.[1]

Nenhum custo final será registrado como decisão antes da simulação e da aprovação do Game Director.[5]

## 7. Monetization Relationship

```text
GAMEPLAY VALUE → ECONOMIC VALUE → OPTIONAL PREMIUM VALUE → PURCHASE OPPORTUNITY
```

A camada premium, se aprovada, não pode bloquear o entendimento, a conclusão ou a diversão do core loop.[1]

## Referências

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[2]: ../concept-brief.md "Graffiti Ghosts concept brief"
[3]: ../core-loop-design.md "Graffiti Ghosts core-loop design"
[4]: ../technical-and-demo-spec.md "Graffiti Ghosts technical and demo specification"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
