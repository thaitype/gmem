---
name: gmem-migrate
description: Migrates older memory into the current gmem layout — from typmem (.typmem/ folders, ~/.typmem/memory/, a single rules.md, old skill names) or the crew layout (locker/memory/, locker/note/, crew-note/crew-memory/crew-good-bye) — with a dry-run plan first and nothing deleted. Manual-only — run as /gmem-migrate.
disable-model-invocation: true
---

# gmem-migrate

Move memory that was written for an older layout into the one the `gmem` plugin reads
today. This touches many files at once, so it is manual-only, and it always shows the
plan before changing anything.

## Target layout

Resolve the gmem config first, using the rules in `gmem-setup`. If there is no
config, offer to run the `gmem-setup` interview before going further — where memory
should end up is the first decision of a migration. Then:

- `<memory>` = `<location.memory>/<memory_dir>/memory/`
- `<note>` = `<location.note>/<memory_dir>/note/`

```
<memory>/
├── rules/          index.md + <topic>.md
├── precedents/     index.md + <slug>.md
├── learnings/      <slug>.md
├── proposals/      <slug>.md
├── retro/          YYYY-MM-DD-<slug>.md
├── active/
│   ├── index.md    one table per category: file → when to read it
│   ├── correction/ <topic>.md, lessons.md
│   └── reference/  <topic>.md
└── YYYY-MM-DD_HHMM_<topic>.md     ledger
<note>/
└── YYYY-MM-DD_HHMM_<topic>.md     frontmatter `status: in-progress | blocked | done`
```

Every `index.md` row is `| <file> | <when to read it> |`.

## Sources

### A. Older gmem (including when it was named typmem)

gmem was called **typmem** before. Old installs use `typmem` in folder and skill
names.

| Old | Detect | Migrate to |
|---|---|---|
| typmem folders | `.typmem/memory/` or `.typmem/note/` under the project, `~/`, or a custom location from the config | Move into the matching `.gmem/` folder |
| Fixed `~/.typmem/memory/` (before configurable locations) | the folder exists and `<memory>` resolves somewhere else | Ask: move its contents into `<memory>`, or into `~/.gmem/memory/` and set `memory = "${USER}"` in the config |
| `<memory>/rules.md` | the file exists | Split by topic into `rules/<topic>.md` (propose the split; the user confirms — rules are human-owned) and write `rules/index.md` |
| `precedents/` without an index | no `precedents/index.md`, or files missing from it | Write the missing rows; draft each "when to read" from the file, user confirms |
| Old skill names | `typmem-*`, `typ-wait-listen-me`, `typ-wrap-up-memory` in `CLAUDE.md` / `AGENTS.md` | Rename to `gmem-*`; `typ-wait-listen-me` → `gmem-stop`, `typ-wrap-up-memory` → `gmem-bye` |
| Old CLAUDE.md block | a `## Memory (typmem)` or `## Memory (gmem)` section that differs from the current README snippet | Show the diff; replace only if the user agrees |

### B. Crew layout (`locker/`)

| Old | Detect | Migrate to |
|---|---|---|
| `locker/memory/active/<topic>.md` (flat) | topic files directly under `active/` | Classify each as `correction/` or `reference/` (propose; user confirms), move it, then rebuild `active/index.md` |
| `locker/memory/active/index.md` | exists | Use its "when to read" text for the new rows; replace the file with the rebuilt index |
| `locker/memory/*.md` ledger, dated | name starts with a date | Move into `<memory>/` as-is. Ledger entries are dated records — never rewrite their content |
| `locker/memory/*.md`, undated (e.g. `ground-mode.md`) | name has no date | Ask per file: ledger (keep the name, move into `<memory>/`), or current understanding (move into `active/correction/` or `active/reference/`) |
| `locker/memory/index.md` | exists | Drop from the target; its rows feed `active/index.md` where they still apply. Keep the original under the source (nothing is deleted) |
| `locker/note/*.md` | any note file | Move into `<note>/`, rename to `YYYY-MM-DD_HHMM_<topic>.md` (`YYYY-MM-DD-<topic>.md` becomes `YYYY-MM-DD_0000_<topic>.md`; the date stays the note's creation date), and add `status:` frontmatter — infer it from the body (open items → `in-progress`, waiting on someone → `blocked`, all done → `done`) and let the user confirm |
| `locker/note/index.md`, `locker/note/tmp/` | exist | Not part of the gmem layout. Leave in place and report |
| Crew skill names | `crew-note`, `crew-memory`, `crew-good-bye` in `CLAUDE.md` / `AGENTS.md` | Rename to `gmem-note`, `gmem-memory`, `gmem-bye`, only after asking — these skills may still be installed and in use |

The crew source is `locker/` under the project by default; ask for the path if it isn't
there.

## How to run

1. **Resolve** the target as above and print it:
   ```
   memory -> /path/.gmem/memory
   note   -> /path/.gmem/note
   ```
2. **Scan** every source in the tables. Skip anything already in the target layout, so
   running twice is safe. If nothing needs migrating, say so and stop.
3. **Show the plan** as a dry run, grouped by source: each move (`old → new`), each new
   or rebuilt index, each rename in `CLAUDE.md` / `AGENTS.md`, and a count of decisions
   that need the user.
4. **Decide** those one question at a time, each with a recommended answer: which
   category a file belongs in, how to split `rules.md`, a note's `status`, whether an
   undated file is ledger or active. Do not batch them into one wall of questions.
5. **Confirm** the final plan once, then apply:
   - Use `git mv` when source and target are in the same git repo, so history follows.
     Otherwise copy, and tell the user the source can be removed by hand once they've
     checked the result.
   - Never delete a source file, and never rewrite the content of a ledger entry,
     retro, rule or precedent — only move it, or add frontmatter to a note.
   - Create target folders only when writing into them.
6. **Record** one ledger entry `<memory>/YYYY-MM-DD_HHMM_gmem-migrate.md`: sources,
   what moved where, which decisions the user made, and (in git) the pre-migration
   commit to recover anything from (`git show <sha>:<path>`).
7. **Verify** and report:
   - every file in `rules/`, `precedents/` and `active/` has a row in its `index.md`,
     and every row points at a file that exists;
   - every link inside `<memory>` resolves (ledger, retros and notes may keep old links —
     report them, don't fix them);
   - every note has a valid `status`.
   Then suggest running `gmem-tidy` to check content now that the layout is right.

## Don't

- Don't apply anything before the user confirms the plan.
- Don't delete source files or overwrite an existing target file — on a name clash,
  stop and ask.
- Don't edit rule or precedent content. Splitting `rules.md` moves its text; it doesn't
  reword it.
- Don't rename skills in `CLAUDE.md` / `AGENTS.md` without asking, and don't touch other
  sections of those files.
- Don't tidy content here (stale facts, duplicates, diary leakage) — that is
  `gmem-tidy`'s job, after migration.
