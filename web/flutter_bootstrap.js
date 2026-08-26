{{flutter_js}}
{{flutter_build_config}}
_flutter.loader.load({
  config: {
    // GitHub Pages cannot provide the COOP/COEP response headers required by
    // SharedArrayBuffer. Keep the current Pages deployment deterministic.
    forceSingleThreadedSkwasm: true,
    suppressMultithreadingWarning: true,
  },
});
