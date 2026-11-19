# Glossary

| Term | Meaning |
|---|---|
| Cart | A shopper's unpaid basket in `storefront`. Lives for 7 days. |
| Order | A cart that has been paid. Created by `payments-api`. |
| Payment intent | The `payments-api` record of one attempt to charge a shopper. |
| Capture | Moving money for an authorised payment intent. |
| Idempotency key | Client-sent key that makes a repeated request safe. |
