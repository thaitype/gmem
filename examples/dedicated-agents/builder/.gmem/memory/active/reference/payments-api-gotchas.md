# payments-api gotchas

- Run `npm run db:reset` before the integration tests. They fail with a confusing
  foreign key error on a dirty database.
- Amounts are integers in minor units. A test that passes `10.5` will pass and be wrong.
- Migrations must be backwards compatible: add a column with a default first, switch
  the code, drop the old column in a later release.
- The webhook signature check uses the raw body. Parsing JSON first breaks it.
