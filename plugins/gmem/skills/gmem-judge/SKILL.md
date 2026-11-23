---
name: gmem-judge
description: >-
   Reviews the captured learnings and raises a proposal for each one that needs a change — a fix, a split, a merge, a promotion, a conflict, or a removal — and marks every learning it read as judged. It never changes a learning's content. Use when asked to "judge", "review the learnings", "triage learnings", "vet the inbox", or "clean up captured facts", or after many gmem-learn captures have piled up. Not for writing rules or precedents (a human acts on proposals), not for retros, and not for a full memory audit — use gmem-tidy.
---

# gmem-judge

Act as the AI judge over captured learnings. Your job is to find what in the `learnings/` set needs a change and to say so in a proposal — without ever blocking, and without changing a learning's content yourself. **Learnings are valid and usable the moment they are captured.** Nothing here gates them; a human acting (or never acting) on your proposals does not change that.

## Where this lives

Resolve the gmem config first, using the rules in `gmem-setup`. This skill writes
`<proposals>` and the `reviewer` field in `<learnings>`, and reads `<rules>` and `<precedents>`. Each is
`<location.<kind>>/<memory_dir>/<kind>/`. Only if no config file exists, use the
default: all four under `~/.gmem/<kind>/` (Central memory). Mention once
that `gmem-setup` can change where these are kept.

## Where this sits

```
retro/        diary — never reviewed
learnings/    valid immediately · you only set `reviewer`
proposals/    async queue you write to · human may act, or not
precedents/   created by a human acting on a proposal — not by you
rules/        created by a human acting on a proposal — not by you
```

You operate over `<learnings>/`. In a learning you change only the `reviewer` field; the body, the other frontmatter fields and the file name stay as they are, and you never rename, move, split, merge or delete a learning file. Everything else you write goes to `<proposals>/`. You never write `precedents/` or `rules/`, and you never touch `retro/`.

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

## Decide automatically — two outcomes

**1. Raise a proposal** (write to `proposals/`, non-blocking) — when the learning needs any change:
- **Revise** — strip an `I` / a timeline / status that slipped in, tighten vague wording, or fix a vague slug. Include the revised text (and the new slug, if any) ready to apply.
- **Split** — the file holds several facts. Include one draft file per fact (slug and body); no fact dropped.
- **Merge** — it is an exact / near-exact duplicate of another learning. Name both files and include the merged text.
- **Promote** — the fact is broad, recurring, or high-impact enough that it belongs in `precedents/` or `rules/`. (Keep the bar high — most learnings just stay learnings.)
- **Conflict** — it contradicts an existing precedent or rule. The higher layer wins for now; whether to update the higher layer is a human call.
- **Remove** — it looks like diary leakage with no clearly salvageable fact, or it is unclear in a way you cannot fix without losing or inventing information.

**2. Leave as-is** — a clean, valid, modest learning with no problems and no promotion case. Just mark it judged.

In every case the learning stays valid and usable. A proposal is advice, not a gate.

## How to run

1. Ensure dirs exist: `mkdir -p <proposals>`
2. Find unjudged learnings (empty `reviewer`):
   ```
   grep -rLE '^reviewer:[[:space:]]*\S' <learnings>/
   ```
3. Load context for dedup / conflict / promotion checks: the other learnings, `rules/`, and `precedents/` (for each, start from its `index.md`, then open the files that bear on the learnings at hand; also read any file the index doesn't list).
4. For each learning: apply the rubric, pick an outcome, write a proposal if it needs one, then set its `reviewer`. Do not edit anything else in the file.
5. Before writing a proposal, check `proposals/` for an existing one on the same subject — do not raise a duplicate.
6. End with a short report: proposed M (with file + action + one-line reason each), left K as-is.

A run only touches empty-`reviewer` learnings, so re-running skips everything already judged and processes only what is new.

## Proposal file

- Location: `<proposals>/`
- Filename: `<slug>.md` — a short kebab-case label of the proposed action (e.g. `split-storefront-npm-test`, `promote-aca-sidecar-constraint`, `resolve-conflict-retry-policy`). No date prefix.
- Frontmatter (MVP): `author` (your judge identity), `created`.
- Body: which learning(s) it concerns (paths), the recommended action (revise / split / merge / promote-to-precedent / promote-to-rule / resolve-conflict-with `<higher entry>` / review-for-removal), and a one-paragraph rationale — enough for a human to decide fast.
- For **promote-to-precedent** or **promote-to-rule**, also include the proposed target file (`precedents/<slug>.md`, or `rules/<topic>.md` — an existing topic file to extend, or a new one) and, for a new file, the row to add to that folder's `index.md`, ready to paste:
  ```
  | <slug>.md | <when to read it> |
  ```

The human may act on a proposal — apply a revise, split or merge to the learning, remove it, or promote it to a higher layer — or ignore it. When promoting, the human adds the file and its row in that folder's `index.md` together. If ignored, the underlying learning remains valid; the proposal just sits in the queue.

## Don't

- Don't write `precedents/` or `rules/` — those come from a human acting on a proposal.
- Don't touch `retro/` — retros are diaries and are never reviewed.
- Don't block, gate, or mark a learning unusable — every learning is valid as captured.
- Don't change a learning's content — no edits to its body or other frontmatter, no rename, move, split, merge or delete. Write a proposal; the only field you set is `reviewer`.
- Don't raise duplicate proposals.
