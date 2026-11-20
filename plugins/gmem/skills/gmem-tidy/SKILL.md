---
name: gmem-tidy
description: Audits all of gmem memory against its layout rules — rules, precedents, proposals, learnings, and active memory — and fixes what is out of line together with the user, including facts that contradict the code and broken index files. Use when asked to "tidy memory", "clean up memory", or "audit memory", or when memory feels messy, duplicated, or out of date. Not for triaging new learnings only — use gmem-judge; not for converting an old layout — use gmem-migrate.
---

# gmem-tidy

## Where this lives

Resolve the gmem config first, using the rules in `gmem-setup`. This skill uses every
kind. `<memory>`, `<rules>`, `<precedents>`, `<learnings>` and `<proposals>` below each
mean `<location.<kind>>/<memory_dir>/<kind>/`. Only if no config file exists, use
the default: all five under `~/.gmem/<kind>/` (Central memory). Mention once
that `gmem-setup` can change where these are kept.

## 1. Ask scope

Ask which part to tidy: the authority layers, active memory, or both. The answer comes
from the user.

## 2. Scan before asking anything else

Start with `gmem-check` for the mechanical findings (layout, names, indexes, format),
then read every file in scope in full. Check each one against the rules below, and **check facts against the real world**
(the script, the code in the repository, the file a read-point names), not just against other memory. A memory line
that contradicts the code is the most expensive kind, because it reads as verified.

Report the findings grouped by rule, and count the decisions they need. Then recommend how to decide them: one
question at a time for a handful of related decisions, or a map of independent decisions for many (use `/grilling`
or `/wayfinder` if installed; `gmem-setup` checks and installs them). The user picks.

## Authority-layer rules

**`rules/`** and **`precedents/`**: each is a folder of topic files plus an `index.md` (one row per file: file → when
to read it).
- **Index complete**: every file in the folder has a row, and every row points at a file that exists. Missing or
  broken rows are the one change tidy may make inside these folders — and only after the user confirms it.
- **Rules**: human-edit only. Flag a rule that contradicts another rule or no longer matches practice; never rewrite
  its content.
- **Precedents**: compliant when it does not contradict `rules/`, still reflects current practice (no later human
  decision has superseded it), and is not a near-duplicate of another precedent on the same topic. Flag any that fail
  one of these; never rewrite its content.

**`learnings/`**: resolve via `gmem-judge`. Revise cheap fixes in place, or raise a proposal when a learning conflicts
with `rules/`/`precedents/`, generalizes badly, or is unclear.

**`proposals/`**: live when the situation it names still exists and no rule/precedent has since answered it. Flag as
stale when the learning behind it was later revised or removed, the question was already settled elsewhere, or enough
time has passed that the context has clearly moved on.

## Active-memory rules (`<memory>/active/`)

`active/` holds everything consulted as current understanding, in two categories, so one place answers every lookup:

```
active/
├── index.md        one table per category: file → when to read it
├── correction/     what I got wrong, and what to do instead
└── reference/      how things work: mechanics, recipes, standing facts and rules
```

**`correction/`**: compliant when an entry states what was done wrong, the exact words that caught it, the signal
to recognize the same situation next time, and what to do instead, each as a short standalone actionable line.
Short lessons pulled out of reference files (one line each: what I did wrong → what to do instead) go together in
`correction/lessons.md`, tagged with the reference file they came from.
Non-compliant when it reads like an incident report (dates, a sequence of events, background) instead of a rule you
can extract in one sentence, or when it carries detail that wouldn't change what anyone does next time.

**`reference/`**: compliant when the file is:
- **true now**: no line contradicts the code, script or state it describes; read-points, version tables and
  "state of X after Y" snapshots are either still current or removed (prefer a check command over a recorded value);
  every path it names exists.
- **consistent**: no other file in `active/` gives a different answer to the same question. When two disagree, pick
  one answer (the user decides), keep it in one file and point to it from the others.
- **not duplicated**: one topic, one home. A rule the user uses often (e.g. which account to push with) gets its own
  file rather than living as a section of several.
- **not a diary**: dead hypotheses, "measured on date X then Y" narratives and review history go. The lesson inside
  them, if there is one, moves to `correction/lessons.md`.
Recipes that still work stay as written: tidy what is wrong, don't reword what is right.

No topic file sits directly under `active/` — move it into `correction/` or `reference/`.

**Out of scope:** the ledger (`<memory>/YYYY-MM-DD_HHMM_*.md`), notes, retros. They are dated records; never rewrite
them to fix links.

## 3. Decide, then apply

With scope and approach chosen, work through the decisions with the user, carrying the rules above as context. Act
only after the user confirms the shared understanding. When applying:

0. Make sure every folder you will touch can be recovered. If it is in a git repo, commit any pending changes first;
   that commit is the pre-tidy point. If it is not in git (user-level `~/.gmem/...` folders, which is where every kind lives when there is no config), copy it
   aside first, e.g. `cp -R <folder> <folder>.pre-tidy-YYYY-MM-DD_HHMM`, and tell the user where the copy is.
1. `git mv` files you are moving (when source and target are in the same git repo), so history follows them; then edit.
2. Write one ledger entry `<memory>/YYYY-MM-DD_HHMM_memory-tidy.md`: what moved where, what was removed and why, and
   where to recover anything from: the pre-tidy commit (`git show <sha>:<path>`) for folders in git, or the
   pre-tidy copy's path for folders that are not. Do not copy removed content into it.
3. Rewrite `active/index.md`: both categories, every file, a "when to read" column. Fix the `rules/index.md` and
   `precedents/index.md` rows the user confirmed.
4. Check that every link inside `active/`, `rules/` and `precedents/` resolves, then commit each folder that is in a git repo.
