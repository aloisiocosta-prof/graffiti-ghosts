# Graffiti Ghosts — Game Design Document & Visual Guide

## Cover
Graffiti Ghosts
The perfect heist is a route you master.
Game Design Document + Visual Guide

## Slide 1
### Um platformer de furtividade em sessões curtas
- Graffiti Ghosts é um platformer single-player de fantasia urbana para Android e Web/Wasm.
- Cada raid foi desenhada para durar menos de três minutos.
- O jogador controla um ladrão ágil que está se tornando um infiltrador.
- O diferencial combina movimento acrobático, rotas alternativas, grafite mágico e fantasmas de tentativas reais.

## Slide 2
### A fantasia: dominar a cidade sem ser visto
- O jogador entra em fortalezas verticais, lê o espaço e escolhe a rota mais inteligente.
- O domínio não vem apenas de correr mais rápido; vem de observar, improvisar e escapar da perseguição.
- A sensação desejada é transformar uma tentativa arriscada em um roubo perfeito.
- A progressão reforça essa fantasia com novas habilidades, reputação, tesouro e uma base que evolui.

## Slide 3
### O core loop transforma cada raid em uma decisão
- Selecionar uma fortaleza e avaliar recompensa e fantasma.
- Infiltrar-se usando salto/acrobacia, wall-grab e slide.
- Ler guardas, armadilhas, grafites e rotas alternativas.
- Roubar, escapar, comparar o resultado e investir as recompensas na próxima tentativa.

## Slide 4
### O grafite mágico é o diferencial jogável
- A habilidade limitada de grafite é ativada automaticamente quando usada pelo jogador.
- Grafites revelam rotas secretas, criam plataformas/atalhos temporários e alteram armadilhas.
- A mesma linguagem visual guia exploração, resolução de obstáculos e decisões durante a perseguição.
- A cor comunica função: cyan para rota/movimento, magenta para plataformas e payoff, lime para armadilhas/progressão, violeta para fantasmas.

## Slide 5
### A perseguição preserva tensão sem punir com falha instantânea
- Detecção inicia uma perseguição, não encerra automaticamente a raid.
- O jogador precisa reconhecer e escolher uma rota alternativa.
- Sem segunda chance, a captura perde o tesouro carregado e retorna ao início.
- Com segunda chance, o jogador reinicia em um checkpoint, mas aceita penalidade de pontuação, tempo e parte do tesouro.

## Slide 6
### Fantasmas tornam a maestria visível
- Cada fantasma representa uma tentativa real registrada.
- A silhueta violeta corre junto do jogador e torna a comparação espacial imediata.
- A pontuação inicial combina 40% tempo, 40% tesouro e 20% falhas.
- O objetivo é melhorar a própria rota, superar o fantasma e transformar conhecimento em domínio.

## Slide 7
### A progressão conecta o roubo à evolução da base
- Tesouro sustenta o ciclo econômico da raid.
- Reputação representa reconhecimento e abre progressão de longo prazo.
- A base evolui de forma visual e funcional.
- O MVP prioriza maior armazenamento de tesouro, acesso a novas áreas e personalização visual; novas habilidades entram como eixo de progressão do ladrão.

## Slide 8
### Monetização opcional, separada da competição
- Cosméticos expressam identidade sem alterar o desempenho contra fantasmas.
- Anúncios opcionais podem oferecer uma segunda chance após captura ou bônus de tesouro.
- O bônus de anúncio altera apenas a recompensa econômica; não aumenta a pontuação competitiva.
- A segunda chance exibe suas penalidades antes da decisão, preservando clareza e confiança.

## Slide 9
### Uma identidade visual feita para leitura instantânea
- Fantasia urbana vibrante, com cidade vertical, sombras profundas e grafites mágicos.
- Silhuetas fortes para distinguir ladrão, fantasma, guardas, rotas e perigos em uma tela mobile.
- HUD com grandes áreas de toque, painéis translúcidos e poucos focos simultâneos.
- A direção visual deve ser cinética, legível, misteriosa e memorável sem excesso de ruído.

## Slide 10
### O vertical slice prova o jogo e a arquitetura sustenta o MVP
- Entrada na fortaleza, tutorial acrobático, grafite mágico, atalho, perseguição e roubo perfeito.
- Ghost silhouette, score 40/40/20, recompensas e mudança visível na base.
- Clean Architecture + Ports & Adapters mantêm domínio e aplicação independentes de Android, Web e Wasm.
- Dart e Flutter nativos, SOLID, Clean Code, Object Calisthenics, TDD e Spec-Driven Development orientam a implementação.

## Slide 11
### Graffiti Ghosts: uma experiência pequena, coerente e demonstrável
- Furtividade acrobática com uma assinatura visual clara.
- Loop curto que entrega decisão, risco, recompensa e replay.
- Competição assíncrona que reforça maestria sem multiplayer em tempo real.
- Monetização que apoia o jogador sem vender poder competitivo.
- Próximo marco: validar o vertical slice em Android e Web/Wasm com testes de domínio, aceitação e performance.
