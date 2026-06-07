# typmem

install skills

```
npx skills@latest add thaitype/typmem
```

## Place this in CLAUDE.md

```md
## Memory (typmem)

You have a persistent memory system at `~/.typmem/memory/`. Use it — don't let
hard-won facts evaporate when a session ends.

Two shapes of memory, separated by one test — "will this still matter after this
work is done?":
- **Learning** (recipe card) — a durable fact about the world: a gotcha, a
  constraint, a how-things-work truth. No "I", no timeline. **Valid and usable
  the moment it's captured.** (yes to the test)
- **Retro** (diary) — the story of a session: what happened, decisions, dead
  ends, what's unfinished. Written for tomorrow-you. (no to the test)

Skills:
- `typmem-learn` — capture a durable fact. **Reach for this constantly** — any
  time you hit a gotcha or learn how something really works, capture it, even if
  no one asked. This is the primary memory action.
- `typmem-retro` — at the end of a meaningful chunk of work, write the session
  diary, then pull any durable facts out of it into learnings.
- `typmem-judge` — periodically tidy the learnings: revise rough ones in place,
  and raise proposals in `~/.typmem/memory/proposals/` for the few facts worth
  promoting to precedents or rules. Non-blocking — learnings stay valid whether
  or not anyone ever acts on a proposal.

Default habit: capture learnings as you go, write a retro when a chunk of work
concludes, run the judge now and then. Never wait on review — memory is usable
immediately.
```