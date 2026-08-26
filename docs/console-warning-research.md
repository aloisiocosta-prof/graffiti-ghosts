# Console Warning Research — 2026-08-26

## Flutter Intl warning

Flutter issue #189938 reports the same `Intl.v8BreakIterator is deprecated` warning on Chrome 151. The Flutter Web team explains that `Intl.Segmenter` does not implement UAX #14 line breaking, which is why `Intl.v8BreakIterator` is still used, and that a reliable direct migration is not currently available. This is an upstream Flutter engine issue rather than an application call site.

Source: https://github.com/flutter/flutter/issues/189938

## Cross-origin isolation

The web.dev guidance states that WebAssembly threads and `SharedArrayBuffer` require a cross-origin-isolated context. The top-level document must send `Cross-Origin-Opener-Policy: same-origin` and `Cross-Origin-Embedder-Policy: require-corp`; all cross-origin subresources must also opt in through CORS or CORP as applicable. The page can verify the result through `self.crossOriginIsolated`.

Source: https://web.dev/articles/coop-coep

## Project implication

GitHub Pages currently returns the game without COOP/COEP headers. The correct fix is to deploy the Wasm artifact to a header-capable host, add the headers at the edge, and verify every resource before leaving `forceSingleThreadedSkwasm` enabled. The Intl warning should be tracked until Flutter replaces or polyfills its line-break implementation.
