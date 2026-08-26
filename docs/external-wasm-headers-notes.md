# External Web/Wasm Notes

The Flutter WebAssembly documentation confirms that Wasm builds use `flutter build web --wasm`. Flutter's web initialization documentation describes the `suppressMultithreadingWarning` configuration option and notes that the default allows multi-threaded rendering when supported. The current browser warning states that Skwasm multi-threading requires cross-origin isolation using `Cross-Origin-Opener-Policy: same-origin` and `Cross-Origin-Embedder-Policy: require-corp`.

The current deployment is GitHub Pages (`.github/workflows/pages.yml`). GitHub Pages is a static deployment path in this repository and does not provide a project-level response-header configuration in the existing workflow. Therefore, enabling COOP/COEP cannot be claimed from the current Pages workflow alone. The safe immediate decision is to suppress the warning for the Pages build and document that Skwasm runs single-threaded there. Enabling multi-threading requires a hosting layer capable of sending both response headers and must be a separately validated deployment decision.

## Sources

- https://docs.flutter.dev/platform-integration/web/wasm — Flutter WebAssembly support.
- https://docs.flutter.dev/platform-integration/web/initialization — Flutter web initialization and configuration.
- https://web.dev/articles/coop-coep — COOP/COEP and cross-origin isolation.
