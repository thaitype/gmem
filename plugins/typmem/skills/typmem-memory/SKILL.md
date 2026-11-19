---
name: typmem-memory
description: Manage this crew's own durable facts — things worth remembering across many future sessions/projects, but too crew-specific to be worth promoting to the fleet-wide typmem-learn. Use when the user wants to record, update, or review a lasting fact about how this crew's own environment/stack/tools work, or asks to "remember this for this crew", "add to crew memory", or "typmem-memory".
---

# typmem-memory

This is a loose set of conventions for managing durable, crew-local knowledge — not a
strict procedure. Use judgment throughout; the goal is to keep useful facts easy to find
later, not to follow a rigid checklist.

## Where this lives

Resolve the typmem config first, using the rules in `typmem-setup`. This skill uses the
`location.memory` key. Its folder is:

```
<location.memory>/<memory_dir>/memory/      # called <memory> below
```

With the defaults that is `<project>/.typmem/memory/`. If there is no config, use the
defaults and carry on; mention once that `typmem-setup` can change where memory is kept.
Create folders only when something is first written into them.

## What belongs here vs elsewhere

- **Generalizes beyond this one crew?** → that's `typmem-learn`'s job (fleet-wide),
  not this one.
- **Just the current status of one project/topic, no lasting "fact" to it?** → that's
  `typmem-note`'s job.
- **A durable fact specific to this crew** (a quirk of its own sandbox, its own stack
  choices, a gotcha only this crew would hit again) that doesn't generalize enough to
  be worth promoting fleet-wide → that's what lives here.

## Two locations, two different jobs

- **`<memory>/`** (the ledger) — timestamped entries, one per thing learned, never
  edited once written. Filename: `YYYY-MM-DD_HHMM_<topic>.md`. Think of it as an
  append-only trail of "at this point, I learned/believed X."
- **`<memory>/active/`** — freely-editable files, one per topic, holding the
  *current* understanding. Filename: `<topic>.md` (no timestamp — it changes over time
  in place). This is what you'd actually consult before doing related work. It has
  two category folders and an index:
  - `active/correction/<topic>.md` — something I got wrong: what I did, the exact words
    that caught it, the signal to recognize it next time, what to do instead. A
    one-line lesson goes into `active/correction/lessons.md` instead of a new file.
  - `active/reference/<topic>.md` — how something works: mechanics, recipes, standing
    facts and rules. Before adding, check whether a file already answers the same
    question; extend it rather than starting a second home for the topic.
  - `active/index.md` — one row per file (file → when to read it). Add or update the
    row in the same change as the file. Read the index first when looking something up.

The two aren't tied 1:1 — editing `active/` doesn't require a matching ledger entry
every time. Write a ledger entry when it feels worth having a dated record of the change;
skip it when it doesn't. Best-effort, not mandatory.

When something in `active/` stops being true, just remove or rewrite that part — there's
no archival/inactive-flag mechanism. If you want to keep a trace of what used to be
believed, that's what the ledger is for (write a dated entry there before changing
`active/`, if it seems worth it).

## Rules

- NEVER treat this as a place for fleet-wide facts — those go through `typmem-learn`.
- NEVER treat this as a project status board — that's `typmem-note`.
- NEVER force a ledger entry for every `active/` change — best-effort only.
- NEVER build an archive/inactive-flag mechanism for retired facts — just edit or remove
  from `active/`.
- No fixed frontmatter is required — write whatever's useful.
- NEVER write a topic file directly under `active/` — it goes in `correction/` or
  `reference/`, with its row in `index.md`. (`typmem-tidy` checks the two categories.)
