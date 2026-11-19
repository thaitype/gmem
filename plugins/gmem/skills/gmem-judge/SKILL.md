---
name: gmem-judge
description: >-
   Reviews the captured learnings and acts on each one — fixes small problems in place, or raises a proposal when a learning should be promoted, conflicts with a rule or precedent, or is unclear. Use when asked to "judge", "review the learnings", "triage learnings", "vet the inbox", or "clean up captured facts", or after many gmem-learn captures have piled up. Not for writing rules or precedents (a human acts on proposals), not for retros, and not for a full memory audit — use gmem-tidy.
---

# gmem-judge

Act as the AI judge over captured learnings. Your job is to keep the `learnings/` set clean and to surface the few items worth a human's attention — without ever blocking. **Learnings are valid and usable the moment they are captured.** Nothing here gates them; a human acting (or never acting) on your proposals does not change that.

## Where this lives

Resolve the gmem config first, using the rules in `gmem-setup`. This skill writes
`<learnings>` and `<proposals>`, and reads `<rules>` and `<precedents>`. Each is
`<location.<kind>>/<memory_dir>/<kind>/`; by default all four are under `~/.gmem/`.
If there is no config, use the defaults and carry on; mention once
that `gmem-setup` can change where these are kept.

## Where this sits

```
retro/        diary — never reviewed
learnings/    valid immediately · you revise these in place
proposals/    async queue you write to · human may act, or not
precedents/   created by a human acting on a proposal — not by you
rules/        created by a human acting on a proposal — not by you
```

You operate over `<learnings>/` and write only to `<learnings>/` (revisions) and `<proposals>/` (proposals). You never write `precedents/` or `rules/`, and you never touch `retro/`.

## The `reviewer` field = "already judged"

`reviewer` no longer means "vetted enough to use" — every learning is already usable. It just records that you have looked at this one, so re-running is idempotent:

- empty `reviewer` → not yet judged. Process it.
- filled `reviewer` → already judged. Skip it.

When you finish processing a learning (whichever outcome), set `reviewer` to your judge identity and a date, e.g. `reviewer: gmem-judge/<model> 2026-06-07`. Leave `author` and `created` unchanged.

## The rubric

Judge each learning against:

1. **Durable** — passes "will this still matter after the work that produced it is finished?" Narrative / `I` / a timeline / date-specific status is diary leakage, not a learning.
2. **Atomic** — one fact per file.
3. **Self-contained** — understandable without the originating context.
4. **Specific and actionable** — a real constraint, gotcha, pattern, or truth.
5. **Not a duplicate** — of another learning or a precedent.
6. **Not conflicting** — with a precedent or rule (higher layers win by default).

## Decide automatically — three outcomes

**1. Revise in place** (do it now, no human) — when the fix is cheap and safe and loses no information:
- strip an `I` / a timeline / status that slipped in, leaving the underlying fact
- split a file holding several facts into one file per fact (no fact dropped)
- tighten vague wording, fix a vague slug
- merge a clear exact / near-exact duplicate into the existing learning

**2. Raise a proposal** (write to `proposals/`, non-blocking) — only in these cases:
- **Promote** — the fact is broad, recurring, or high-impact enough that it belongs in `precedents/` or `rules/`. (Keep the bar high — most learnings just stay learnings.)
- **Conflict** — it contradicts an existing precedent or rule. The higher layer wins for now; whether to update the higher layer is a human call.
- **Unclear / risky** — you are not confident enough to revise it safely, or the only "fix" would lose or invent information (e.g. it looks like diary leakage with no clearly salvageable fact → propose removal).

**3. Leave as-is** — a clean, valid, modest learning with no problems and no promotion case. Just mark it judged.

In every case the learning stays valid and usable. A proposal is advice, not a gate.

## How to run

1. Ensure dirs exist: `mkdir -p <proposals>`
2. Find unjudged learnings (empty `reviewer`):
   ```
   grep -rLE '^reviewer:[[:space:]]*\S' <learnings>/
   ```
3. Load context for dedup / conflict / promotion checks: the other learnings, `rules/`, and `precedents/` (for each, start from its `index.md`, then open the files that bear on the learnings at hand; also read any file the index doesn't list).
4. For each learning: apply the rubric, pick an outcome, act (revise the file, and/or write a proposal), then set its `reviewer`.
5. Before writing a proposal, check `proposals/` for an existing one on the same subject — do not raise a duplicate.
6. End with a short report: revised N, proposed M (with file + action + one-line reason each), left K as-is.

A run only touches empty-`reviewer` learnings, so re-running skips everything already judged and processes only what is new.

## Proposal file

- Location: `<proposals>/`
- Filename: `<slug>.md` — a short kebab-case label of the proposed action (e.g. `promote-aca-sidecar-constraint`, `resolve-conflict-retry-policy`). No date prefix.
- Frontmatter (MVP): `author` (your judge identity), `created`.
- Body: which learning(s) it concerns (paths), the recommended action (promote-to-precedent / promote-to-rule / resolve-conflict-with `<higher entry>` / review-for-removal), and a one-paragraph rationale — enough for a human to decide fast.
- For **promote-to-precedent** or **promote-to-rule**, also include the proposed target file (`precedents/<slug>.md`, or `rules/<topic>.md` — an existing topic file to extend, or a new one) and, for a new file, the row to add to that folder's `index.md`, ready to paste:
  ```
  | <slug>.md | <when to read it> |
  ```

The human may pick up a proposal and promote it to a higher layer, or ignore it. When promoting, the human adds the file and its row in that folder's `index.md` together. If ignored, the underlying learning remains valid; the proposal just sits in the queue.

## Don't

- Don't write `precedents/` or `rules/` — those come from a human acting on a proposal.
- Don't touch `retro/` — retros are diaries and are never reviewed.
- Don't block, gate, or mark a learning unusable — every learning is valid as captured.
- Don't hard-delete a learning — if it should go, raise a review-for-removal proposal and let the human decide.
- Don't raise a proposal for something you can safely revise yourself, and don't raise duplicate proposals.
- Don't change `author` or `created`.
