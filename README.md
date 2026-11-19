# typmem

Most agent memory works like a recorder: it saves everything automatically and
finds things again with semantic search, usually a vector index. You don't see
what was kept, and you can't easily tell why one memory came back and another
didn't.

typmem is a garden. Memory is plain Markdown in a folder you own. The agent walks
through it at the start of every task. You decide what grows there, and you prune
it so the paths stay clear.

- **You plant.** `typmem-learn` and `typmem-stop` add a fact or a correction when
  it's worth keeping. Nothing is saved without someone choosing to save it.
- **You lay the paths.** Each layer has an `index.md`, one row per file saying
  when to read it. The agent follows those rows instead of guessing by similarity.
- **You prune.** `typmem-judge` and `typmem-tidy` find what's stale, duplicated or
  wrong. You approve what gets cut or moved.
- **Some beds are fenced.** `rules/` and `precedents/` change only when a human
  decides. The agent can suggest, never rewrite.

A garden like this needs some work from you. In return, every memory can be read,
checked with `git diff`, and traced to the person who put it there.

install skills

```
npx skills@latest add thaitype/typmem
```

## Where memory is stored

Run `typmem-setup` to choose where `memory` and `note` are kept (this project, your
home directory, or a custom path). With no config the default is the project:
`<project>/.typmem/memory/`. Earlier versions stored everything in `~/.typmem/memory/`;
to keep using that, set `memory = "${USER}"` in your typmem config.

## Place this in CLAUDE.md

```md
## Memory (typmem)

You have a persistent memory system in the memory folder set by `typmem-setup`
(default `<project>/.typmem/memory/`). Use it on every task —
both to inform your work and to record what you learn. Don't let hard-won facts
evaporate when a session ends.

Two shapes of memory, separated by one test — "will this still matter after this
work is done?":
- **Learning** (recipe card) — a durable fact about the world: a gotcha, a
  constraint, a how-things-work truth. No "I", no timeline. Valid and usable the
  moment it's captured. (yes to the test)
- **Retro** (diary) — the story of a session: what happened, decisions, dead
  ends, what's unfinished. Written for tomorrow-you. (no to the test)

Authority hierarchy, highest to lowest: **`rules/` > `precedents/` > `active/` >
`learnings/`**. On any conflict the higher layer wins. (Notes and `retro/` are
context, not authority.)

### Use memory (every task)

- **Recall — before starting non-trivial work.** Run `typmem-recall`. It reads, in
  order: `rules/index.md`, `precedents/index.md`, `active/index.md`, and notes
  that are `in-progress` or `blocked`, opening only what touches the task.
  Learnings, retros and done notes are reference, opened only when needed.
- **Validate — before finalizing consequential output, plans, or decisions.**
  Check them against the hierarchy: never violate a rule; align with precedents
  unless you have a clear, stated reason; treat learnings as advice. If you hit a
  situation memory doesn't cover, that's a gap — capture it with `typmem-learn`.

### Record memory

- `typmem-learn` — capture a durable fact. **Reach for this constantly** — any
  time you hit a gotcha or learn how something really works, capture it, even if
  no one asked. The primary memory action.
- `typmem-retro` — at the end of a meaningful chunk of work, write the session
  diary, then pull any durable facts out of it into learnings.
- `typmem-judge` — periodically tidy the learnings: revise rough ones in place,
  raise proposals in that folder's `proposals/` for facts worth promoting to
  precedents or rules. Non-blocking — learnings stay valid regardless.
- `typmem-stop` — manual-only: when the user says you got something wrong, invoke
  it to write the correction into `active/correction/`. Never triggered on its own.
- `typmem-bye` — on any wrap-up or goodbye, walk through note, memory, retro and
  learn, and record whichever has something worth keeping.
- `typmem-tidy` — now and then, audit memory against the rules for each layer
  and the real code, decide fixes with the user, then apply them.
- Promoting to a precedent or rule is a human step: add the file to `precedents/`
  or `rules/<topic>.md`, and its row to that folder's `index.md` (one row per
  file: file → when to read it) in the same change.

Rhythm: recall before working, validate before finalizing, capture learnings as
you go, run bye when a chunk concludes, run the judge and tidy now and then. Never
wait on review — memory is usable immediately.
```