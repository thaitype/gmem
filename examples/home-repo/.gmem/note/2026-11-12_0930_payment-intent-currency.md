---
status: in-progress
---

## Context
Add a `currency` field to payment intents so storefront can sell in EUR as well as USD.
Spans `payments-api` (field, validation, migration) and `storefront` (cart, webhook
handler). Release order matters: `payments-api` first, because storefront reads the new field.

## Current status
- `payments-api`: migration and validation merged. Defaults to `USD` when missing.
- `storefront`: cart sends `currency`. Pull request open, waiting on review.
- Webhook handler in storefront still assumes USD.

## Next steps
- Update the webhook handler in `storefront` to read `currency`.
- Add a test with a EUR payment intent in both repos.
- Run `release-checklist` for `payments-api`, then `storefront`.
