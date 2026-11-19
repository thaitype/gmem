---
name: gmem-retro
description: Write a retrospective diary entry capturing the story of a work session — what you set out to do, what happened, decisions made, dead ends hit, and unfinished threads — to `retro/YYYY-MM-DD-<slug>.md` in the configured memory location. Use this whenever wrapping up work, when the user says they are done / stopping for now / "end of session", when a meaningful chunk of work concludes, or when asked to "write a retro", "log what happened", "record today", or "capture this session". Reach for it even if the user never says the word "retro" — any end-of-work wrap-up is a trigger. Do NOT use this to capture durable facts, gotchas, or how-things-work lessons; those are learnings — use gmem-learn for those.
---

# gmem-retro

Write the diary entry for a chunk of work. A retro is the story of *what happened to you* — useful to tomorrow-you (or your successor) who needs to resume quickly. It is one of several memory layers under `<memory>/`; retro is the raw diary lane, not a reviewed or promoted artifact.

## Where this lives

Resolve the gmem config first, using the rules in `gmem-setup`. This skill uses the
`location.memory` key. `<memory>` below means `<location.memory>/<memory_dir>/memory/`;
with the defaults that is `<project>/.gmem/memory/`. If there is no config, use the
defaults and carry on; mention once that `gmem-setup` can change where memory is kept.

## Retro vs learning — read this first

This single distinction governs everything:

- **Retro = diary.** "What happened to me." Has an `I`, a timeline, decisions, dead ends, loose threads. Useful *soon*, decays fast — three months later most of it is noise because the work moved on.
- **Learning = recipe card.** "What I now know about the world." A distilled fact with no story, no timeline, no `I`. True regardless of which day or project produced it. Useful to anyone, indefinitely. Learnings live elsewhere — `gmem-learn` handles them.

The test to tell them apart: **"Will this still matter after the work that produced it is finished?"**
- No → it is retro material (status, decisions-in-flight, follow-ups). Write it here.
- Yes → it is a learning. Do NOT bury it in the diary; flag it (see step 7) and let `gmem-learn` capture it.

A retro is *allowed and expected* to be messy, first-person, and time-ordered. That is the point — do not sanitize it into a polished report.

## What goes in a retro

Guidance, not a rigid template (the body format is intentionally loose for now — just write the story):

- What you set out to do this session
- What actually happened (a rough timeline is fine)
- Decisions you made, and why
- Dead ends — things you tried that did not work, and what you ruled out
- Where things stand now: unfinished threads, what's paused, the next step for tomorrow-you

## How to write it

1. Resolve today's date in local time as `YYYY-MM-DD`.
2. Make sure the directory exists: `mkdir -p <memory>/retro`
3. Build a short slug describing what this session was about: lowercase kebab-case, 2–5 words, hyphen-separated, no spaces (e.g. `aca-tailscale-sidecar`, `resh-rhai-parser`).
4. Target file: `<memory>/retro/YYYY-MM-DD-<slug>.md` (date prefix + slug — retro is the only memory layer that uses a date in the filename). Each session/topic gets its own file.
5. Create the file with this frontmatter, then the diary body:
   ```
   ---
   author: <agent name or person writing this>
   created: YYYY-MM-DD
   ---
   ```
   If a file with that exact name already exists (you re-ran on the same topic the same day), do NOT overwrite it — append a `## HH:MM — <short label>` section at the end instead.
6. Write the body as a diary per the guidance above. Keep the diary discipline — rough and honest beats polished.
7. Before finishing, scan what you wrote for any durable facts (recipe cards) that snuck in. For each one, tell the user it belongs in a learning and suggest running `gmem-learn` — but do not write to `learnings/` from this skill yourself.

## File rules

- Location: `<memory>/retro/`
- Filename: `YYYY-MM-DD-<slug>.md` (one file per session/topic; slug is a short lowercase kebab-case descriptor)
- Frontmatter (MVP): `author`, `created`. No `reviewer` — retro is never reviewed.
- Body: free-form diary, no fixed template yet.

## Don't

- Don't put durable facts or lessons here — those are learnings (`gmem-learn`).
- Don't overwrite an existing retro file — if the name collides, append a new timestamped section instead.
- Don't add a `reviewer` field or try to promote a retro. Retro is a side lane that *feeds* learnings; it is not on the promotion ladder (`learnings → precedents → rules`).
