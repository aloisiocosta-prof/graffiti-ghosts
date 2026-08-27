# 01 — Graffiti Ghosts Game Design Document Master

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

## Referências

[1]: ../references/deep-research-report.md "Relatório de pesquisa fornecido pelo usuário"
[2]: ../concept-brief.md "Graffiti Ghosts concept brief"
[3]: ../core-loop-design.md "Graffiti Ghosts core-loop design"
[4]: ../technical-and-demo-spec.md "Graffiti Ghosts technical and demo specification"
[5]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic development rules"
