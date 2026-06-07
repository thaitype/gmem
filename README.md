# typmem

install skills

```
npx skills@latest add thaitype/typmem
```

## Place this in CLAUDE.md

```md
## Memory (typmem)

You have a persistent memory system at `~/.typmem/memory/`. Use it on every task —
both to inform your work and to record what you learn. Don't let hard-won facts
evaporate when a session ends.

Two shapes of memory, separated by one test — "will this still matter after this
work is done?":
- **Learning** (recipe card) — a durable fact about the world: a gotcha, a
  constraint, a how-things-work truth. No "I", no timeline. Valid and usable the
  moment it's captured. (yes to the test)
- **Retro** (diary) — the story of a session: what happened, decisions, dead
  ends, what's unfinished. Written for tomorrow-you. (no to the test)

Authority hierarchy, highest to lowest: **`rules.md` > `precedents/` > `learnings/`**.
On any conflict the higher layer wins. (`retro/` is a side lane, not authority.)

### Use memory (every task)

- **Recall — before starting non-trivial work.** Read `rules.md` (always), then
  skim `precedents/` and `learnings/` relevant to the task. Read a `retro/` only
  when resuming earlier work. Weigh what you find in the hierarchy order above.
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
  raise proposals in `~/.typmem/memory/proposals/` for facts worth promoting to
  precedents or rules. Non-blocking — learnings stay valid regardless.

Rhythm: recall before working, validate before finalizing, capture learnings as
you go, write a retro when a chunk concludes, run the judge now and then. Never
wait on review — memory is usable immediately.
```