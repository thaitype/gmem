---
name: typmem-note
description: Write or update a short status note for the current project/topic in this crew's own home, so a different crew or a fresh session can pick up quickly without re-explaining. Answers "what's true right now" — a different question than typmem-retro's "what happened / what did I learn". On-demand only. Use when the user asks to save/record the current status, or says something like "note this down for next time", "leave a status note", or "typmem-note".
---

# typmem-note

A short, current-state record of a project/topic, written into the crew's own home so
whoever opens it next — a different crew, or this same crew in a future session — can
pick up without asking "where did we leave off?"

`typmem-retro` and this skill answer different questions. Retro asks "what happened /
what did I learn from this work" — reflective, has a timeline, decisions, dead ends.
This skill asks "what's true right now" — a status board, no narrative, no "I did X then
Y". If what you're about to write is reflecting on how the work went, that's
`typmem-retro`'s job, not this one.

This skill only writes. If you need to read a note back, just open the file — there's no
list/summarize function here.

## Location and filename

Resolve the typmem config first, using the rules in `typmem-setup`. This skill uses the
`location.note` key.

- Directory: `<location.note>/<memory_dir>/note/`, called `<note>` below. With the
  defaults that is `<project>/.typmem/note/`. If there is no config, use the defaults and
  carry on; mention once that `typmem-setup` can change where notes are kept.
- Filename: `YYYY-MM-DD_HHMM_<topic>.md` — the timestamp is from when the note was
  **first created** for this topic. It does not change on later updates.

## Step 1: Find out if a note already exists for this topic

Look in `<note>/` for an existing file whose `<topic>` matches what you're about to
write about (same topic, not necessarily an exact string match — use judgment, e.g.
`az-data-volume` and `az-data-volume-cli` are the same topic).

- **Found one** → go to Step 2 (update it).
- **None found** → go to Step 3 (create a new one).

## Step 2: Update an existing note (surgical edit)

Read the existing file first. Then edit **only the parts that actually changed** —
update the `status` frontmatter if it changed, update the sections describing current
state and next steps, and leave anything still accurate untouched (e.g. a "how this
project is set up" section that hasn't changed doesn't need to be rewritten).

Do not blindly overwrite the whole file, and do not append a new dated section on top of
the old one — this is a status board, not a log. The file should always read as "here's
where things stand", not "here's the history of where things stood."

## Step 3: Create a new note

1. Resolve the current timestamp as `YYYY-MM-DD_HHMM`.
2. Make sure `<note>/` exists (`mkdir -p`).
3. Create `<note>/YYYY-MM-DD_HHMM_<topic>.md` with:
   ```md
   ---
   status: in-progress
   ---

   ## <freeform sections — see guideline below>
   ```

## Body guideline (loose — not a fixed template)

There's no required structure, but notes read better and are easier to surgically update
later if they roughly separate:

- **Context/setup** — how this project/task works, where things live, anything a
  newcomer would need once (tends to stay stable across updates)
- **Current status** — what's true right now, what's done, what's in flight
- **Next steps** — what to do if picking this back up

Adjust freely to what actually makes sense for the topic — this is guidance for keeping
notes updatable, not a form to fill in.

## Rules

- NEVER write a reflective narrative — if it reads like a story of how the work went,
  point the user at `typmem-retro` instead.
- NEVER create a second file for a topic that already has one — find and update the
  existing file (Step 1/2).
- NEVER do a full-file overwrite on update — edit only what changed (surgical edit).
- NEVER add automation, cron triggers, or a pointer in CLAUDE.md/AGENTS.md pointing at
  `<note>/` unless the user explicitly asks for it in that moment — this skill is
  on-demand only.
- `status` is one of: `in-progress`, `blocked`, `done`.
