---
name: gmem-map
description: The map of the whole gmem garden — what kinds of memory exist, which layer wins on conflict, when to recall and validate, which skill records what, and the everyday rhythm. Open it at the start of a session or before non-trivial work in a project that uses gmem, when unsure which gmem skill fits, or when the user asks how memory works here. Read-only; it points to the skills that read and write.
---

# gmem-map

The map of the whole garden: which beds exist, which paths to take, and which tool does
what. What is planted inside each bed is listed in that bed's own `index.md`.

## Where the garden is

Each kind of memory has its own folder, set by `gmem-setup`. By default, this
project's context and status live in the project (`<project>/.gmem/memory/`,
`<project>/.gmem/note/`), and what carries across projects lives at user level
(`~/.gmem/rules/`, `precedents/`, `learnings/`, `proposals/`, `retro/`). Use memory on
every task — both to inform your work and to record what you learn. Don't let hard-won
facts evaporate when a session ends.

## Two shapes of memory

One test separates them — "will this still matter after this work is done?":

- **Learning** (recipe card) — a durable fact about the world: a gotcha, a constraint, a
  how-things-work truth. No "I", no timeline. Valid and usable the moment it's captured.
  (yes to the test)
- **Retro** (diary) — the story of a session: what happened, decisions, dead ends,
  what's unfinished. Written for tomorrow-you. (no to the test)

## Authority

Highest to lowest: **`rules/` > `precedents/` > `active/` > `learnings/`**. On any
conflict the higher layer wins. Notes and `retro/` are context, not authority.

## Use memory (every task)

- **Recall — before starting non-trivial work.** Run `gmem-recall`. It reads, in order:
  `rules/index.md`, `precedents/index.md`, `active/index.md`, and notes that are
  `in-progress` or `blocked`, opening only what touches the task. Learnings, retros and
  done notes are reference, opened only when needed.
- **Validate — before finalizing consequential output, plans, or decisions.** Check them
  against the authority order: never violate a rule; align with precedents unless you
  have a clear, stated reason; treat learnings as advice. If you hit a situation memory
  doesn't cover, that's a gap — capture it with `gmem-learn`.

## Record memory

| Skill | Use it for |
|---|---|
| `gmem-learn` | Capture a durable fact. **Reach for this constantly** — any time you hit a gotcha or learn how something really works, even if no one asked. The primary memory action. |
| `gmem-memory` | Maintain current understanding in `active/`: corrections and references, revised in place. |
| `gmem-note` | Leave a status board for one piece of work, so the next session can pick it up. |
| `gmem-retro` | At the end of a meaningful chunk of work, write the session diary, then pull durable facts out of it into learnings. |
| `gmem-stop` | Manual-only: when the user says you got something wrong, invoke it to write the correction into `active/correction/`. Never triggered on its own. |
| `gmem-bye` | On any wrap-up or goodbye, walk through note, memory, retro and learn, and record whichever has something worth keeping. |

## Tend the garden

| Skill | Use it for |
|---|---|
| `gmem-judge` | Periodically tidy the learnings: revise rough ones in place, raise proposals in `proposals/` for facts worth promoting to precedents or rules. Non-blocking — learnings stay valid regardless. |
| `gmem-tidy` | Now and then, audit memory against the rules for each layer and the real code, decide fixes with the user, then apply them. |
| `gmem-setup` | Choose or inspect where each kind of memory is kept. |

Promoting to a precedent or rule is a human step: add the file to `precedents/` or
`rules/<topic>.md`, and its row to that folder's `index.md` (one row per file: file →
when to read it) in the same change.

## Rhythm

Recall before working, validate before finalizing, capture learnings as you go, run bye
when a chunk concludes, run the judge and tidy now and then. Never wait on review —
memory is usable immediately.
