# storefront gotchas

- Server components cannot read `localStorage`. Cart state in the browser comes from a
  cookie.
- `npm run test` skips the end-to-end suite. Run `npm run test:e2e` before a pull
  request that touches checkout.
- `PAYMENTS_API_URL` must be set in `.env.local`, or checkout silently falls back to a
  mock server.
