# Contributing to Graffiti Ghosts

## Development flow

The repository follows Gitflow. `main` contains releasable code, while `develop` integrates completed work. New work starts from `develop` in a short-lived branch named `feature/<issue>-<slug>`, `fix/<issue>-<slug>`, `test/<issue>-<slug>`, `docs/<issue>-<slug>`, or `chore/<issue>-<slug>`.

A pull request is required for every merge into `develop` or `main`. Direct pushes to protected branches should be disabled in repository settings after the initial bootstrap. Every pull request must reference an Issue with `Closes #N` or `Refs #N`; the Issue is the source of intent and acceptance criteria, while the pull request records implementation and evidence.

## Commit format

Use Conventional Commits:

```text
<type>(optional-scope): <imperative summary>
```

Allowed types are `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `build`, `ci`, `perf`, `style`, and `revert`. Breaking changes use `!` after the type/scope and require an explanation in the body.

## Definition of done

A change is ready when its specification and acceptance criteria are explicit, domain behavior is covered by tests, `dart format` is clean, `flutter analyze` is clean, and `flutter test` passes. Platform-specific behavior must be isolated behind an adapter and assessed for Android, Web, and Wasm.

## Releases

Releases are cut from `main` using semantic version tags such as `v0.1.0`, `v0.2.0`, or `v1.0.0`. The release workflow runs tests, builds the Android APK and Web/Wasm bundle, and attaches both artifacts to the GitHub Release generated from the tag.
