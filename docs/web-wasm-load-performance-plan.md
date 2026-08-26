# Graffiti Ghosts — Plano de Testes de Carga e Otimização Web/Wasm

**Versão:** 0.1  
**Status:** DRAFT — critérios quantitativos sujeitos a baseline real  
**Escopo:** MVP Web compilado com `flutter build web --wasm --release`  
**Plataforma:** Navegador desktop e mobile com suporte a WasmGC, com fallback JavaScript verificado separadamente  
**Fonte de verdade:** `docs/technical-and-demo-spec.md`, `docs/core-loop-design.md` e requisitos do vertical slice

## 1. Objetivo e princípio de medição

O objetivo é garantir que Graffiti Ghosts entregue uma raid curta, responsiva e visualmente estável no navegador, sem que o uso de WebAssembly, CustomPainter, spritesheets, HUD ou replay de fantasmas introduza jank, bloqueios de interação, crescimento de memória ou tempo de carregamento incompatível com uma demonstração convincente.

O plano mede o produto em **três dimensões distintas**: carregamento inicial, desempenho de execução e estabilidade sob repetição. Não se deve aprovar o jogo apenas porque ele apresenta uma boa média de FPS em um computador rápido. Cada resultado deve identificar navegador, versão do Flutter, modo de compilação, resolução, dispositivo, CPU/network throttling, modo Wasm ou JavaScript fallback, commit e tag testados.

> Flutter recomenda perfilar aplicações Web em profile mode usando o Chrome DevTools Performance Panel, que recebe eventos de timeline do framework, incluindo construção de frames, desenho de cenas e garbage collection. [1]

A documentação também recomenda medir em hardware real e não usar debug mode ou emuladores como representação do comportamento de release. [2] Para Wasm, o build deve ser testado em navegador compatível e servido por HTTP; a aplicação pode cair para JavaScript quando o suporte WasmGC não estiver disponível. [3]

## 2. Modelo de carga específico do jogo

Graffiti Ghosts não é um servidor de partidas que precise simular milhares de usuários concorrentes no cliente. O “teste de carga” do MVP é principalmente **carga de renderização, input, replay, memória e repetição de sessões**. Testes de backend ou de rede multiplayer não fazem parte do escopo atual, porque os fantasmas são reproduções assíncronas e a especificação não definiu um serviço remoto obrigatório.

| Tipo de carga | O que representa | Resultado esperado |
|---|---|---|
| Carga de boot | Primeira abertura da aplicação Web/Wasm, sem cache | Mensurará download, compilação, inicialização Flutter e primeira interação |
| Carga de raid | Uma sessão inferior a três minutos com HUD, movimento, obstáculos, grafite, perseguição e fantasma | Frames estáveis e input responsivo |
| Pico visual | Ativação simultânea de grafite mágico, rota alternativa, partículas/efeitos e HUD de perseguição | Nenhuma degradação crítica ou frame longo recorrente |
| Carga de replay | Execução contínua do fantasma por uma tentativa completa | Reprodução determinística sem crescimento anormal de memória |
| Carga de repetição | 20 raids consecutivas com reinício, captura, checkpoint e resultado | Memória retorna a uma faixa estável; sem degradação progressiva |
| Carga de viewport | Redimensionamento entre resoluções desktop e mobile | Layout sem overflow, input utilizável e custo previsível |
| Carga de fallback | Execução sem WasmGC, quando o navegador usa JavaScript | Funcionalidade preservada; diferença de desempenho registrada |

## 3. Matriz de ambientes

A matriz abaixo é uma proposta de cobertura. Os dispositivos exatos devem ser preenchidos antes do primeiro gate de release; não devem ser inventados retrospectivamente.

| Perfil | Hardware/browser | Modo | Objetivo |
|---|---|---|---|
| W1 — referência desktop | Computador do desenvolvimento, Chrome estável | Wasm release/profile | Baseline e investigação |
| W2 — desktop alternativo | Firefox ou Edge estável compatível | Wasm e fallback quando aplicável | Compatibilidade de navegador |
| M1 — Android móvel alto | Dispositivo físico usado na demonstração, Chrome estável | Web/Wasm | Evidência principal do jurado |
| M2 — Android móvel médio | Dispositivo físico intermediário | Web/Wasm | Limite de usabilidade e jank |
| M3 — Android móvel baixo | Dispositivo físico mais lento razoavelmente esperado | Web/fallback | Pior caso aceitável |
| N1 — rede rápida | Rede local ou Wi-Fi confiável | Cold e warm cache | Baseline de carregamento |
| N2 — rede limitada | Throttling documentado no DevTools | Cold cache | Primeira visita realista |
| C1 — CPU limitada | CPU throttling calibrado/documentado | Wasm | Sensibilidade a CPU |
| C2 — memória pressionada | Navegador com outras abas ou condição equivalente controlada | Wasm | Resiliência de memória |

O Chrome DevTools permite aplicar throttling de rede e CPU, mas a própria documentação alerta que CPU throttling é relativo ao computador e não reproduz perfeitamente a arquitetura de um telefone; por isso, os resultados de M1–M3 em hardware real têm precedência sobre C1. [4]

## 4. Métricas e definição operacional

### 4.1 Carregamento

| Métrica | Como medir | Critério inicial de aceite |
|---|---|---|
| `T0→shell` | Navegação até a primeira tela interativa | Definir baseline; sem tela congelada ou erro fatal |
| `T0→raid-ready` | Navegação até a raid aceitar input | P95 ≤ 5 s em W1/N1; alvo a validar em M2/N2 |
| Peso transferido | Network panel, com e sem cache | Registrar comprimido e não comprimido; evitar regressão > 15% sem decisão |
| Tempo de compilação/boot Wasm | Trace de load e logs do navegador | Registrar separadamente de download |
| Primeira pintura útil | Trace/Performance panel | Deve ocorrer antes de carregar conteúdo não essencial |
| Erros de boot | Console, logs e fallback | Zero erros não tratados em navegadores suportados |

Os valores acima são **metas de engenharia iniciais**, não medições já observadas. Devem ser substituídos por baseline, mediana e P95 após cinco execuções cold-cache por ambiente.

### 4.2 Execução da raid

Flutter visa aproximadamente 60 FPS, ou 120 FPS em dispositivos compatíveis; a referência de 60 FPS corresponde a cerca de 16 ms por frame. [2] Para o MVP, os gates devem usar tempo de frame e percentis, não apenas FPS médio.

| Métrica | Coleta | Gate proposto |
|---|---|---|
| Frame time mediano | DevTools/trace | ≤ 16,7 ms em W1; alvo a validar no Android |
| P95 frame time | DevTools/trace | ≤ 20 ms no cenário normal |
| P99 frame time | DevTools/trace | Sem sequência recorrente > 33,3 ms no cenário normal |
| Jank perceptível | Trace + inspeção visual | Zero jank bloqueante durante input, salto, escape e coleta |
| Latência input→feedback | Trace customizado | ≤ 100 ms como meta inicial; confirmar em M1/M2 |
| Tempo em UI thread | Timeline | Nenhum handler individual bloqueante durante a raid |
| Tempo de paint | Performance overlay/trace | Investigar qualquer pico correlato a VFX/HUD |
| Rebuilds | flags de profiling e inspeção | Nenhum rebuild de árvore ampla por input de frame |
| GC/picos de alocação | Timeline de garbage collection | Sem GC recorrente sincronizado com movimento ou replay |

### 4.3 Memória e estabilidade

| Métrica | Procedimento | Critério |
|---|---|---|
| Heap após boot | Capturar baseline depois da tela pronta | Registrar valor por ambiente |
| Heap após raid | Capturar após resultado | Crescimento explicado por assets/cache |
| Heap após 20 raids | Repetir fluxo completo | Sem crescimento monotônico não explicado |
| Contagem de imagens carregadas | DevTools/implementação de diagnóstico | Limite documentado por atlas e tela |
| Context loss/crash | 20 raids + resize + background/foreground quando aplicável | Zero crash ou perda de estado não tratada |
| Replay inválido | Evento corrompido ou fora de ordem | Falha segura, sem loop ou concessão de recompensa |

### 4.4 Experiência Web

Core Web Vitals são métricas de página e não substituem o frame pacing do jogo. Ainda assim, devem ser registradas no shell Web: LCP, CLS e INP, além de tamanho transferido e erros de carregamento. O Performance Panel oferece tela de métricas ao vivo e gravação de interações e layout shifts. [5]

| Métrica | Uso no jogo | Critério |
|---|---|---|
| LCP | Qualidade do shell antes da experiência interativa | Registrar; investigar elemento inicial pesado |
| CLS | Estabilidade do canvas/container | Sem mudança inesperada de layout após boot |
| INP | Resposta a input de navegação e UI | Registrar por interação; investigar picos |
| Canvas resize | Mudança de orientação/tamanho | Sem quebra de layout ou perda de input |

## 5. Cenários de teste

Cada cenário deve ser executado em Wasm release e, quando possível, no mesmo navegador em JavaScript fallback. Cada caso deve guardar trace, vídeo curto ou screenshot, console log, tamanho do build e resultado.

| ID | Cenário | Passos | Evidência |
|---|---|---|---|
| PERF-BOOT-001 | Cold boot Wasm | Limpar cache; abrir URL; medir até raid-ready | Trace de load + Network + console |
| PERF-BOOT-002 | Warm boot | Reabrir com cache; medir até raid-ready | Trace comparativo |
| PERF-RAID-001 | Raid normal | Executar movimento, salto, wall-grab, slide, coleta e conclusão | Trace de runtime |
| PERF-RAID-002 | Perseguição | Provocar detecção; escolher rota alternativa; escapar | Trace + gravação do input |
| PERF-RAID-003 | Grafite máximo | Ativar habilidade limitada perto de rota, plataforma e armadilha | Trace de paint/VFX |
| PERF-RAID-004 | Ghost replay | Assistir tentativa completa de fantasma em paralelo | Trace + verificação de determinismo |
| PERF-RAID-005 | Resultado | Concluir roubo perfeito; renderizar score, fantasma e recompensa | Trace de transição |
| PERF-FAIL-001 | Captura sem anúncio | Ser capturado; perder tesouro; reiniciar no início | Trace de estado e memória |
| PERF-FAIL-002 | Segunda chance | Ser capturado; reiniciar no checkpoint; aplicar penalidades | Trace + score antes/depois |
| PERF-REPEAT-001 | 20 sessões | Repetir raids com sucesso, captura, replay e reset | Série de heap/frames |
| PERF-VIEW-001 | Resize | Alternar viewport desktop/mobile e orientação quando suportado | Screenshots + console |
| PERF-FALLBACK-001 | JavaScript fallback | Desabilitar/indisponibilizar WasmGC conforme protocolo do navegador | Resultado funcional e comparativo |
| PERF-ERROR-001 | Replay inválido | Injetar evento fora de ordem/versão incompatível em fixture de teste | Log e resultado seguro |

## 6. Instrumentação permitida

A instrumentação deve permanecer atrás de uma configuração de diagnóstico e não deve mudar as regras do domínio. A documentação Flutter recomenda o Performance View/DevTools, Performance Overlay e tracing Dart; também permite emitir eventos próprios por `dart:developer` usando `Timeline` e `TimelineTask`. [1] [2]

### 6.1 Eventos customizados

Criar uma porta de diagnóstico no application/infrastructure, nunca no domínio, com eventos como:

| Evento | Início/fim | Dados permitidos |
|---|---|---|
| `boot.phase` | iniciar/finalizar | fase, build mode, wasm/fallback |
| `raid.frame_budget` | por janela | estado da raid, contador de entidades |
| `raid.input_to_feedback` | input até feedback visual | tipo de ação, sequência |
| `ghost.replay_step` | lote de eventos | versão, cursor, quantidade |
| `graffiti.activate` | habilidade até efeito | tipo de efeito, cooldown |
| `route.selection` | seleção até rota válida | nós, custo, resultado |
| `reward.resolve` | início/fim | quantidade de itens, sem dados pessoais |

Os eventos devem ser amostrados em profile/staging e desativados ou reduzidos no release final. Não registrar identificadores pessoais, conteúdo de usuário ou dados de monetização além do necessário para medir custo.

### 6.2 Scripts e artefatos

O repositório deve adicionar uma pasta `tool/performance/` com documentação e scripts somente quando houver implementação real. O pipeline deve armazenar:

- `build/web` compactado e manifesto de tamanho;
- trace JSON ou arquivo equivalente do DevTools;
- métricas CSV/JSON por cenário;
- console log sem dados sensíveis;
- commit SHA, tag, Flutter SDK, browser e perfil de dispositivo;
- relatório Markdown com regressões e decisão de aceite.

Para builds Wasm de diagnóstico, `--source-maps` pode ser usado para symbolication; `--no-strip-wasm` é reservado a staging/QA porque aumenta significativamente o tamanho do binário. [3]

## 7. Estratégia de otimização por ordem de impacto

A regra é **medir → identificar → alterar uma variável → repetir o mesmo cenário → comparar percentis**. Não otimizar por intuição antes de capturar trace.

### P0 — Bloqueadores de carregamento e funcionalidade

Corrigir erros de boot, incompatibilidade Wasm, fallback quebrado, canvas que não recebe input, crash, perda de estado e artefatos que impedem a raid de começar. O build Wasm deve ser testado com as dependências efetivamente usadas; a documentação Flutter exige compatibilidade das dependências e a criação/atualização correta do `web/index.html`. [3]

### P1 — Frame budget da raid

Reduzir `CustomPainter` e áreas de repaint desnecessárias. Separar camadas estáticas da fortaleza, trajetória do jogador, fantasma, HUD e efeitos de grafite; evitar repintar o cenário inteiro para cada input quando a arquitetura permitir. Atualizar apenas o estado visual necessário, manter listas de objetos estáveis e evitar alocações em loops de frame.

A lógica de score, rotas, checkpoints e replay deve continuar no domínio/application, fora do paint. BFS ou heap para rotas deve ocorrer em eventos de seleção, não a cada frame. O replay deve usar cursor sequencial e estruturas compactas, conforme a especificação técnica; não repetir parsing ou criação de objetos para o mesmo evento a cada frame.

### P1 — Assets e transferência

Manter spritesheets em atlas por função, remover imagens não usadas do build do MVP, dimensionar assets para a resolução real e evitar duplicação de bitmaps. Medir o impacto de cada atlas no peso transferido, tempo de decodificação e memória. Não trocar qualidade artística por compressão agressiva sem revisar legibilidade do grafite mágico e do fantasma.

### P2 — Estado e rebuilds

Aplicar fronteiras claras entre estado de raid e HUD. O input deve atualizar o agregado/estado necessário; widgets que não dependem desse estado não devem reconstruir. Preferir value objects e coleções imutáveis no domínio, mas evitar cópias repetitivas no caminho de renderização. O estado mutável de frame deve ficar confinado à camada de apresentação/infrastructure.

### P2 — Memória e repetição

Reutilizar objetos visuais de efeitos de curta duração quando o profiling demonstrar churn. Encerrar timers, streams e listeners no ciclo de vida correto. Liberar ou limitar caches de replay e assets. O Singleton permitido pela arquitetura não pode manter estado de gameplay ou esconder vazamentos; serviços devem continuar injetáveis e testáveis.

### P3 — Paralelismo e Wasm

Não introduzir `dart:isolate` apenas para “otimizar”. A especificação permite isolate somente quando profiling mostrar trabalho de CPU que bloqueia o frame. Primeiro reduzir o trabalho, o volume de dados e a frequência; depois comparar custo de serialização e benefício real em Wasm. O suporte a threads/múltiplos recursos do ambiente deve ser tratado como hipótese a validar, não como requisito presumido.

## 8. Protocolo de execução

Cada execução deve seguir a mesma ordem:

1. Fixar commit, tag, versão do Flutter, browser, viewport e perfil de hardware.
2. Servir `build/web` por HTTP; não usar `file://`.
3. Confirmar se o runtime está em Wasm ou JavaScript fallback.
4. Limpar cache para cenários cold; registrar warm-cache separadamente.
5. Aguardar ociosidade inicial e iniciar o trace antes da primeira interação.
6. Executar o roteiro determinístico da raid, sem movimentos improvisados.
7. Repetir cinco vezes para boot e três vezes para runtime por ambiente na primeira baseline.
8. Executar o cenário de 20 raids para estabilidade de memória.
9. Exportar trace, screenshots, logs e métricas.
10. Comparar com a baseline anterior e registrar causa, patch e decisão.

O baseline só deve ser aceito quando as variações de ambiente estiverem documentadas. O resultado não deve misturar uma execução Wasm com uma execução JavaScript no mesmo agregado estatístico.

## 9. Critérios de aceite do MVP Web/Wasm

Os seguintes gates são propostos para a primeira release candidata; valores marcados como alvo devem ser calibrados no primeiro ciclo.

| Gate | Condição |
|---|---|
| Funcionalidade | `PERF-BOOT-001`, `PERF-RAID-001` a `PERF-RAID-005` executam sem crash e sem erro não tratado |
| Responsividade | Nenhum bloqueio perceptível durante salto, wall-grab, slide, rota alternativa, grafite ou coleta |
| Frame pacing | Cenário normal atende mediana ≤ 16,7 ms e P95 ≤ 20 ms no desktop de referência; Android deve ter baseline e limite aprovado com dispositivo real |
| Picos | P99 e frames > 33,3 ms são investigados e não podem formar sequência recorrente durante o momento “uau” |
| Loading | P95 `T0→raid-ready` ≤ 5 s em W1/N1; metas de M1/M2 serão aprovadas após baseline |
| Memória | 20 raids não demonstram crescimento monotônico não explicado, crash ou degradação progressiva |
| Fallback | Navegador sem WasmGC preserva boot e jogabilidade; diferença de desempenho fica registrada |
| Regressão | Nenhuma mudança pode piorar P95 de frame time em mais de 10% ou peso transferido em mais de 15% sem Issue e decisão explícita |
| Evidência | Cada gate possui trace, commit/tag, ambiente e relatório reproduzível |

## 10. Integração ao GitHub Actions

O workflow deve manter o CI rápido e deslocar o teste pesado para jobs específicos. O job de desempenho não deve mascarar falhas funcionais.

| Job | Disparo | Conteúdo | Política |
|---|---|---|---|
| `web-wasm-build` | PR e push em `develop` | `flutter build web --wasm --release`; manifesto de tamanho | Obrigatório |
| `web-wasm-smoke` | PR e push em `develop` | Servir build, abrir navegador automatizado, verificar boot e HUD | Obrigatório quando disponível |
| `performance-baseline` | Manual, nightly ou tag RC | Cenários PERF-BOOT/RAID com traces e métricas | Informativo até baseline estabilizar |
| `performance-regression` | PR que altera `lib/`, `assets/` ou `web/` | Comparar baseline versionada | Bloqueia se exceder thresholds aprovados |
| `release-artifacts` | Tag `vX.Y.Z` | Publicar Web/Wasm e APK | Obrigatório para release |

O primeiro estágio pode executar apenas smoke e tamanho; a coleta de frames e memória deve ocorrer em runner/browser com ambiente explicitamente documentado. Não declarar que um runner genérico representa um telefone real.

## 11. Registro de regressão

Cada regressão deve abrir uma Issue com o formato `perf(web): <symptom>`, incluir o cenário, trace, ambiente, commit bom/ruim, métrica anterior, métrica atual, hipótese e plano de correção. O PR deve referenciar a Issue e registrar o antes/depois.

| Campo mínimo | Exemplo de preenchimento |
|---|---|
| Scenario ID | `PERF-RAID-003` |
| Target | Wasm, Chrome, M2 |
| Baseline | Tag aprovada anterior |
| Regression | P95 de frame time acima do gate |
| Evidence | Trace, screenshot e commit |
| Root cause | A preencher após profiling |
| Fix | A preencher após patch |
| Decision | `ACCEPT`, `RETEST` ou `BLOCK` |

## 12. Riscos e decisões pendentes

| ID | Questão | Impacto | Próxima ação |
|---|---|---|---|
| PERF-RISK-001 | Dispositivo Android da demonstração ainda não foi especificado | Critérios mobile incompletos | Fixar modelo, navegador e resolução |
| PERF-RISK-002 | Não há baseline real de tamanho e frame time | Thresholds podem ser inadequados | Executar primeira bateria controlada |
| PERF-RISK-003 | Cobertura e comportamento do fallback JavaScript ainda precisam de evidência | Compatibilidade incerta | Testar navegador sem WasmGC |
| PERF-RISK-004 | Uso futuro de áudio, anúncios e persistência pode mudar o custo Web | Regressão de bundle/memória | Adicionar cenário quando cada integração entrar |
| PERF-RISK-005 | O pacote atual tem assets grandes de referência | Boot e transferência podem degradar | Separar assets de produção e material de documentação |

## 13. Referências

[1]: https://docs.flutter.dev/perf/web-performance "Flutter — Debug performance for web apps"

[2]: https://docs.flutter.dev/perf/ui-performance "Flutter — Flutter performance profiling"

[3]: https://docs.flutter.dev/platform-integration/web/wasm "Flutter — Support for WebAssembly (Wasm)"

[4]: https://developer.chrome.com/docs/devtools/performance/reference "Chrome DevTools — Performance features reference"

[5]: https://web.dev/articles/vitals "web.dev — Web Vitals"
