# Pull Request Registry

This registry links implementation work to GitHub Issues and keeps the MVP traceable under Gitflow.

| Planned PR | GitHub Issue | Scope | Status |
|---|---:|---|---|
| PR-001 | #4 | Flutter MVP raid vertical slice | Merged into `develop` |
| PR-002 | #5 | CI, DevSecOps, Gitflow and release automation | Merged into `main` |
| PR-003 | #3 | Balance, accessibility and polish validation | Planned |
| PR-004 | #7 | Manual release workflow dispatch | Merged into `main` |
| PR-005 | #8 | Remove invalid SDK dependency | Merged into `main` |
| PR-006 | #9 | Add widget smoke test | Merged into `main` |
| PR-007 | #10 | Correct CustomPainter geometry | Merged into `main` |
| PR-008 | #11 | Correct score contract test | Merged into `main` |
| PR-009 | #12 | Record complete PR history | Planned |

Every future pull request must include the corresponding Issue number in its title or body and must use `Closes #N` or `Refs #N`. The registry is a planning artifact; GitHub Issues and pull requests remain the authoritative execution records.

| PR-010 | #17 | Align playable raid vertical slice with the GDD gameplay contract | In progress on `feature/17-gdd-raid-alignment` |
| PR-011 | #18 | Integrate documented visual asset families and asset manifest | Planned |
| PR-012 | #19 | Establish Clean Architecture and deterministic domain services | Included in PR-010 increment |
| PR-013 | #20 | Validate GDD acceptance scenarios, accessibility and platform evidence | Planned |

The current implementation increment uses PR-010 as the vertical-slice delivery. Issues #18–#20 remain explicit follow-up backlog items where additional production assets, platform evidence, or broader validation are required.
