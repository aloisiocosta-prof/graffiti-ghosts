# Telemetry and KPI Specification — Graffiti Ghosts

## Status

`[VALIDATION REQUIRED]` The event model is approved as a schema-first artifact, but the analytics provider, consent policy, retention period, and production activation are not approved.[DR-1]

## Privacy boundary

Events must avoid personal data and use an anonymous installation or session identifier only when a documented privacy decision permits it.[DR-1]

No event may contain raw account credentials, payment details, free-form personal text, or platform secrets.[DR-1]

## Event schema

| ID | Event | Trigger | Required parameters | KPI relationship |
|---|---|---|---|---|
| E100 | `app_open` | Application reaches initialized state | `app_version`, `platform` | Starts session quality measurement |
| E200 | `session_start` | New player session begins | `session_id` | Engagement and retention |
| E210 | `raid_start` | Player starts a raid | `raid_id`, `difficulty` | Funnel entry |
| E220 | `raid_complete` | Player completes escape and score resolution | `raid_id`, `duration_ms`, `score` | Completion and progression |
| E230 | `raid_fail` | Player fails a raid | `raid_id`, `duration_ms`, `failure_reason` | Difficulty and recovery |
| E240 | `ghost_comparison` | Ghost replay comparison is shown | `raid_id`, `comparison_result` | Mastery feedback |
| E300 | `treasure_earned` | Reward is committed | `raid_id`, `amount`, `source` | Economy faucet |
| E310 | `treasure_spent` | Upgrade cost is committed | `upgrade_id`, `amount` | Economy sink |
| E320 | `hideout_upgrade` | Hideout upgrade completes | `upgrade_id`, `upgrade_level` | Progression |
| E900 | `app_background` | App enters background | `session_id` | Lifecycle resilience |
| E910 | `app_resume` | App returns to foreground | `session_id` | Lifecycle resilience |
| E920 | `recovery` | Interrupted state is recovered | `recovery_type` | Reliability |
| E410 | `paywall_view` | Approved monetization UI is shown | `offer_id` | Conditional monetization funnel |
| E420 | `purchase_start` | Player confirms purchase intent | `product_id` | Conditional conversion |
| E430 | `purchase_success` | Authoritative purchase success is received | `product_id`, `currency` | Conditional revenue |
| E440 | `purchase_failure` | Purchase fails or is cancelled | `product_id`, `error_category` | Conditional quality |
| E450 | `restore_start` | Player taps restore | None | Conditional recovery |
| E460 | `restore_success` | Entitlements are restored | `entitlement_ids` | Conditional retention |

## Event envelope

```json
{
  "event_id": "E210",
  "event_name": "raid_start",
  "occurred_at": "2026-08-26T00:00:00Z",
  "session_id": "anonymous-session-id",
  "app_version": "0.1.0+1",
  "platform": "android|web-js|web-wasmgc",
  "parameters": {}
}
```

## KPI tree

The initial KPI tree is a hypothesis, not a success commitment: quality includes crash-free sessions and build success; engagement includes session starts and raid completions; mastery includes ghost comparison outcomes; progression includes upgrade completion; monetization remains disabled until approved.[DR-1]

## Acceptance criteria

Every instrumented event references an event ID, trigger, parameter contract, privacy review, and test.[DR-1]

Telemetry failures must not block the core raid loop or corrupt score, treasure, or progression.[GG-1]

## References

[DR-1]: ../references/deep-research-report.md "User-provided deep research report"
[GG-1]: ../../.agents/skills/graffiti-ghosts-agentic-game-development/SKILL.md "Graffiti Ghosts agentic game-development skill"
