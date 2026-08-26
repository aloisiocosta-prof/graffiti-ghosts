from pathlib import Path

root = Path(__file__).resolve().parents[1]
gdd = root / "docs" / "gdd"
gdd.mkdir(parents=True, exist_ok=True)

refs = """\n## Referências\n\n[1]: ../references/deep-research-report.md \"Relatório de pesquisa fornecido pelo usuário\"\n[2]: ../concept-brief.md \"Graffiti Ghosts concept brief\"\n[3]: ../core-loop-design.md \"Graffiti Ghosts core-loop design\"\n[4]: ../technical-and-demo-spec.md \"Graffiti Ghosts technical and demo specification\"\n[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md \"Graffiti Ghosts agentic development rules\"\n"""

files = {
"00-GDD-MASTER-README.md": """# Graffiti Ghosts — GDD Master Index

## Objetivo

Este conjunto de documentos é a fonte de verdade para transformar decisões de design do Graffiti Ghosts em especificações implementáveis, testáveis e rastreáveis.[2] [3]

O relatório de pesquisa anexado é utilizado como referência metodológica para desenvolvimento orientado por especificação, autoria orientada por perguntas, contratos de agentes, telemetria, assets e registro de decisões.[1]

## Regra central

> Código implementa decisões documentadas; código não deve inventar decisões de design.

Exemplos genéricos de Shipaton, puzzle-platformer, moedas, anúncios, preços, subscriptions e produtos RevenueCat presentes no relatório não são requisitos do Graffiti Ghosts sem uma decisão explícita do cliente.[1]

## Pipeline

`IDEA → RESEARCH → DESIGN → SPECIFY → PLAN → TASKS → IMPLEMENT → TEST → REVIEW → VERIFY → DOCUMENT → RELEASE`.[1] [5]

## Artefatos

| ID | Arquivo | Função | Estado |
|---|---|---|---|
| GDD-00 | `00-GDD-MASTER-README.md` | Índice, regras e fluxo | CONFIRMED |
| GDD-01 | `01-GDD-MASTER.md` | Conceito, fantasy, pilares e escopo | CONFIRMED + OPEN QUESTIONS |
| GDD-02 | `02-GAME-SPECIFICATION.md` | Mecânicas, loop, estados e progressão | CONFIRMED |
| GDD-03 | `03-ECONOMY-SPECIFICATION.md` | Recursos, faucets, sinks e balanceamento | OPEN QUESTIONS |
| GDD-04 | `04-MONETIZATION-REVENUECAT-SPECIFICATION.md` | Monetização condicional e entitlements | VALIDATION REQUIRED |
| GDD-05 | `05-LIFECYCLE-SPECIFICATION.md` | Estados da aplicação e recuperação | CONFIRMED + OPEN QUESTIONS |
| GDD-06 | `06-UX-UI-SPECIFICATION.md` | Telas, controles, feedback e acessibilidade | CONFIRMED + OPEN QUESTIONS |
| GDD-07 | `07-ASSET-BIBLE.md` | Direção visual, assets e proveniência | CONFIRMED + LICENSE VALIDATION |
| GDD-08 | `08-TECHNICAL-SPECIFICATION.md` | Flutter, Android, Web/WasmGC e arquitetura | CONFIRMED |
| GDD-09 | `09-QA-ACCEPTANCE-SPECIFICATION.md` | Testes, evidências e gates | CONFIRMED |
| GDD-10 | `10-AGENT-ORCHESTRATION.md` | Agentes, handoffs e stop conditions | CONFIRMED |
| GDD-11 | `11-TRACEABILITY-DECISION-LOG.md` | IDs, decisões, riscos e vínculos | CONFIRMED |
| GDD-12 | `12-PROJECT-GATES.md` | Definition of Ready/Done e gates | CONFIRMED |

## Estados de decisão

`DRAFT → RESEARCHING → DESIGNED → SPECIFIED → VALIDATED → READY → IMPLEMENTED → VERIFIED → DONE`.[1]

`[SOURCE FACT]`, `[CLIENT DECISION]`, `[AGENT RECOMMENDATION]`, `[ASSUMPTION]`, `[VALIDATION REQUIRED]`, `[CONFLICT]` e `[RISK]` devem aparecer quando aplicáveis.[5]

## Governança

Toda alteração não trivial deve possuir Issue, branch Gitflow, Conventional Commit, Pull Request, critérios de aceitação, testes e atualização da rastreabilidade.[5]
""" + refs,
"01-GDD-MASTER.md": """# 01 — Graffiti Ghosts Game Design Document Master

> Status: `SPECIFIED WITH OPEN QUESTIONS`
> Version: `0.2.0`
> Owner: `Game Director / Aloisio Costa`

## 1. Game Concept

**High Concept:** Graffiti Ghosts é um jogo de infiltração e plataforma em sessões curtas no qual um ladrão urbano-fantástico atravessa uma fortaleza, usa graffiti mágico, rouba tesouro, escapa da perseguição e compara a tentativa com um ghost replay.[2] [3]

**Player Fantasy:** O jogador deve sentir que é um infiltrador criativo, rápido e engenhoso que transforma rotas perigosas em uma assinatura visual própria.[2] [3]

**USP:** A combinação de stealth/acrobacia, graffiti mágico que altera a rota, perseguição legível e comparação assíncrona com o próprio ghost replay diferencia a raid sem depender de multiplayer síncrono.[3]

## 2. Design Pillars

| ID | Pilar | Comportamento observável | O que não fazer |
|---|---|---|---|
| P-001 | Infiltração legível | O jogador identifica risco, rota alternativa e consequência antes de agir. | Não usar detecção arbitrária ou feedback exclusivamente por cor. |
| P-002 | Criatividade com graffiti | O graffiti cria uma decisão de rota, plataforma ou escape observável. | Não tratar graffiti como efeito cosmético sem função. |
| P-003 | Maestria por repetição | Ghost comparison, score e retry tornam a melhoria compreensível. | Não exigir grind ou monetização para tornar a raid divertida. |
| P-004 | Sessão curta e intensa | Uma tentativa apresenta movimento, obstáculo, recompensa e graffiti memorável nos primeiros 60 segundos. | Não atrasar o core loop com menus ou sistemas não essenciais. |
| P-005 | Urban fantasy reconhecível | Arte, UI e áudio reforçam cidade, magia, fortaleza e identidade do ladrão. | Não misturar estilos sem decisão de direção visual. |

## 3. Audience / Platform

| Campo | Decisão/estado |
|---|---|
| Público | `[VALIDATION REQUIRED]` Jogadores de sessões curtas interessados em stealth, plataforma e fantasia urbana. |
| Android | `[CLIENT DECISION]` Plataforma principal de demonstração e distribuição. API mínima/target ainda devem ser confirmadas no projeto Android. |
| Flutter | `[SOURCE FACT]` Implementação em Dart/Flutter com APIs oficiais priorizadas.[4] |
| Web/WasmGC | `[CLIENT DECISION]` Flutter Web compilado com `flutter build web --wasm`; Cloudflare Worker publica `build/web`. |
| Sessão-alvo | `[ASSUMPTION]` Aproximadamente 2–5 minutos por raid; validar por playtest. |
| Modelo | `[CLIENT DECISION]` Single-player com ghost replay assíncrono; multiplayer síncrono não faz parte do MVP. |

## 4. Core Experience

A unidade de experiência é uma raid curta: o jogador infiltra, escolhe movimento e rota, ativa graffiti mágico, coleta ou rouba tesouro, reage à detecção, escapa, recebe score, compara o replay e decide entre upgrade e retry.[3]

O código atual já demonstra movimento, graffiti, chase, treasure, score determinístico e painel de resultado; a implementação de produção deve continuar referenciada pelos contratos de `02-GAME-SPECIFICATION.md`.[3] [4]

## 5. Scope

### Must

- Movimento lateral, salto/acrobacia, coleta/roubo de tesouro, graffiti mágico, detecção/chase, escape, score, ghost comparison e retry.[3]
- Progressão inicial do hideout com impacto visual e funcional documentado.[2] [3]
- Android e Web/WasmGC com dependências de runtime limitadas a Dart native libraries e Flutter SDK native packages.[4] [5]

### Should

- Feedback acessível para detecção, graffiti, treasure, score e chase.[5]
- Tutorial/FTUE que ensine movimento, risco, graffiti e recompensa no primeiro minuto.[1]
- Telemetria anônima somente após aprovação de provedor e política de consentimento.[1]

### Could

- Conteúdo adicional de fortaleza, famílias de graffiti, variações de ghost e personalização cosmética.[2]
- Monetização por cosméticos ou outras ofertas éticas, somente após decisão formal.[1]

### Won't for current MVP

- Multiplayer síncrono, dependência de engine externa, pacote não validado para WasmGC, anúncios obrigatórios, paywall do core loop e produtos RevenueCat não aprovados.[1] [5]

## 6. Success Criteria

| ID | Critério | Métrica/Evidência | Target |
|---|---|---|---|
| SUC-001 | Core loop executável | Teste de widget/smoke e demonstração | Infiltrate→Retry completo sem crash |
| SUC-002 | Score determinístico | Testes unitários | Mesma entrada produz mesmo score |
| SUC-003 | Primeiro minuto legível | Playtest observacional | Movimento, obstáculo, recompensa e graffiti percebidos |
| SUC-004 | Compatibilidade WasmGC | `flutter build web --wasm` + Cloudflare build | Artefatos `main.dart.wasm` e bootstrap presentes |
| SUC-005 | Arquitetura protegida | Análise estática/review | Domain/application sem APIs de plataforma |

## 7. Open Questions

- Q-001: Qual público e faixa etária prioritária devem orientar dificuldade, acessibilidade e comunicação?
- Q-002: Qual duração média deve ser confirmada por playtest?
- Q-003: Quais currencies, custos e ritmo de hideout devem ser aprovados?
- Q-004: Monetização fará parte do MVP?
- Q-005: Qual política de persistência, checkpoints e offline será adotada?
- Q-006: Quais assets têm licença e proveniência verificáveis?

## 8. Dependencies

O documento depende de `02-GAME-SPECIFICATION.md`, `03-ECONOMY-SPECIFICATION.md`, `05-LIFECYCLE-SPECIFICATION.md`, `06-UX-UI-SPECIFICATION.md`, `07-ASSET-BIBLE.md`, `08-TECHNICAL-SPECIFICATION.md` e `09-QA-ACCEPTANCE-SPECIFICATION.md`.[1]
""" + refs,
"02-GAME-SPECIFICATION.md": """# 02 — GAME SPECIFICATION

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
| GD-MECH-005 | Score | Resultado da tentativa | Score atual combina tempo, treasure e falhas em faixa limitada de 0–1000. | Painel de resultado e ghost comparison. | Score nunca negativo nem acima do limite definido. |
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
- [ ] Timing, persistência, captura, recarga de graffiti e tuning final precisam de testes/decisões adicionais.
- [ ] Cada mecânica nova deve adicionar teste e Issue antes do código.[5]
""" + refs,
"03-ECONOMY-SPECIFICATION.md": """# 03 — ECONOMY SPECIFICATION

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
""" + refs,
"04-MONETIZATION-REVENUECAT-SPECIFICATION.md": """# 04 — MONETIZATION + REVENUECAT SPECIFICATION

## Status

`[VALIDATION REQUIRED]` Monetização não está aprovada para o MVP atual, e os produtos/preços do relatório são exemplos genéricos.[1]

## 1. Business Model

| Campo | Estado |
|---|---|
| Modelo | `[DECIDIR]` F2P, premium ou híbrido |
| Monetização primária | `[VALIDATION REQUIRED]` |
| Monetização secundária | `[VALIDATION REQUIRED]` |
| Plataforma de compra | Android/loja a confirmar; Web/WasmGC não deve presumir billing Android |

## 2. Catalog

| ID | Store Product | RevenueCat Product | Package | Offering | Entitlement | Feature | Status |
|---|---|---|---|---|---|---|---|
| MON-001 | `[DECIDIR]` | `[DECIDIR]` | `[DECIDIR]` | `[DECIDIR]` | `[DECIDIR]` | `[DECIDIR]` | VALIDATION REQUIRED |

## 3. Entitlement Contract

```text
STORE PRODUCT
→ REVENUECAT PRODUCT
→ PACKAGE/OFFERING
→ ENTITLEMENT
→ FEATURE ACCESS
```

O domínio deve depender de um `MonetizationPort`, enquanto o RevenueCat permanece em um adapter de infraestrutura; nenhum tipo do SDK pode vazar para domain/application.[5]

## 4. Purchase State Machine

```text
UNKNOWN → LOADING → AVAILABLE → PURCHASING → CONFIRMED → ENTITLEMENT_ACTIVE
                                      ├→ FAILED
                                      └→ CANCELLED
CONFIRMED → SYNC_REQUIRED → ENTITLEMENT_ACTIVE
```

## 5. Restore / Sync

`restorePurchases` deve ser uma ação explícita do usuário, e qualquer sincronização automática deve seguir uma decisão de lifecycle e autoridade de dados.[1]

Os comportamentos para offline, troca de usuário, reinstalação, refund, expiration e identidade permanecem `[VALIDATION REQUIRED]`.[1]

## 6. Monetization Integrity Invariants

- [ ] Operações idempotentes.
- [ ] Retry não duplica benefício.
- [ ] Entitlement não depende somente de cache de UI.
- [ ] Compra confirmada não é perdida por background.
- [ ] Restore possui teste.
- [ ] Identidade possui regra explícita.

## 7. Ethical Constraints

A monetização não pode ser necessária para compreender o jogo, completar a raid básica ou corrigir um core loop sem diversão.[1]

## 8. Acceptance Criteria

A implementação somente poderá iniciar após produto, preço, entitlement, plataforma, autoridade, consentimento, restore e testes de falha serem aprovados pelo cliente.[1] [5]
""" + refs,
"05-LIFECYCLE-SPECIFICATION.md": """# 05 — APPLICATION LIFECYCLE SPECIFICATION

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
""" + refs,
"06-UX-UI-SPECIFICATION.md": """# 06 — UX/UI SPECIFICATION

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
""",
"07-ASSET-BIBLE.md": """# 07 — ASSET BIBLE

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
""",
"08-TECHNICAL-SPECIFICATION.md": """# 08 — TECHNICAL SPECIFICATION

## 1. Technology Constraints

| Item | Decision |
|---|---|
| Language | Dart |
| Framework | Flutter |
| Shared runtime dependencies | Dart native libraries and Flutter SDK native packages only |
| Android | Native Flutter app with platform adapters when capabilities are needed |
| Web | Flutter Web compiled with `flutter build web --wasm` / WasmGC |
| Hosting | Cloudflare Worker serving `build/web` |
| External SDKs | Prohibited in shared code; exceptions require ADR and compatibility matrix |

## 2. Architecture Contract

```text
Presentation
    ↓
Application
    ↓ ports
Domain
    ↓ ports
Infrastructure
    ├── Android adapter → MethodChannel/EventChannel/BasicMessageChannel → Kotlin/Android SDK
    └── Web/Wasm adapter → package:web / dart:js_interop → Browser APIs
```

Domain and application must not import Android, Web, Wasm, Flutter platform channels, `dart:io`, `dart:ffi`, `dart:html`, `dart:js`, `dart:js_util` or `package:js`.[5]

## 3. Package Matrix

| Package/API | Purpose | Android | Web | WasmGC | Risk | Alternative | Status |
|---|---|---:|---:|---:|---|---|---|
| `dart:async`, `dart:collection`, `dart:convert`, `dart:math`, `dart:typed_data` | Shared logic | Yes | Yes | Yes | Low | None needed | APPROVED |
| `package:flutter/*` | UI/rendering/input | Yes | Yes | Yes | Low | None needed | APPROVED |
| `package:web` | Web adapter APIs | No | Yes | Validate | Medium | None legacy | GATED |
| `dart:js_interop` | Web adapter interop | No | Yes | Validate | Medium | None legacy | GATED |
| RevenueCat | Monetization | Conditional | Conditional | Conditional | High | Native store adapter | NOT APPROVED |

## 4. Platform Matrix

| Feature | Android | Web-JS | Web-WasmGC | Decision |
|---|---:|---:|---:|---|
| Raid rules/rendering | Yes | Yes | Yes | Shared Dart/Flutter |
| Android billing | Conditional | No | No | Only after monetization approval |
| Browser APIs | No | Yes | Validate | Web adapter only |
| Ghost replay/score | Yes | Yes | Yes | Deterministic shared logic |
| COOP/COEP | N/A | Hosting concern | Hosting concern | Worker headers configured |

## 5. Persistence

| Data | Format | Frequency | Recovery | Authority |
|---|---|---|---|---|
| Current raid snapshot | `[DECIDIR]` | Checkpoint/background | Retry or resume | Local until policy approved |
| Hideout progression | `[DECIDIR]` | Reward resolution | Restore from durable source | `[DECIDIR]` |
| Entitlement | Provider response if approved | On purchase/restore | User-triggered restore | External authority |

## 6. Performance Budgets

Startup, frame budget, memory, asset size and network budget remain `[VALIDATION REQUIRED]`; current Web/Wasm performance evidence is tracked by `docs/web-wasm-load-performance-plan.md`.[4]

## 7. Technical Decision Rule

Nenhuma dependência entra no projeto sem purpose, compatibility Android/Web/WasmGC, maintenance, risk, license, bundle impact e alternative.[1] [5]

## References

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[4]: ../technical-and-demo-spec.md "Graffiti Ghosts technical and demo specification"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
""",
"09-QA-ACCEPTANCE-SPECIFICATION.md": """# 09 — QA + ACCEPTANCE SPECIFICATION

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
""",
"10-AGENT-ORCHESTRATION.md": """# 10 — AGENT ORCHESTRATION

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
""",
"11-TRACEABILITY-DECISION-LOG.md": """# 11 — TRACEABILITY + DECISION LOG

## 1. Requirement IDs

`GD` game design, `ECO` economy, `MON` monetization, `UX` UX/UI, `ART` assets, `AUD` audio, `LIF` lifecycle, `ENG` engineering, `QA` quality and `REL` release.[1]

## 2. Traceability Matrix

| Requirement | Source | Decision | Spec | Implementation | Test | Status |
|---|---|---|---|---|---|---|
| GD-001 Core loop | `docs/core-loop-design.md` | ADR-003 | GDD-01/GDD-02 | `lib/main.dart` | QA-001–QA-007 | CONFIRMED |
| GD-002 Score 40/40/20 model | Existing project tests | Existing decision | GDD-02 | `lib/main.dart`, `test/score_test.dart` | score tests | CONFIRMED |
| GD-003 Graffiti action | Existing project context | Existing decision | GDD-02/GDD-07 | `lib/main.dart`, assets | QA-003 | CONFIRMED |
| ECO-001 Treasure/hideout | Existing GDD context | Open tuning | GDD-03 | Current raid state | QA-006/QA-007 | OPEN |
| MON-001 RevenueCat | Research pattern only | ADR-005 | GDD-04 | No adapter yet | Conditional tests | VALIDATION REQUIRED |
| LIF-001 Lifecycle | Research + project rules | ADR-007 | GDD-05 | Adapter/tests pending | Lifecycle matrix | OPEN |
| UX-001 Raid HUD | Existing visual references | Existing visual decision | GDD-06/GDD-07 | `lib/main.dart` | Widget/smoke | CONFIRMED |
| ENG-001 Native-only dependencies | Client constraint | ADR-004 | GDD-08 | `pubspec.yaml` | CI/import scan | CONFIRMED |
| ENG-002 WasmGC deployment | Client/platform context | Cloudflare ADR | GDD-08 | `tool/cloudflare/build.sh` | Workers Build | CONFIRMED |

## 3. Decision Log

| ID | Decision | Rationale | Evidence | Dependencies | Impact | Status |
|---|---|---|---|---|---|---|
| ADR-001 | Spec-driven workflow | Prevent code from silently deciding design | Research report | All GDD specs | Adds gates | ACCEPTED |
| ADR-002 | Question-driven GDD | Expose unknowns and acceptance | Research report | GDD sections | Standardizes docs | ACCEPTED |
| ADR-003 | Retain Graffiti Ghosts core loop | Generic report loop is not this game | Existing core loop | Game Spec | Protects identity | ACCEPTED |
| ADR-004 | Dart/Flutter SDK-only runtime | WasmGC/platform compatibility and client constraint | User context/Tech Spec | Dependency matrix | Rejects unapproved packages | ACCEPTED |
| ADR-005 | Monetization conditional | No explicit product/pricing decision | Research examples only | Economy/platform | Blocks RevenueCat code | VALIDATION REQUIRED |
| ADR-006 | Clean Architecture + adapters | Prevent platform leakage | Project rules | Tech Spec | Defines module boundaries | ACCEPTED |
| ADR-007 | Explicit lifecycle machine | Protect state/reward integrity | Research report | Persistence policy | Adds recovery tests | ACCEPTED |
| ADR-008 | Anonymous telemetry schema-first | Avoid privacy and coupling risks | Research report | Provider/consent | Instrumentation gated | VALIDATION REQUIRED |

## 4. ADR Template

### ADR-[NNN] — [TITLE]

**Context:** [SOURCE FACT]

**Problem:** [UNKNOWN/CONFLICT]

**Options:** documented alternatives.

**Decision:** `[CLIENT DECISION]` or `[AGENT RECOMMENDATION]`.

**Rationale:** evidence-linked explanation.

**Consequences:** implementation, platform, economy, UX and test impact.

**Status:** PROPOSED, ACCEPTED, SUPERSEDED or VALIDATION REQUIRED.

## References

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
""",
"12-PROJECT-GATES.md": """# 12 — PROJECT GATES

## Gate 0 — Concept Ready

- [x] High concept, fantasy, pillars, initial platform and core scope are documented.[2] 
- [ ] Audience and session target validated by client/playtest.

## Gate 1 — Gameplay Ready

- [x] Core loop, initial mechanics, score, feedback, success and retry are documented.[3]
- [ ] Timing, failure/capture, persistence and tuning are fully evidenced.

## Gate 2 — Economy Ready

- [ ] Currencies/resources, sources, sinks, rates, hypotheses and balance simulation approved.[1]

## Gate 3 — Monetization Ready

- [ ] Products, offerings, packages, entitlements, purchase states, restore, failure and ethical constraints approved.[1]
- Current status: `NOT READY / VALIDATION REQUIRED`.

## Gate 4 — Lifecycle Ready

- [x] State vocabulary and recovery obligations documented.[1] [5]
- [ ] Persistence authority, offline behavior, identity and process-death rules approved.

## Gate 5 — UX/Assets Ready

- [x] Screen contracts, onboarding intent, feedback and accessibility gates documented.[5]
- [ ] Final asset provenance, licenses, audio contracts and production acceptance completed.

## Gate 6 — Technical Ready

- [x] Architecture, native-only dependency rule, platform matrix and WasmGC deployment documented.[4] [5]
- [ ] Performance budgets and complete Android platform evidence approved.

## Gate 7 — Prototype Ready

- [x] Vertical slice exists with core movement, graffiti, chase, score and result flow.[3]
- [ ] Critical uncertainty, measurable playtest hypothesis and playtest evidence recorded.

## Gate 8 — Implementation Ready

- [ ] All P0 specifications approved.
- [x] Acceptance tests exist for the current vertical slice.
- [x] Dependencies are constrained and validated.

## Gate 9 — Done

- [ ] Implementation matches all approved specs.
- [ ] Full tests, telemetry, lifecycle, accessibility and release evidence pass.
- [ ] Documentation and traceability are synchronized.

## P0 STOP RULE

If a requirement is ambiguous enough that two developers could implement different behaviors, the specification is not ready and the agent must stop before coding.[1] [5]

## References

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[2]: ../concept-brief.md "Graffiti Ghosts concept brief"
[3]: ../core-loop-design.md "Graffiti Ghosts core-loop design"
[4]: ../technical-and-demo-spec.md "Graffiti Ghosts technical and demo specification"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
"""
}

for name, text in files.items():
    (gdd / name).write_text(text.strip() + "\n", encoding="utf-8")
print(f"generated {len(files)} GDD files in {gdd}")
