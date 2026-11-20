---
name: gmem-setup
description: Sets up or inspects gmem's config, which decides where each kind of memory is stored — memory, notes, rules, precedents, learnings, proposals and retros, each in the project, at user level, or a custom path. Offers four install modes (Central memory, Home Repo Pattern memory, Dedicated agents memory, Custom) and asks where the config file lives. Use when the user wants to set up gmem, pick an install mode, change where any kind is kept, check which config is in effect, check or install the skills gmem-tidy depends on (grilling, wayfinder), or when another gmem skill finds no config. Not for converting old typmem or crew folders — use gmem-migrate.
---

# gmem-setup

Writes or shows gmem's config, which says where each kind of memory lives.

## The config

```toml
memory_dir = ".gmem"          # folder name under each base

[location]
memory     = "${USER}"
note       = "${USER}"
rules      = "${USER}"
precedents = "${USER}"
learnings  = "${USER}"
proposals  = "${USER}"
retro      = "${USER}"
```

- A location is `${PROJECT}` (the git root, or the current directory if not a git repo),
  `${USER}` (`~/`), or a custom path: absolute (`/data/gmem`), home (`~/work/gmem`),
  built on a variable (`${PROJECT}/docs`), or relative (resolved against `${PROJECT}`).
- A kind's folder is `<location>/<memory_dir>/<kind>/`, e.g. `memory = "${PROJECT}"` →
  `<project>/.gmem/memory/`. Skills name it by the kind in angle brackets: `<memory>`,
  `<note>`, `<rules>`, `<precedents>`, `<learnings>`, `<proposals>`, `<retro>`.
- Defaults: a missing key is `${USER}` (Central memory, everything under `~/.gmem/`), and
  `memory_dir` is `.gmem`.

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

## Resolution (read this before any gmem skill reads or writes memory)

Look for the config here, highest priority first. The config file is always at one of
these paths, whatever `memory_dir` says.

1. `<project>/gmem-config.toml`
2. `<project>/.gmem/gmem-config.toml`
3. `~/.gmem/gmem-config.toml`

- Use **only the first file found**, as a whole. Never merge keys across files.
- A key missing from it takes its default, not a value from a lower file.
- If more than one file exists, **warn** which ones are ignored, then carry on.
- If none exists, use the defaults and offer to run the setup below.

## Setup (when there is no config, or the user wants to change it)

Ask **one question at a time** and wait for each answer.

1. **Do you know gmem already?** If not, invoke `gmem-ask`; when it hands back, go on.
2. **Which install mode?** Each mode presets all seven keys:

   | # | Mode | `memory`, `note` | `rules`, `precedents` | `learnings`, `proposals`, `retro` | Config file (recommended) |
   |---|---|---|---|---|---|
   | 1 | **Central memory** (default) | `${USER}` | `${USER}` | `${USER}` | User level |
   | 2 | **Home Repo Pattern memory** | `${PROJECT}` | `${PROJECT}` | `${PROJECT}` | Project level |
   | 3 | **Dedicated agents memory** | `${PROJECT}` | `${USER}` | `${USER}` | User level |
   | 4 | **Custom** | ask | ask | ask | none |

   1. **Central** — for newcomers: everything in one place, `~/.gmem/`.
   2. **Home Repo** — one home repo on your own machine that works across many repos;
      all memory lives in it. See [examples/home-repo](https://github.com/thaitype/gmem/tree/main/examples/home-repo)
      and https://www.aihero.dev/the-home-repo-pattern.
   3. **Dedicated agents** — each agent or project home keeps its own context and status;
      what is learned and decided is shared at user level. See
      [examples/dedicated-agents](https://github.com/thaitype/gmem/tree/main/examples/dedicated-agents).
   4. **Custom** — ask each kind in order (`memory`, `note`, `rules`, `precedents`,
      `learnings`, `proposals`, `retro`): Project, User, or a custom path.
3. **Where should the config file live?** User level (`~/.gmem/gmem-config.toml`, used by
   every project) or Project level (`<project>/.gmem/gmem-config.toml`). Mark the
   recommended one from the table; for Custom recommend neither.

Write all seven keys. Don't ask about `memory_dir` unless the user brings it up. Before
writing, show and confirm any file already at that path, and warn if a higher-priority
config exists (the new one is ignored until that is removed).

After writing, print each resolved folder and the config path, one per line
(`memory -> /Users/you/.gmem/memory`, …, `config -> /Users/you/.gmem/gmem-config.toml`).
Create folders only when something is first saved into them.

4. **Add typdoc?** Say gmem doesn't need it: `gmem-check` checks format on its own, and
   uses typdoc, when set up, to check frontmatter against schemas and find broken links.
   - **No (default)** — the user can run `gmem-typdoc` later.
   - **Yes** — run `gmem-typdoc` (in the `gmem-extensions` plugin). If it isn't
     available, show `/plugin install gmem-extensions@gmem` or
     `npx skills@latest add thaitype/gmem`, and stop there.

## Dependencies

`gmem-tidy` decides fixes with the user through `grilling` and `wayfinder` (which calls
`research`), from [mattpocock/skills](https://github.com/mattpocock/skills). At the end of
setup, or when asked, check whether all three are available. Say so in one line if they
are; otherwise list the missing ones and show:

```
npx skills@latest add mattpocock/skills --skill grilling wayfinder research
```

Add `-g` for user level. Run it only if the user says so; a new skill may only show up in
a new session. They are optional: without them `gmem-tidy` asks one question at a time.

## Not this skill's job

Writing memory itself (each kind has its own skill), explaining gmem (`gmem-ask`), and
moving files from an older layout (`gmem-migrate`).
