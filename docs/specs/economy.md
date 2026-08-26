# Economy Specification — Graffiti Ghosts

## Purpose

This specification separates game economy from monetization and defines the resource flows that support raid mastery without replacing the core loop.[DR-1]

## Current model

| Element | Current status | Rule |
|---|---|---|
| Treasure | CONFIRMED by existing gameplay | Earned from successful raid resolution and contributes to progression/scoring according to the existing GDD. |
| Reputation | CONFIRMED by existing project context | Progression signal associated with raid performance and hideout growth. |
| Hideout upgrades | CONFIRMED by existing project context | Combine visual ownership with functional progression. |
| Premium currency | VALIDATION REQUIRED | No premium currency may be added from the research examples alone. |
| Ads | VALIDATION REQUIRED | No ad faucet or forced ad flow is approved. |
| Time gates | VALIDATION REQUIRED | No time gate may block the core raid loop without a client decision. |

## Economy contract

Every resource must define sources, sinks, conversion, storage limits, scarcity, pacing, failure behavior, and telemetry before implementation.[DR-1]

The core raid must remain playable and rewarding without a purchase, ad view, or premium entitlement.[DR-1]

Reward resolution must be idempotent by raid attempt ID so retries and lifecycle callbacks cannot duplicate rewards.[DR-1]

## Balance validation

The economy designer must simulate at least low-skill, median-skill, and high-skill raid outcomes before locking costs or upgrade pacing.[DR-1]

The simulation must identify bottlenecks, runaway accumulation, inflation, deflation, and whether the player can understand the relationship between action, reward, and upgrade.[DR-1]

## Open questions

The exact currencies, quantities, upgrade costs, reward curve, storage capacity, and scarcity model are `[VALIDATION REQUIRED]` because the attached report provides only generic examples rather than Graffiti Ghosts values.[DR-1]

## References

[DR-1]: ../references/deep-research-report.md "User-provided deep research report"
