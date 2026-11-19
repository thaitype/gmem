# Repo map

- `storefront` (Next.js): pages, cart UI, checkout form. Talks to `payments-api` over
  HTTPS with a server-side token. It never holds card data.
- `payments-api` (Node, Postgres): payment intents, captures, refunds, webhooks to
  storefront. It owns the order record.
- `infra` (Terraform): both services, the database and the queue. Changes need a plan
  output in the pull request.
- Local dev: run `payments-api` first on port 4000, then `storefront` on port 3000.
  Storefront reads `PAYMENTS_API_URL` from `.env.local`.
