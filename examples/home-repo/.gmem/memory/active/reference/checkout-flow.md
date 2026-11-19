# Checkout flow

1. Storefront sends the cart to `POST /payment-intents` with an idempotency key.
2. `payments-api` returns a payment intent with a client secret.
3. The shopper confirms. `payments-api` sends the `payment_intent.succeeded` webhook to
   `storefront` at `/api/webhooks/payments`.
4. Storefront marks the cart as an order only on that webhook, never on the browser
   redirect.

Cart totals are computed in `payments-api`. Storefront only displays them.
