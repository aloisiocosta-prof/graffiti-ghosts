# Monetization and RevenueCat Specification — Graffiti Ghosts

## Status

`[VALIDATION REQUIRED]` Monetization is not approved for the current MVP; the examples in the research report are templates, not product decisions.[DR-1]

## Design rule

Game economy and monetization are separate concerns: the economy describes how resources circulate, while monetization describes how the product captures value.[DR-1]

If monetization is approved, every offer must follow `Product → Entitlement → Game Feature`, and the domain must depend only on a `MonetizationPort` rather than RevenueCat types.[DR-1]

```text
Domain
  ↓
MonetizationPort
  ↓
RevenueCatAdapter
  ↓
RevenueCat SDK / platform store
```

## Required approval questions

| Question | Status |
|---|---|
| Is monetization part of MVP? | VALIDATION REQUIRED |
| Which platforms may purchase? | VALIDATION REQUIRED |
| Are cosmetics, optional ads, consumables, subscriptions, or non-consumables allowed? | VALIDATION REQUIRED |
| What are product IDs, prices, currencies, and regional rules? | VALIDATION REQUIRED |
| Which entitlements gate which features? | VALIDATION REQUIRED |
| Is online access required for entitlement verification? | VALIDATION REQUIRED |
| What consent, refund, restore, and support policy applies? | VALIDATION REQUIRED |

## Invariants if approved

The application must not unlock premium content directly from a product ID; it must verify the authoritative entitlement state.[DR-1]

`restorePurchases` must be user-triggered, while any automatic synchronization must use the explicitly approved service behavior and must not duplicate grants.[DR-1]

Purchase success, failure, cancellation, restore, and entitlement changes must have deterministic state transitions and idempotent handling.[DR-1]

Web/WasmGC must not assume Android store billing support; platform capability must be resolved before exposing purchase UI.[GG-1]

## Acceptance criteria before implementation

An approved product catalog maps every Product to an Entitlement and every Entitlement to a game feature.[DR-1]

A state-machine test covers purchase success, cancellation, store failure, network failure, restore, repeated callbacks, and reinstall/device recovery.[DR-1]

A platform matrix documents Android, Web-JS, and Web-WasmGC behavior before any adapter is added.[GG-1]

## References

[DR-1]: ../references/deep-research-report.md "User-provided deep research report"
[GG-1]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic game-development skill"
