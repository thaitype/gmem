---
name: gmem-recall
description: Looks up what memory already says — rules, precedents, active notes, and open work — that bears on the task at hand. Use before starting non-trivial work, when resuming earlier work, before locking in a consequential decision or plan, or when the user asks "what do we know about X", "have we hit this before", or "check memory first", even if they don't mention memory. Read-only — to write, use gmem-learn, gmem-memory, gmem-retro, gmem-note, or gmem-judge.
---

# gmem-recall

Read memory and notes for whatever is relevant to the task in front of you, and bring it back as a short, usable brief — not a dump of file contents. This is the read side of gmem; it never writes.

## When to reach for this

- **Before starting non-trivial work.** Anything more than a trivial one-liner deserves a quick check: has this constraint, gotcha, or decision already been recorded?
- **Before finalizing consequential output** — a plan, a design decision, a piece of advice — validate it against memory rather than contradicting a known rule or precedent by accident.
- **When resuming paused work.** The in-progress note is the first place to look; a `retro/` entry adds the story if needed.
- **When the user asks directly** — "what do we know about X", "did we hit this before", "check memory", "any precedent for this".

Skip it for trivial, throwaway asks where recall adds nothing (e.g. "format this JSON").

## Where this lives

Resolve the gmem config first, using the rules in `gmem-setup`. This skill uses both keys:

- `<memory>` = `<location.memory>/<memory_dir>/memory/` (default `<project>/.gmem/memory/`)
- `<note>` = `<location.note>/<memory_dir>/note/` (default `<project>/.gmem/note/`)

The two can live in different places. If there is no config, use the defaults and carry on; mention once that `gmem-setup` can change where memory and notes are kept. A folder that doesn't exist just means nothing is recorded there yet.

## Authority — weigh what you find accordingly

Read top to bottom: the order you read in is also the order of authority. Tiers 1–4 are checked every time. Each is cheap: one short file, or an index that points at the few files worth opening.

```
1. Rule        <memory>/rules/index.md          read index → open matching rows
               highest — never violate
2. Precedent   <memory>/precedents/index.md     read index → open matching rows
               align with, unless you have a clear, stated reason not to
3. Memory      <memory>/active/index.md         read index → open matching rows
               <memory>/active/correction/lessons.md   read whole
               current understanding — trust it over learnings
4. Note        <note>/*.md with status in-progress or blocked
               → read in full the ones touching the task; list the rest by name
               context only — tells you where work stands, not what is true
── Reference (open only when needed) ──
   <memory>/learnings/   advice — useful, but not binding
   <memory>/retro/, the ledger (<memory>/YYYY-MM-DD_HHMM_*.md), notes with
   status done, <memory>/proposals/   context only, not authority
```

On conflict, the higher layer wins: rules > precedents > active memory > learnings. Notes and retros never override any of them. Mention the conflict — don't silently pick the lower one.

## How to recall

1. **Rule.** Read `<memory>/rules/index.md` and open every row whose "when to read" touches the task. When unsure whether a rule applies, open it — a missed rule costs more than an extra read.
2. **Precedent.** Read `<memory>/precedents/index.md` and open every row whose "when to read" touches the task.

   For both `rules/` and `precedents/`, check the index is complete:
   ```
   ls <memory>/rules/ <memory>/precedents/
   ```
   Any file without a row in its index: read its name (and the file, if the name looks relevant), and tell the user the index is stale so they can add the row. If there is no index but there are files, treat every file as unindexed.
3. **Memory.** Read `<memory>/active/index.md`, open the rows that touch the task, and read `active/correction/lessons.md` whole. If the index is missing or a topic file isn't in it, fall back to listing `active/correction/` and `active/reference/`.
4. **Note.** Find open work:
   ```
   grep -lE '^status:[[:space:]]*(in-progress|blocked)' <note>/*.md
   ```
   Read in full the notes whose topic touches the task. List the others by filename only — the user may want to know what else is open, but don't read them all.
5. **Reference — only when needed.** Open learnings, retros, the ledger, done notes or proposals only when:
   - something from tiers 1–4 points at them,
   - the user asks "have we hit this before" / "any history on X",
   - you are resuming a thread and the note doesn't explain enough (read the matching retro in full — retros are narrative, skimming loses the thread), or
   - a consequential decision has nothing to go on from tiers 1–4.

   There is no semantic index for these; search by the task's key terms, synonyms and component names, trying a few variants:
   ```
   grep -rli '<keyword>' <memory>/learnings/ <memory>/retro/
   ```
6. Read the full content of every file you rely on — don't act on a filename, index row or grep snippet alone.
7. **Brief.** Group what you found: binding (rules, precedents), current understanding (active memory), open work (notes), and any reference you opened — each with its source file. If nothing relevant turns up, say so plainly rather than forcing a match.
8. If you notice a gap — a situation memory doesn't cover — flag it and suggest `gmem-learn` (or `gmem-memory`) once the work produces the answer. Don't write it yourself from here.

## Don't

- Don't write any file under `<memory>/` or `<note>/` — this skill is read-only. That includes fixing a stale index; report it instead.
- Don't skip `rules/index.md` even for a "quick" task — it's meant to be cheap to check every time.
- Don't read every learning, retro or note "just in case" — reference is opened on need.
- Don't treat a note or retro as authority — it says where work stands, not what is true.
- Don't treat an empty `reviewer` field on a learning as "not usable yet" — every learning is valid the moment it's captured, judged or not.
- Don't let a lower layer override a higher one — flag the conflict instead of quietly picking one.
- Don't dump raw file contents back at the user as the whole answer — synthesize a brief that actually applies to the task.
