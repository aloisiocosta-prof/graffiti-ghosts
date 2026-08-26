# Graffiti Ghosts — GDD Master Index

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

## Referências

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[2]: ../concept-brief.md "Graffiti Ghosts concept brief"
[3]: ../core-loop-design.md "Graffiti Ghosts core-loop design"
[4]: ../technical-and-demo-spec.md "Graffiti Ghosts technical and demo specification"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
