# Coding standards

- TypeScript with `strict` on. No `any` without a comment saying why.
- Every bug fix comes with a test that fails before the fix.
- Keep pull requests under 400 changed lines. Split larger work.
- Money is an integer in minor units (cents), never a float.
- Log with the shared logger. No `console.log` in committed code.
