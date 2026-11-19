---
name: gmem-setup
description: Sets up or inspects gmem's config, which decides where each kind of memory is stored — memory, notes, rules, precedents, learnings, proposals and retros, each in the project, at user level, or a custom path. Use when the user wants to set up gmem, change where any kind is kept, check which config is in effect, check or install the skills gmem-tidy depends on (grilling, wayfinder), or when another gmem skill finds no config. Not for converting old typmem or crew folders — use gmem-migrate.
---

# gmem-setup

gmem reads a small TOML config that says where each kind of memory lives. This skill
explains how that config is resolved and, when there is none, walks the user through
creating one.

## The config

```toml
memory_dir = ".gmem"          # folder name under each base; default ".gmem"

[location]
memory     = "${PROJECT}"     # gmem-memory: ledger and active/
note       = "${PROJECT}"     # gmem-note
rules      = "${USER}"
precedents = "${USER}"
learnings  = "${USER}"        # gmem-learn
proposals  = "${USER}"        # gmem-judge
retro      = "${USER}"        # gmem-retro
```

- `${PROJECT}` = the project root: the git root, or the current directory if not a git repo.
- `${USER}` = the user's home directory (`~/`).
- A location can also be a **custom path** instead of one of those two: an absolute
  path (`/data/gmem`), a home path (`~/work/gmem`), a path built on a variable
  (`${PROJECT}/docs`), or a relative path (resolved against `${PROJECT}`).
- A kind's folder is `<base>/<memory_dir>/<kind>/`, where `<base>` is that kind's
  location value. With the example above: memory is in `<project>/.gmem/memory/`, notes
  in `<project>/.gmem/note/`, learnings in `~/.gmem/learnings/`, rules in
  `~/.gmem/rules/`. With `rules = "/data/gmem"`, rules are in `/data/gmem/.gmem/rules/`.

Every gmem skill names a kind's folder by the kind in angle brackets: `<memory>`,
`<note>`, `<rules>`, `<precedents>`, `<learnings>`, `<proposals>`, `<retro>`.

### Layout

```
<memory>/        YYYY-MM-DD_HHMM_<topic>.md   ledger
  active/        index.md, correction/, reference/
<note>/          YYYY-MM-DD_HHMM_<topic>.md
<rules>/         index.md + <topic>.md
<precedents>/    index.md + <slug>.md
<learnings>/     <slug>.md
<proposals>/     <slug>.md
<retro>/         YYYY-MM-DD-<slug>.md
```

### Defaults

The defaults are the **recommended** split. A key missing from the config takes its
default; with no config at all, every key does.

- Project level: `memory`, `note`. They hold this project's context and status.
- User level: `rules`, `precedents`, `learnings`, `proposals`, `retro`. They hold what
  the agent learns and what you decide, so it carries across projects.
- `memory_dir`: `.gmem`.

## Which skill uses which key

| Skill | Keys |
|---|---|
| `gmem-memory`, `gmem-stop` | `memory` |
| `gmem-note` | `note` |
| `gmem-learn` | `learnings` (reads `retro` when extracting from one) |
| `gmem-retro` | `retro` |
| `gmem-judge` | writes `learnings`, `proposals`; reads `rules`, `precedents` |
| `gmem-recall`, `gmem-tidy`, `gmem-map` | all keys |

Each of those skills resolves the config as described below before it reads or writes.

## Resolution (read this before any gmem skill reads or writes memory)

Look for the config in three places. Highest priority first:

1. `<project>/gmem-config.toml`
2. `<project>/.gmem/gmem-config.toml`
3. `~/.gmem/gmem-config.toml`

Rules:

- Use **only the highest-priority file found**, as a whole. Do not merge keys across files.
- A key missing from that file takes its default, not a value from a lower file.
- If more than one file exists, **warn** which lower-priority files are being ignored,
  then carry on. Never fail because of this.
- If none exist, use the defaults and offer to run the setup below.

The config file itself is always found at those three fixed paths, whatever
`memory_dir` says.

## Setup (when there is no config, or the user wants to change it)

Ask **one question at a time**. Show the choices, wait for the answer, then move on.

1. **Where should the config live?** Offer two options:
   - **User level** — set up once, used by every project.
     Writes `~/.gmem/gmem-config.toml`.
   - **Project level** — set up per project, so each project is configured on its own.
     Writes `<project>/.gmem/gmem-config.toml`.
2. **Which locations?** Offer two options:
   - **Recommended** — `memory` and `note` in the project; `rules`, `precedents`,
     `learnings`, `proposals` and `retro` at user level. Write all seven keys with
     those values.
   - **Custom** — ask about each kind on its own, in this order: `memory`, `note`,
     `rules`, `precedents`, `learnings`, `proposals`, `retro`. For each, offer Project
     (`${PROJECT}`), User (`${USER}`), or a custom path the user types in.

Do not ask about `memory_dir`; leave it at the default unless the user brings it up.

Before writing:

- If a config file already exists at the chosen path, show it and confirm before
  overwriting.
- If a higher-priority file exists than the one being written, say so: the new file
  will be ignored until that one is removed.

After writing, print the resolved folders, for example:

```
memory     -> /path/to/project/.gmem/memory
note       -> /path/to/project/.gmem/note
rules      -> /Users/you/.gmem/rules
precedents -> /Users/you/.gmem/precedents
learnings  -> /Users/you/.gmem/learnings
proposals  -> /Users/you/.gmem/proposals
retro      -> /Users/you/.gmem/retro
config     -> /path/to/project/.gmem/gmem-config.toml
```

Create the folders only when something is first saved into them, not during setup.

Then ask one more question:

3. **Add typdoc to help check memory format?** Say first that gmem does not need
   typdoc: `gmem-check` already checks format on its own. typdoc is an optional helper
   that checks each file's frontmatter against a schema and reports broken links, and
   `gmem-check` uses it when it is set up.
   - **No (default)** — skip it. The user can run `gmem-typdoc` any time later.
   - **Yes** — run `gmem-typdoc`, which ships with the `gmem-extensions` plugin. If that
     skill is not available, show how to get it
     (`/plugin install gmem-extensions@gmem`, or `npx skills@latest add thaitype/gmem`) and
     stop there. `gmem-typdoc` asks before it installs typdoc itself.

## Dependencies

`gmem-tidy` decides its fixes with the user through two skills from
[mattpocock/skills](https://github.com/mattpocock/skills): `grilling` for a handful of
related decisions, `wayfinder` for many independent ones. `wayfinder` also calls
`research` for its research tickets.

At the end of setup, and whenever the user asks to check dependencies:

1. Check which of these three are among the skills available in this session:
   `grilling`, `wayfinder`, `research`.
2. If all are there, say so in one line.
3. If any are missing, list them and show the command that installs all three:
   ```
   npx skills@latest add mattpocock/skills --skill grilling wayfinder research
   ```
   Add `-g` to install at user level instead of this project. Run it only if the user
   says so. A newly installed skill may only show up in a new session.

These are optional: without them `gmem-tidy` still works, asking its questions one at a
time.

## Not this skill's job

- Writing memory, notes, learnings or retros themselves — that is the skill for each
  kind (see the table above).
- Moving files from an older layout — that is `gmem-migrate`.
