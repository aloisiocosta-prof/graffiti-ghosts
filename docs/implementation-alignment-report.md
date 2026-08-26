# Relatório de Alinhamento GDD → Flutter

**Projeto:** Graffiti Ghosts
**Data:** 26 de agosto de 2026
**PR principal:** [#21](https://github.com/aloisiocosta-prof/graffiti-ghosts/pull/21)
**Branch:** `feature/17-gdd-raid-alignment` → `develop`

## Resultado executivo

A aplicação deixou de ser uma tela demonstrativa baseada em um único percentual de progresso e passou a conter um vertical slice jogável coerente com o core loop documentado: **infiltrar, usar acrobacias e stealth, roubar, escapar, comparar com o fantasma e progredir**. O incremento inclui seleção da fortaleza, raid determinística, jump, wall-grab, slide, graffiti mágico limitado, rota secreta, atalho temporário, alteração de armadilha, detecção, chase, rota alternativa, roubo, extração, captura, segunda chance, score combinado, resultados, bônus econômico separado e hideout.

A integração visual agora usa o material existente do repositório por meio de um manifesto centralizado. O bundle de produção não empacota automaticamente todas as referências conceituais; somente os assets necessários ao runtime atual são declarados no `pubspec.yaml`, enquanto os gaps do inventário permanecem explícitos para validação futura.

## Matriz de entrega

| Área | Implementação | Evidência | Status |
|---|---|---|---|
| Core loop | Estados e ações em `RaidService` e `RaidController` | Testes de domínio e widget | IMPLEMENTED |
| Movimento | Move, jump, wall-grab e slide com controles touch e teclado | `raid_screen.dart`; widget smoke | IMPLEMENTED |
| Stealth/chase | Detecção ao entrar na zona de risco e escolha de rota alternativa | `RAID-OUTCOME-002/003`; widget test | IMPLEMENTED |
| Graffiti | Uma carga por raid, revela rota, cria atalho e altera armadilha | `GRAFFITI-001/002`; domain test | IMPLEMENTED |
| Captura | Reset com perda de tesouro e segunda chance com checkpoint e penalidades | `RAID-OUTCOME-001/004`; domain test | IMPLEMENTED |
| Score | Componentes bounded de tempo, treasure e falhas, com pesos 40/40/20 | `GhostScoreService`; domain test | IMPLEMENTED |
| Monetização | Bônus econômico opcional não altera score competitivo | Result flow e `RaidController` | SIMULATED / provider deferred |
| Progressão | Tesouro bancado, reputação, storage, unlock cosmético e hideout | Results/base screens | IMPLEMENTED |
| Fantasma | Benchmark visual e silhouette no raid/result | Manifesto e painter | PARTIAL; replay persistente aberto |
| Assets | Manifesto, paths runtime e documentação de gaps | `asset-traceability.md`; `pubspec.yaml` | IMPLEMENTED with explicit gaps |
| Arquitetura | `core`, `domain`, `application`, `infrastructure` preparada e `presentation` | Import-boundary check | IMPLEMENTED for current slice |
| Acessibilidade | Semantics, controles grandes, teclado e redundância visual/textual | Widget semantics test | PARTIAL; device audit aberto |

## Processo e rastreabilidade

O backlog foi registrado no GitHub antes da implementação. A mudança principal está vinculada à [Issue #17](https://github.com/aloisiocosta-prof/graffiti-ghosts/issues/17), com follow-ups em [#18](https://github.com/aloisiocosta-prof/graffiti-ghosts/issues/18), [#19](https://github.com/aloisiocosta-prof/graffiti-ghosts/issues/19) e [#20](https://github.com/aloisiocosta-prof/graffiti-ghosts/issues/20). O PR #21 contém `Closes #17` e referências aos follow-ups.

A branch `develop` foi criada para restabelecer o fluxo Gitflow. Os commits são Conventional Commits e permanecem pequenos e localizáveis:

| Commit | Tipo | Escopo |
|---|---|---|
| `e7f174f` | `feat` | Vertical slice alinhado ao GDD |
| `039070d` | `fix` | Correções do analisador Flutter |
| `7c85dc0` | `test` | Scroll dos controles em viewport de teste |
| `5fce29a` | `test` | Asserções semânticas compostas |
| `1e1b8e3` | `perf` | Exclusão de referências do bundle |
| `8fb6ddc` | `perf` | Manifesto runtime limitado |
| `f277911` | `docs` | Evidências, validação e registro Gitflow |

## Validação

O run de CI [33007191138](https://github.com/aloisiocosta-prof/graffiti-ghosts/actions/runs/33007191138) passou em análise estática, testes TDD, Conventional Commits, secret scan, build Web/Wasm, build Android APK e auditoria de performance/bundle. O bundle Web/Wasm final ficou em **64.925 KB**, com **29.751 KB de Wasm**, abaixo dos thresholds de 70.000 KB e 40.000 KB.

A validação de CI não substitui a validação em dispositivo real. Permanecem necessários um playtest Android, revisão de contraste e legibilidade em telas estreitas, confirmação do dispositivo de demonstração, persistência local, replay persistente e decisão sobre integração real de anúncios.

## Próximos incrementos

O próximo incremento recomendado é o [Issue #20](https://github.com/aloisiocosta-prof/graffiti-ghosts/issues/20), porque deve validar a experiência em dispositivo e confirmar se o primeiro minuto realmente demonstra movimento, obstáculo, graffiti, chase, recompensa e comparação com fantasma. Em seguida, o [Issue #18](https://github.com/aloisiocosta-prof/graffiti-ghosts/issues/18) deve substituir ou completar os assets conceituais por produção, e o [Issue #19](https://github.com/aloisiocosta-prof/graffiti-ghosts/issues/19) deve aprofundar ports, adapters, persistência e replay.

> Nenhuma decisão aberta do GDD foi convertida silenciosamente em requisito permanente. Os parâmetros de balanceamento, persistência, replay, anúncios, assets ausentes e dispositivo de demonstração continuam marcados como provisórios ou pendentes de validação.

## Referências

[1]: https://github.com/aloisiocosta-prof/graffiti-ghosts/blob/develop/docs/core-loop-design.md "Core Loop Design"
[2]: https://github.com/aloisiocosta-prof/graffiti-ghosts/blob/develop/docs/technical-and-demo-spec.md "Technical and Demo Specification"
[3]: https://github.com/aloisiocosta-prof/graffiti-ghosts/blob/develop/docs/visual-style-guide.md "Visual Style Guide"
[4]: https://github.com/aloisiocosta-prof/graffiti-ghosts/blob/develop/docs/traceability-matrix.md "Traceability Matrix"
[5]: https://github.com/aloisiocosta-prof/graffiti-ghosts/blob/develop/docs/asset-traceability.md "Asset Traceability"
