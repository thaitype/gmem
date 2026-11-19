# gmem

Most agent memory works like a recorder: it saves everything automatically and
finds things again with semantic search, usually a vector index. You don't see
what was kept, and you can't easily tell why one memory came back and another
didn't.

gmem is a garden. Memory is plain Markdown in a folder you own. The agent walks
through it at the start of every task. You decide what grows there, and you prune
it so the paths stay clear.

- **You plant.** `gmem-learn` and `gmem-stop` add a fact or a correction when
  it's worth keeping. Nothing is saved without someone choosing to save it.
- **You lay the paths.** Each layer has an `index.md`, one row per file saying
  when to read it. The agent follows those rows instead of guessing by similarity.
- **You prune.** `gmem-judge` and `gmem-tidy` find what's stale, duplicated or
  wrong. You approve what gets cut or moved.
- **Some beds are fenced.** `rules/` and `precedents/` change only when a human
  decides. The agent can suggest, never rewrite.

A garden like this needs some work from you. In return, every memory can be read,
checked with `git diff`, and traced to the person who put it there.

install skills

```
npx skills@latest add thaitype/gmem
```

## Where memory is stored

Run `gmem-setup` to choose where `memory` and `note` are kept (this project, your
home directory, or a custom path). With no config the default is the project:
`<project>/.gmem/memory/`. To keep memory in your home directory instead, set
`memory = "${USER}"` in your gmem config.

## Migrating older memory

gmem used to be called typmem. The `gmem-tools` plugin has `gmem-migrate`, a
manual-only skill that moves memory from older versions (`.typmem/` folders,
`~/.typmem/memory/`, a single `rules.md`, precedents without an
index) or from a crew-style `locker/` layout into the current one. It
shows a dry-run plan first, asks before every judgment call, and never deletes files.

## Place this in CLAUDE.md

```md
## Memory (gmem)

This project uses gmem. At the start of a session or before non-trivial work, open
`gmem-map` and follow it.
```

The map itself lives in the `gmem-map` skill, so updating the plugin updates every
project that points to it.
