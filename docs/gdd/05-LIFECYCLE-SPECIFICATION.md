# 05 — APPLICATION LIFECYCLE SPECIFICATION

## Objetivo

Garantir que gameplay, persistência, score, reward e qualquer monetização futura permaneçam consistentes durante as transições da aplicação.[1] [5]

## 1. Application States

```text
COLD_START → INITIALIZING → LOADING → READY → PLAYING → PAUSED
PLAYING → BACKGROUND → RESUMED → SYNCING → READY
PLAYING → COMPLETED / FAILED
ANY_RECOVERABLE_STATE → ERROR → RECOVERING
RECOVERING → READY / TERMINATING
```

## 2. State Contract

| State | Entry | Allowed | Forbidden | Persistence | Exit |
|---|---|---|---|---|---|
| READY | Recursos carregados | Iniciar raid, configurações, acessibilidade | Alterar tentativa inexistente | Configuração validada | PLAYING |
| PLAYING | Raid iniciada | Inputs e regras da raid | Avançar timer em background/paused | Snapshot/checkpoint conforme decisão | PAUSED, BACKGROUND, COMPLETED, FAILED |
| PAUSED | Usuário/interrupção | Resume, retry, sair | Simular tempo | Estado seguro | PLAYING/READY |
| BACKGROUND | App perde foco | Persistir estado seguro | Continuar simulação | Snapshot seguro | RESUMED/TERMINATING |
| SYNCING | Resume com serviço aprovado | Reconciliar autoridade | Liberar estado inconsistente | Resultado de sync | READY/ERROR |
| COMPLETED | Raid concluída | Score, ghost, reward, upgrade/retry | Duplicar reward | Resultado idempotente | READY |
| ERROR | Falha recuperável | Retry, diagnóstico | Perder silenciosamente progresso | Último estado seguro | RECOVERING |

## 3. Critical Scenarios

Cold start, background durante gameplay, process death, offline/online, account change, reinstall e background durante purchase permanecem cenários obrigatórios de teste.[1]

A regra concreta de persistência, checkpoint e offline é `[VALIDATION REQUIRED]` e não deve ser inventada pelo código.[5]

## 4. Authority Model

| Data | Local | Remote | Source of Truth | Conflict Rule |
|---|---|---|---|---|
| Gameplay progress | `[DECIDIR]` | `[DECIDIR]` | `[DECIDIR]` | `[DECIDIR]` |
| Entitlement | Cache auxiliar | RevenueCat/store se aprovado | Autoridade externa | Não sobrescrever com cache |
| Economy | Local ou serviço aprovado | `[DECIDIR]` | `[DECIDIR]` | Reward idempotente por attempt ID |

## 5. Invariants

Um entitlement confirmado não desaparece por cache stale, retry não duplica reward, termination não deixa estado sem documentação e todo estado recuperável possui caminho de recovery.[1]

## 6. Lifecycle Test Matrix

| Scenario | Expected State | Expected Data | Expected Entitlement |
|---|---|---|---|
| kill during loading | READY ou ERROR recuperável | Config/asset integrity | N/A |
| background during raid | BACKGROUND→RESUMED | Snapshot sem avanço indevido | N/A |
| background during purchase | SYNC_REQUIRED/ERROR conforme autoridade | Sem unlock local indevido | Autoridade externa |
| offline resume | READY/ERROR conforme política | Sem corrupção | Não inferir entitlement |
| reinstall | READY após bootstrap | Recuperação conforme autoridade definida | Restore somente se aprovado |

## Referências

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[2]: ../concept-brief.md "Graffiti Ghosts concept brief"
[3]: ../core-loop-design.md "Graffiti Ghosts core-loop design"
[4]: ../technical-and-demo-spec.md "Graffiti Ghosts technical and demo specification"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
