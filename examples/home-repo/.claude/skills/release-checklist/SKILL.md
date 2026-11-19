---
name: release-checklist
description: Walks through the Acme release steps for storefront or payments-api. Use when the user asks to cut, publish or check a release.
---

# release-checklist

Shared by every repository in this home repo. Work through the list in order and report
each item as done, failed or skipped.

1. Confirm `main` is green in CI for the repository being released.
2. Read the open notes in `.gmem/note/` and name any that touch this release.
3. List the merged pull requests since the last tag. Flag any without a test.
4. For `payments-api`, confirm database migrations are backwards compatible.
5. Draft the release notes from the pull request titles.
6. Tag the release only after the user says go.
