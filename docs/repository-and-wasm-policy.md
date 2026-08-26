# Repository and Web/Wasm Policy

## Main branch protection

The repository default branch is `main`. It is protected through the GitHub branch protection API. Direct changes require a pull request, one approving review is required, stale approvals are dismissed after new pushes, conversations must be resolved, administrators are included in enforcement, and force pushing or deleting `main` is disabled.

The required checks are the CI jobs named `Flutter Analyze and TDD`, `Conventional Commits`, `Secret Scan`, `Build Web Wasm`, `Build Android APK`, and `Web/Wasm Performance and Bundle Audit`. The required status must be up to date before merge. Gitflow integration continues through `develop`; release promotion to `main` is a separate reviewed operation.

## GitHub Pages and Skwasm

The current deployment uses GitHub Pages. Its workflow builds Flutter with `--wasm --release` and deploys a static Pages artifact. The repository does not configure response headers for the Pages site, so it cannot claim cross-origin isolation for `SharedArrayBuffer` or WebAssembly threads.

The versioned `web/flutter_bootstrap.js` therefore calls the official Flutter loader with `forceSingleThreadedSkwasm: true` and `suppressMultithreadingWarning: true`. The first option makes the current Pages behavior explicit; the second suppresses the engine diagnostic after the behavior has been intentionally selected. It does not claim multithreaded rendering or equivalent performance.

To enable multithreaded Skwasm in a future hosting environment, the deployment must send:

```text
Cross-Origin-Opener-Policy: same-origin
Cross-Origin-Embedder-Policy: require-corp
```

That future change must be validated against every script, image, font, worker, iframe and other subresource because COEP can block resources without an appropriate CORS or CORP opt-in. It also requires real-device performance measurements before becoming the default deployment.

## Tracking

- [Issue #22](https://github.com/aloisiocosta-prof/graffiti-ghosts/issues/22): protect `main` and require CI gates.
- [Issue #23](https://github.com/aloisiocosta-prof/graffiti-ghosts/issues/23): evaluate cross-origin-isolated hosting for multithreaded Skwasm.
- [Issue #24](https://github.com/aloisiocosta-prof/graffiti-ghosts/issues/24): classify upstream Flutter/browser console warnings.
- [Flutter web initialization](https://docs.flutter.dev/platform-integration/web/initialization).
- [Flutter Wasm support](https://docs.flutter.dev/platform-integration/web/wasm).
- [COOP/COEP guidance](https://web.dev/articles/coop-coep).
