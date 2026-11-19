---
name: gmem-bye
description: Wrap-up checkpoint that walks through every gmem writing skill — gmem-note, gmem-memory, gmem-retro, gmem-learn — and calls whichever ones actually have something worth recording, instead of relying on each one's own trigger firing separately. TRIGGER proactively on any work/session wrap-up or goodbye signal — "จบแล้ว", "จบงานแล้ว", "พอแค่นี้ก่อน", "หยุดตรงนี้ก่อน", "ปิดงาน", "ปิด session", "เดี๋ยวว่าง ๆ ค่อยคุยต่อ", "บาย", "ไปก่อนนะ", "ฝันดี", "done for now", "I'm done", "that's it for today", "stopping here", "wrapping up", "end of session", "bye", "good night", or the literal phrase "note/memory/retro if needed". Does not cover gmem-stop — that one is manual-only and correction-specific, not a wrap-up check.
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
