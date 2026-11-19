---
name: gmem-check
description: Checks gmem memory without changing it — whether files follow gmem's rules (layout, file names, complete indexes, one note per topic) and whether their format is right (required frontmatter, links that resolve), using typdoc when it is set up. Reports each finding with the skill that fixes it. Use before committing memory, after hand edits, at the start of gmem-tidy, or when the user asks to "check memory", "validate memory", "lint memory", or "is my memory OK". Read-only — to fix what it finds, use gmem-tidy, gmem-judge or gmem-migrate.
---

# gmem-check

A fast, read-only check of every gmem folder. It answers two questions: does memory
follow gmem's rules, and is its format right. It writes nothing.

`gmem-tidy` goes further: it checks content against the real code and fixes things
with the user. Run `gmem-check` often; run `gmem-tidy` now and then.

## Where this lives

Resolve the gmem config first, using the rules in `gmem-setup`. This skill reads every
kind: `<memory>`, `<note>`, `<rules>`, `<precedents>`, `<learnings>`, `<proposals>`,
`<retro>`, each `<location.<kind>>/<memory_dir>/<kind>/`. A folder that doesn't exist
has nothing to check; skip it.

## 1. Rules

Check each rule mechanically. Every finding gets a rule id, a level, the file, and the
skill that fixes it.

| Rule id | Level | Check | Fix with |
|---|---|---|---|
| `layout.active-flat` | error | No topic file sits directly under `<memory>/active/`; only `index.md`, `correction/` and `reference/` | `gmem-migrate` or `gmem-tidy` |
| `layout.unknown` | warn | No folder or file in a kind's folder that the layout in `gmem-setup` does not list | `gmem-tidy` |
| `name.learning` | error | `<learnings>/<slug>.md`: lowercase kebab-case, no date prefix | `gmem-tidy` |
| `name.retro` | error | `<retro>/YYYY-MM-DD-<slug>.md` | `gmem-tidy` |
| `name.note` | error | `<note>/YYYY-MM-DD_HHMM_<topic>.md` | `gmem-migrate` |
| `name.ledger` | warn | A file directly under `<memory>/` is named `YYYY-MM-DD_HHMM_<topic>.md` | `gmem-migrate` |
| `index.missing` | error | Every file in `<rules>/`, `<precedents>/` and `<memory>/active/` (both categories) has a row in that folder's `index.md`. A folder with files and no `index.md` fails for every file | `gmem-tidy` (rules and precedents: the human adds the row) |
| `index.dangling` | error | Every row in those `index.md` files names a file that exists | `gmem-tidy` |
| `index.duplicate` | warn | No file has two rows in one index | `gmem-tidy` |
| `note.duplicate-topic` | warn | No two notes share a topic (the part after the timestamp, compared loosely: `az-data-volume` and `az-data-volume-cli` are one topic) | `gmem-note` (merge into one) |
| `rules.single-file` | error | No `rules.md` file in place of the `rules/` folder | `gmem-migrate` |

Signals that need judgment. Report these as `warn` and never as errors, because a
mechanical check can be wrong:

| Rule id | Signal | Fix with |
|---|---|---|
| `learning.diary` | A learning written in the first person ("I", "we"), or with a timeline ("today", "then", a date in the body) | `gmem-judge` |
| `learning.multi-fact` | A learning with more than one heading, or a list of separate facts | `gmem-judge` |
| `correction.incomplete` | A file in `active/correction/` (other than `lessons.md`) that lacks one of: what was done wrong, the exact words that caught it, the signal to recognize it, what to do instead | `gmem-tidy` |

## 2. Format

For each `.gmem/` folder, check whether it has a `.typdoc/config.json`.

**With typdoc.** Run it and take its findings as they are:

```
TYPDOC_DIR=<that .gmem/ folder> typdoc validate --json
```

Exit 0 is no errors, exit 2 is at least one error; the report is on stdout either way.
Keep typdoc's rule ids (`frontmatter.types`, `body.links`, and the rest). If `typdoc` is
not on `PATH`, try `~/.local/bin/typdoc`; if it is missing, say so and fall back to the
check below.

**Without typdoc.** Check these yourself:

| Rule id | Level | Check |
|---|---|---|
| `fm.learning` | error | A learning has `author` and `created` (a `YYYY-MM-DD` date). `reviewer` may be empty |
| `fm.retro` | error | A retro has `author` and `created` |
| `fm.proposal` | error | A proposal has `author` and `created` |
| `fm.note` | error | A note has `status`, one of `in-progress`, `blocked`, `done` |
| `fm.parse` | error | A frontmatter block that is not valid YAML |
| `links.body` | error | A relative Markdown link in any memory file points at a file that exists |

Memory under `<memory>/`, rules and precedents have no required frontmatter.

If typdoc is installed but not set up, mention once that `gmem-typdoc` sets it up.

## 3. Report

Group the findings by folder, then by rule id:

```
<project>/.gmem   2 errors, 1 warn
  index.missing        memory/active/reference/staging.md has no row in active/index.md   → gmem-tidy
  fm.note              note/2026-11-19_1200_x.md: status `wip` is not allowed             → gmem-tidy
  note.duplicate-topic note/…_seed-script.md and note/…_seed-script-fixtures.md           → gmem-note
~/.gmem          clean
```

End with one line: the totals, and whether anything needs fixing before a commit (any
error). If there are no findings, say so in one line.

## Don't

- Don't write, move or delete anything — not even to fix an index row. Report it.
- Don't judge whether a fact is still true against the code. That is `gmem-tidy`.
- Don't raise a judgment signal to `error`.
- Don't read the ledger, notes or retros for their content beyond the checks above.
  They are dated records.
