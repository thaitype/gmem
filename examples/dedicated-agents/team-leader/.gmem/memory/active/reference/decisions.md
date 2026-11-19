# Decisions

- 2026-10-20: EUR launch uses a `currency` field on payment intents, not a separate
  endpoint. Reason: one code path, simpler webhooks. Decided by the user.
- 2026-10-27: No new payment provider this quarter. Reason: the EUR launch is already
  the risky change.
- 2026-11-05: The builder agent owns tests for its changes. The team leader reviews
  but does not write them.
