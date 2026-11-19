---
name: typmem-stop
description: Manual-only capture for a correction. Invoke explicitly (never proactively inferred by the model) when someone tells you that you were wrong, missed something, or should have done differently. Writes a correction entry in active memory naming the mistake, the exact words that caught it, the signal to recognize it next time, and what to do instead.
disable-model-invocation: true
---

# typmem-stop

Deliberately not something to reach for by inferring the moment. Relying on the model
to notice on its own that it was just corrected, and to judge whether the correction
is worth capturing, is exactly the failure this skill works around — so it is invoked
explicitly, never triggered automatically.

## Where this lives

Resolve the typmem config first, using the rules in `typmem-setup`. This skill uses the
`location.memory` key. `<memory>` below means `<location.memory>/<memory_dir>/memory/`;
with the defaults that is `<project>/.typmem/memory/`. If there is no config, use the
defaults and carry on; mention once that `typmem-setup` can change where memory is kept.

Entries follow the `typmem-memory` layout for corrections:

- **One-line lesson** (what I did wrong → what to do instead) → append to
  `<memory>/active/correction/lessons.md`.
- **Anything longer** → write or update `<memory>/active/correction/<topic>.md`. If the
  file is new, add its row to `<memory>/active/index.md` (file → when to read it) in the
  same change. If a file on the same mistake already exists, update it instead of
  starting a second one.

Create folders only when writing into them.

## When invoked

Write the entry with:
- what was actually done wrong, stated plainly, not softened into a general fact
- the exact words that flagged it, quoted
- the concrete signal that should make future-you recognize the same situation
  before repeating it
- what to do instead, stated as an action

A one-line entry in `lessons.md` still carries all four, compressed.

No filtering by triviality. Write it every time this is invoked, immediately, before
continuing whatever else was in progress.

`typmem-recall` reads `active/correction/lessons.md` on every recall, so a lesson written
here is seen the next time work starts.
