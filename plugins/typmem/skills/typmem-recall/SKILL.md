---
name: typmem-recall
description: Pull relevant memory from ~/.typmem/memory/ before starting non-trivial work, or when resuming earlier work. Reads rules.md (always), then searches precedents/ and learnings/ for anything relevant to the task at hand, and retro/ when picking up a paused thread. Weighs what it finds by authority (rules > precedents > learnings). Use this at the start of a task, when the user asks "what do we know about X", "have we hit this before", "check memory first", or before finalizing a consequential decision/plan that should be validated against memory. Do NOT use it to write memory — that is typmem-learn/typmem-retro/typmem-judge; this skill only reads.
---

# typmem-recall

Read `~/.typmem/memory/` for whatever is relevant to the task in front of you, and bring it back as a short, usable brief — not a dump of file contents. This is the read side of typmem; it never writes.

## When to reach for this

- **Before starting non-trivial work.** Anything more than a trivial one-liner deserves a quick check: has this constraint, gotcha, or decision already been recorded?
- **Before finalizing consequential output** — a plan, a design decision, a piece of advice — validate it against memory rather than contradicting a known rule or precedent by accident.
- **When resuming paused work.** Look for the relevant `retro/` entry to pick the thread back up.
- **When the user asks directly** — "what do we know about X", "did we hit this before", "check memory", "any precedent for this".

Skip it for trivial, throwaway asks where recall adds nothing (e.g. "format this JSON").

## Authority order — weigh what you find accordingly

```
rules.md        highest — never violate
precedents/     align with, unless you have a clear, stated reason not to
learnings/      advice — useful, but not binding
retro/          context only, not authority — use when resuming a specific thread
```

On conflict between layers, the higher layer wins. If a learning contradicts a precedent or rule, trust the precedent/rule and mention the conflict — don't silently pick the learning.

## How to recall

1. Ensure the directory exists before reading: if `~/.typmem/memory/` doesn't exist yet, there is nothing to recall — say so and move on.
2. **Always read `rules.md`** if present (it's usually short — read it whole).
3. **Search `precedents/` and `learnings/`** for anything touching the task's subject. There is no semantic index (yet) — search by grepping filenames and content for the task's key terms, synonyms, and the tech/component names involved:
   ```
   grep -rli '<keyword>' ~/.typmem/memory/precedents/ ~/.typmem/memory/learnings/
   ```
   Cast a slightly wide net — try a few keyword variants — since slugs are terse and won't always match your first guess.
4. **Only when resuming earlier work**, also check `retro/` for the relevant session (search by topic keyword or, if known, by date):
   ```
   grep -rli '<keyword>' ~/.typmem/memory/retro/
   ```
   Read the most relevant one in full — retros are narrative, skimming loses the thread.
5. Read the full content of every file that matched — don't act on a filename or grep snippet alone.
6. Synthesize a brief for the task at hand: state what's binding (rules/precedents), what's useful advice (learnings), and what prior context applies (retro), each with its source file. If nothing relevant turns up, say so plainly rather than forcing a match.
7. If you notice a gap while recalling — a situation memory doesn't cover — flag it and suggest `typmem-learn` once the work produces the answer. Don't write it yourself from here.

## Don't

- Don't write to any file under `~/.typmem/memory/` — this skill is read-only. Use `typmem-learn`, `typmem-retro`, or `typmem-judge` for writes.
- Don't treat an empty `reviewer` field on a learning as "not usable yet" — every learning is valid the moment it's captured, judged or not.
- Don't let a learning override a precedent or rule — flag the conflict instead of quietly picking one.
- Don't dump raw file contents back at the user as the whole answer — synthesize a brief that actually applies to the task.
- Don't skip `rules.md` even for a "quick" task — it's meant to be cheap to check every time.
