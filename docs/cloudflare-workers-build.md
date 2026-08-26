# Cloudflare Workers Build

O projeto usa o Cloudflare Workers Static Assets para servir o artefato Flutter Web/Wasm a partir de `build/web`.[^1]

O arquivo `wrangler.jsonc` define o Worker `graffiti-ghosts`, o entrypoint `worker/index.js` e o diretório de assets estáticos.[^1] [^2]

## Configuração do Workers Builds

No painel do Worker, use os seguintes valores:

| Campo | Valor |
|---|---|
| Root directory | `/` |
| Build command | `bash tool/cloudflare/build.sh` |
| Deploy command | `npx wrangler deploy` |
| Non-production branch deploy command | `npx wrangler versions upload` |
| Production branch | `main` |

O Workers Builds executa primeiro o Build command, quando configurado, e depois o Deploy command.[^3]

O comando `npx wrangler deploy` deve ser usado na branch de produção para promover o Worker, enquanto `npx wrangler versions upload` cria uma versão de preview sem promovê-la automaticamente.[^3]

A configuração de Static Assets precisa apontar para um diretório que exista no momento do upload; neste projeto, o script de build cria `build/web` antes da execução do Wrangler.[^1] [^2]

## Isolamento cross-origin

O entrypoint `worker/index.js` aplica `Cross-Origin-Opener-Policy`, `Cross-Origin-Embedder-Policy` e `Cross-Origin-Resource-Policy` às respostas do Flutter para habilitar a validação de isolamento no ambiente de execução.[^4]

O uso de WebAssembly threads e `SharedArrayBuffer` deve ser validado no domínio publicado, pois o navegador exige um contexto cross-origin isolated para esses recursos.[^4]

[^1]: [Cloudflare Workers — Static Assets](https://developers.cloudflare.com/workers/static-assets/)
[^2]: [Cloudflare Workers — Configuration and Bindings](https://developers.cloudflare.com/workers/static-assets/binding/)
[^3]: [Cloudflare Workers Builds — Configuration](https://developers.cloudflare.com/workers/ci-cd/builds/configuration/)
[^4]: [web.dev — Cross-Origin Isolation](https://web.dev/articles/coop-coep)

