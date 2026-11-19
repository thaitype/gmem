---
status: in-progress
---

## Context
Owned by the builder agent. Assigned by the team leader. Assignment and acceptance
check: `team-leader/.gmem/note/2026-11-12_0930_eur-checkout.md`.

## Current status
- `payments-api`: `currency` column added with default `USD`, validation for `USD` and
  `EUR`, migration tested on a copy of the staging schema.
- Unit and integration tests pass. The e2e suite is not set up for this repo, so it was
  not run.
- Pull request open and under 400 lines.

## Next steps
- Add a test with a EUR payment intent through the webhook path.
- After review, start the `storefront` part: cart and webhook handler.
- Hand back to the team leader with the list of suites that ran.
