---
name: gmem-bye
description: End-of-session checkpoint that checks whether anything from the session belongs in a note, memory, retro, or learning, and records only what qualifies. Use proactively on any wrap-up or goodbye signal in Thai or English — "จบแล้ว", "พอแค่นี้ก่อน", "บาย", "done for now", "wrapping up", "good night", or "note/memory/retro if needed" — even if the user doesn't mention memory. Not for logging a correction — use gmem-stop.
---

# gmem-bye

One checkpoint instead of remembering four separate skills, or saying "note/memory/retro
if needed" and hoping the right subset gets picked. Walk through all four below, every
time this fires — not just the ones that come to mind first.

## Walk through each, call only the ones that qualify

1. **`gmem-note`** — is some project/topic in a state worth leaving for the next
   session or another agent to pick up from? Includes updating an existing note's
   `status` (e.g. to `done` or `blocked`).
2. **`gmem-memory`** — did your understanding of how something works change, or did
   you get something wrong that `active/` should now correct? That is maintained
   understanding, revised in place.
3. **`gmem-retro`** — does this session/task have enough of a story (decisions made,
   dead ends hit, threads left open) worth a diary entry?
4. **`gmem-learn`** — did a single durable fact come up — a gotcha, a constraint, a
   how-things-work truth — that would stay true and useful long after this work, to
   anyone?

Not every checkpoint produces all four. Evaluate each on its own — a quiet session might
only warrant a note; a long one might warrant all four. The point of this skill is
making sure each is actually considered, not that each is actually written.

Then say goodbye.
