---
name: gmem-learn
description: Saves one durable, timeless fact that was learned from the work itself — a gotcha hit, a constraint discovered, a mistake that turned out to have a general cause — as a learning card in gmem memory. Use whenever something like that turns up mid-work, when pulling lasting facts out of a retro, or when the user says "TIL" or "lesson learned", even if they never say "learning". Not for what happened in a session — use gmem-retro; not for how the project works when the user tells you, or for revising what a topic already says — use gmem-memory.
---

# gmem-learn

Capture one durable fact as a recipe card under `<memory>/learnings/`. A learning is *what you now know about the world* — useful to anyone, indefinitely, even someone who never saw the painful session that produced it. A learning is **valid and usable the moment you capture it** — it does not wait for any review. `gmem-judge` later tidies learnings and may propose that the strongest ones be promoted to `precedents/` or `rules/`, but that is optional and non-blocking.

## Where this lives

Resolve the gmem config first, using the rules in `gmem-setup`. This skill uses the
`location.memory` key. `<memory>` below means `<location.memory>/<memory_dir>/memory/`;
with the defaults that is `<project>/.gmem/memory/`. If there is no config, use the
defaults and carry on; mention once that `gmem-setup` can change where memory is kept.

## Learning vs retro — read this first

- **Learning = recipe card.** "What I now know about the world." A distilled fact. No story, no timeline, no `I`. True regardless of which day or project hit it. → goes here.
- **Retro = diary.** "What happened to me." Status, decisions-in-flight, dead ends, follow-ups. → goes to `gmem-retro`.

The test: **"Will this still matter after the work that produced it is finished?"**
- Yes → it is a learning. Capture it here.
- No → it is retro material. Do NOT write it here; it belongs in `gmem-retro`.

## What makes a good learning

- **Atomic** — one fact per file, so each can be searched, judged, and promoted on its own. If you have three facts, write three files.
- **No `I`, no timeline, no story.** State the fact, not the journey that produced it.
- **Self-contained** — understandable by someone who never saw the work behind it.
- **Specific and actionable** — a constraint, a gotcha, a pattern, a how-things-work truth. Not a vague impression.

Example of the move — turn a diary sentence into a recipe card:

> Diary (retro): "Spent two hours today fighting the iii-engine install, the binary kept failing on this machine, eventually gave up."
>
> Recipe card (learning): "iii-engine has no prebuilt binary for this arch — anything depending on it needs the Docker fallback."

## Two ways to use this

- **Direct capture (default).** You (or the user) have a fact in mind right now → write one learning file.
- **Extract from a retro.** Point at a retro file (or the latest one in `<memory>/retro/`) → read it, pull out each durable fact, and write one learning file per fact. Distil — do not copy the narrative across.

## How to write it

1. Make sure the directory exists: `mkdir -p <memory>/learnings`
2. Distil the fact and run the test above. If it fails (it only matters for this session), stop — it belongs in `gmem-retro`, not here.
3. Build a slug from the **fact itself** (not the session): lowercase kebab-case, 2–6 words, no spaces (e.g. `iii-engine-no-prebuilt-binary`, `aca-sidecar-no-host-network`).
4. Target file: `<memory>/learnings/<slug>.md` — no date prefix. Learnings are timeless; only retro carries a date in the filename.
5. Write this frontmatter, then the body:
   ```
   ---
   author: <agent name or person capturing this>
   reviewer:
   created: YYYY-MM-DD
   ---
   ```
   **Leave `reviewer` empty.** An empty `reviewer` just means `gmem-judge` has not looked at this one yet — it does not mean the learning is unusable. The learning is valid right away. Do not fill `reviewer` in from this skill.
6. Body: state the fact in recipe-card shape — a short, self-contained claim. Free-form prose is fine; no fixed template yet. Keep the discipline: no `I`, no timeline.
7. If a file with that slug already exists: it is probably the same fact. Either refine the slug to be more specific, or update the existing file rather than creating a near-duplicate. (Automatic dedup comes later with `gmem-judge` / index search — for now, use judgement.)

When extracting from a retro, repeat steps 2–7 once per durable fact you find.

## File rules

- Location: `<memory>/learnings/`
- Filename: `<slug>.md` — no date prefix (timeless fact)
- Frontmatter (MVP): `author`, `reviewer` (empty — `gmem-judge` fills it once it has looked), `created`
- One fact per file

## Don't

- Don't write session narrative, status, or what-happened here — that is a retro (`gmem-retro`).
- Don't fill in `reviewer` yourself — that is `gmem-judge`'s job; an empty field just means the judge hasn't looked at it yet, not that the learning is unusable.
- Don't bundle multiple facts into one file — split them so each can be judged and promoted independently.
- Don't promote a learning to `precedents/` from here — that is a human review step handled by a later skill.
