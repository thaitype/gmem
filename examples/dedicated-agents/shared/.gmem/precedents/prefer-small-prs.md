# Prefer small pull requests

Decided by a human on 2026-09-03, after a 1,800-line payments change was reviewed too
quickly and released a rounding bug.

Keep each pull request to one reviewable change, under about 400 lines. If a change is
larger, split it in a way that each part passes tests on its own. A larger pull request
is fine when the work cannot be split. Say why in the description.
