# Roteiro acadêmico — Graffiti Ghosts

## Situação
O repositório descreve um jogo stealth-platformer Android e Web/Wasm, MVP, pipeline CI, especificações e baseline de performance; esses artefatos não demonstram experiência de jogadores nem desempenho final.

## Problema, objeto e pergunta candidata
Problema: a escolha entre builds Web e WasmGC pode afetar carregamento, execução e compatibilidade em Flutter, mas precisa de medidas repetíveis nos ambientes-alvo.
Objeto: builds identificadas por commit do MVP e seus artefatos de performance.
Pergunta candidata: como a build Web/Wasm afeta tamanho/carregamento, métricas de execução e compatibilidade nos navegadores e dispositivos definidos?

## Objetivo e etapas
Caracterizar trade-offs técnicos sem extrapolar além dos ambientes testados.
1. Fixar versões Flutter/Dart, commit, navegador/dispositivo, rede e protocolo.
2. Pré-definir métricas, orçamento, aquecimento e controle de cache.
3. Pilotar o harness e repetir medições.
4. Comparar builds equivalentes, preservar dados brutos e hashes.
5. Separar ambientes Android, Web e Wasm; analisar variação e falhas.
6. Documentar ameaças à validade e publicar artefatos replicáveis.

## Método e revisão
Estudo experimental de desempenho de artefato mais matriz de compatibilidade. Consultar documentação oficial de Flutter Wasm e estudos revisados por pares sobre WebAssembly/Flutter, anotando versões: https://docs.flutter.dev/platform-integration/web/wasm.

Se o escopo incluir teste com jogadores, criar protocolo próprio, consentimento e revisão ética antes da coleta; performance técnica não mede usabilidade.

## Publicação e apresentação
Submeter artigo de engenharia após validar baseline; banner deve declarar versão, ambientes, métricas e limites. Não alegar resultados até executar o protocolo.
Padrões de validade e relato empírico: https://www2.sigsoft.org/EmpiricalStandards/.

## Próximo gate
Confirmar build em dispositivos-alvo e verificar se o schema de baseline corresponde a medições reais.