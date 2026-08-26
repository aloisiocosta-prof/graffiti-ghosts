# Cloudflare Worker — Flutter Web WasmGC

## Configuration applied

The Worker `graffiti-ghosts` is configured with root directory `/` and production branch `main`.

The build command is `bash tool/cloudflare/build.sh`.

The deploy command is `npx wrangler deploy`.

The version command is `npx wrangler versions upload` for non-production version uploads.

The build pipeline is expected to obtain Dart and Flutter packages through `flutter pub get` and to compile the web application through the repository build script with WasmGC enabled; npm is tooling-only for Wrangler and is not an application runtime dependency.

The build watch include paths are:

- `lib/**`
- `web/**`
- `tool/**`
- `pubspec.yaml`
- `pubspec.lock`
- `wrangler.jsonc`
- `worker/**`

The previous global `*` include path was removed so unrelated repository changes do not trigger a Flutter/Wasm build.

The existing exclude paths remain `node_modules/**, .git/`.

The configuration was saved in the Cloudflare dashboard without pending unsaved changes.

## Technical intent

The Worker serves the generated Flutter Web/WasmGC output from `build/web` using the repository Wrangler configuration and Worker entrypoint. COOP/COEP headers are applied by the Worker response adapter to support cross-origin isolation where the browser and deployment context permit it.

## Status labels

- [CLIENT DECISION] Deployment target: Cloudflare Worker.
- [CLIENT CONSTRAINT] Application dependencies: Dart native libraries plus Flutter SDK native packages.
- [CLIENT CONSTRAINT] Web compilation target: WasmGC.
- [AGENT RECOMMENDATION] Keep npm out of the application dependency graph; use Wrangler only as deployment tooling.
- [VALIDATION REQUIRED] Trigger a new build from a new commit or the Cloudflare dashboard and verify that the build snapshot shows `bash tool/cloudflare/build.sh` rather than the historical `Build command: None` snapshot.

## References

- Cloudflare Workers Builds configuration: https://developers.cloudflare.com/workers/ci-cd/builds/configuration/
- Cloudflare Workers Static Assets: https://developers.cloudflare.com/workers/static-assets/
- Cross-origin isolation and COOP/COEP: https://web.dev/articles/coop-coep
- Flutter Web Wasm: https://docs.flutter.dev/platform-integration/web/wasm

Written after applying the Cloudflare dashboard settings for the Graffiti Ghosts project.
