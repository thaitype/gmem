# Home repo: one home, many repos

A home repo is one small Git repository that holds the agent's instructions, shared
docs and shared skills, and points at the code repositories your team works in. The
code repositories are cloned into `workspace/`, which the home repo ignores. You open
the agent in the home repo, not in any single code repository.

The pattern comes from [The Home Repo Pattern](https://www.aihero.dev/the-home-repo-pattern)
on AI Hero.

## When to use it

- Your work crosses repositories, for example a change that touches `storefront` and
  `payments-api` together.
- You want one set of instructions, coding standards and skills instead of a copy in
  every repository.
- You want one agent that knows the whole system.

If you work in a single repository, put gmem in that repository and skip this pattern.

## How gmem fits

One agent, one memory, used across repos. The agent runs from the home repo, so the
home repo is the project root. `memory` and `note` are set to `${PROJECT}` in
[`.gmem/gmem-config.toml`](.gmem/gmem-config.toml), which keeps them in the home repo's
`.gmem/`. Memory about `storefront` and about `payments-api` sit side by side, and a
note can track a change that spans both.

The code repositories under `workspace/` are not part of the home repo's history. Your
team shares memory by pushing the home repo.

## Layout

```
home-repo/
  README.md
  AGENTS.md                 main instructions and pointers to the child repos
  CLAUDE.md                 one line: @AGENTS.md
  .gitignore                workspace/
  docs/                     coding standards, glossary
  .claude/skills/           skills shared by every repo
  .gmem/
    gmem-config.toml
    memory/active/          what the agent knows (index.md + topic files)
    note/                   where work stands
  workspace/                child repos, cloned on demand (ignored)
```

## Try it

1. Copy this folder to a new Git repository.
2. Install the gmem plugin (see the [root README](../../README.md#install)).
3. Open Claude Code in the folder and ask it to change something in `storefront`. It
   clones `workspace/storefront` if missing, reads the memory and the open note, and
   works from there.
