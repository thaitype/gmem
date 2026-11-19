---
name: gmem-setup
description: Set up or inspect gmem's config, which decides where each kind of memory (memory, note) is stored — in the project or at the user level. Use when the user asks to set up gmem, change where memory or notes are kept, check which gmem config is in effect, or when a gmem skill finds no config and needs one. Also use for "gmem-setup".
---

# gmem-setup

gmem reads a small TOML config that says where each kind of memory lives. This skill
explains how that config is resolved and, when there is none, walks the user through
creating one.

## The config

```toml
memory_dir = ".gmem"      # folder name under the base; default ".gmem"

[location]
memory = "${PROJECT}"       # where `gmem-memory` entries live
note   = "${USER}"          # where `gmem-note` entries live
```

- `${PROJECT}` = the project root: the git root, or the current directory if not a git repo.
- `${USER}` = the user's home directory (`~/`).
- A location can also be a **custom path** instead of one of those two: an absolute
  path (`/data/gmem`), a home path (`~/work/gmem`), a path built on a variable
  (`${PROJECT}/docs`), or a relative path (resolved against `${PROJECT}`).
- A kind's folder is `<base>/<memory_dir>/<kind>/`, where `<base>` is the location value
  and `<kind>` is `memory` or `note`. With the example above: memory is in
  `<project>/.gmem/memory/`, notes are in `~/.gmem/note/`. With
  `note = "/data/gmem"`, notes are in `/data/gmem/.gmem/note/`.

Defaults when a key is missing: `memory_dir = ".gmem"`, `memory = "${PROJECT}"`,
`note = "${PROJECT}"`.

## Which skill uses which key

- `location.memory` is used by **`gmem-memory`**: its entries are stored in the
  resolved `memory` folder.
- `location.note` is used by **`gmem-note`**: its entries are stored in the resolved
  `note` folder.

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
2. **Where should `memory` live?** Project (`${PROJECT}`), user (`${USER}`), or a custom
   path the user types in.
3. **Where should `note` live?** Project (`${PROJECT}`), user (`${USER}`), or a custom
   path the user types in.

Do not ask about `memory_dir`; leave it at the default unless the user brings it up.

Before writing:

- If a config file already exists at the chosen path, show it and confirm before
  overwriting.
- If a higher-priority file exists than the one being written, say so: the new file
  will be ignored until that one is removed.

After writing, print the resolved folders, for example:

```
memory -> /path/to/project/.gmem/memory
note   -> /Users/you/.gmem/note
config -> /path/to/project/.gmem/gmem-config.toml
```

Create the folders only when something is first saved into them, not during setup.

## Not this skill's job

- Writing memory or notes themselves — that is `gmem-memory` and `gmem-note`.
- Other memory kinds (learnings, retros, precedents, rules) — not configurable yet;
  only `memory` and `note` are.
