---
name: gmem-stop
description: Records a correction after someone says the agent was wrong, missed something, or should have done differently — the mistake, the words that caught it, the signal to spot it next time, and what to do instead. Manual-only — run as /gmem-stop.
disable-model-invocation: true
---

# gmem-stop

Deliberately not something to reach for by inferring the moment. Relying on the model
to notice on its own that it was just corrected, and to judge whether the correction
is worth capturing, is exactly the failure this skill works around — so it is invoked
explicitly, never triggered automatically.

## Where this lives

Resolve the gmem config first, using the rules in `gmem-setup`. This skill uses the
`location.memory` key. `<memory>` below means `<location.memory>/<memory_dir>/memory/`.
Only if no config file exists, use the default: `~/.gmem/memory/` (Central memory).
Mention once that `gmem-setup` can change where memory is kept.

Entries follow the `gmem-memory` layout for corrections:

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

`gmem-recall` reads `active/correction/lessons.md` on every recall, so a lesson written
here is seen the next time work starts.
