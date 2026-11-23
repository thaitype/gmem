---
name: gmem-ask
description: Explains gmem — why it exists, every kind of memory, the memory lifecycle, which skill to use when, and the four install modes. Use when the user asks "what is gmem", "how does gmem work", "which gmem skill should I use", "what is the difference between learn / memory / retro / note", "explain gmem memory types", "explain the install modes", or when gmem-setup calls it for a user who does not know gmem yet. Read-only — it explains and points to the skills that write; it changes nothing.
---

# gmem-ask

The explainer for the whole garden. Answer what the user asked first. If they asked for
the whole pattern, or `gmem-setup` called you, walk through the sections in order and keep
each one short. Do not write or move any file from here.

## The idea

What reaches an agent's context shapes how the agent behaves. So gmem puts a human in
charge of that context.

- **Recorder** — most agent memory saves everything automatically and finds it again by
  semantic search. You can't see what was kept or why one memory came back.
- **Garden** — gmem. Memory is plain Markdown in a folder you own. The agent writes much of
  it, but only through a gmem skill that tests what it saves. The agent finds files by
  index rows, not by similarity. You decide what stays and you prune the rest.

Some beds are fenced: `rules/` and `precedents/` change only when a human decides.

## Every kind of memory

| Kind | Holds | Who writes it |
|---|---|---|
| `memory` | Current understanding, revised in place. A dated ledger, plus `active/` with `correction/` (mistakes and what to do instead) and `reference/` (how things work). | You tell the agent (`gmem-memory`); you tell the agent it got something wrong (`gmem-stop`, manual only) |
| `note` | A status board for one piece of work: done, open, next. | The agent, on your request or at wrap-up (`gmem-note`) |
| `rules` | What must never be broken. | A human only |
| `precedents` | Decisions to follow unless there is a stated reason not to. | A human only |
| `learnings` | One durable fact per file, learned from the work itself. | The agent (`gmem-learn`) |
| `proposals` | Suggestions to fix, split, merge, promote or remove a learning. | The agent (`gmem-judge`); a human acts on them |
| `retro` | The diary of a session: what happened, decisions, dead ends, open threads. | The agent (`gmem-retro`) |

**Learning or retro?** Ask: "will this still matter after this work is done?" Yes — it is a
learning, a fact true for anyone. No — it is retro material, a story for tomorrow-you.

**Who wins on conflict:** `rules` > `precedents` > `active` > `learnings`. Notes and retros are
context, not authority.

## The lifecycle

| Stage | What happens | Skills |
|---|---|---|
| Capture | Something worth keeping enters memory | `gmem-memory`, `gmem-learn`, `gmem-stop`, `gmem-note`, `gmem-retro`; `gmem-bye` at the end of a session |
| Use | The agent reads memory before it works, in a fixed order | `gmem-recall`, with `gmem-map` as the guide |
| Review | New learnings are sorted | `gmem-judge` |
| Promote | A human turns a proposal into a precedent or a rule | none; you edit the files and the index |
| Prune | Memory is checked and cleaned against the real code | `gmem-check`, `gmem-tidy` |
| Retire | Stale memory is edited or deleted; finished notes are set to `done` | `gmem-memory`, `gmem-note` |

## Which skill? The look-alikes

**Writing something down**

| If this is true | Use |
|---|---|
| You are telling the agent how something works, or updating what it knows about a topic | `gmem-memory` |
| The agent found out a durable fact from its own work | `gmem-learn` |
| You want to log what happened in a session | `gmem-retro` |
| You want the next session to know where a piece of work stands | `gmem-note` |
| The agent got something wrong and you want it recorded | `gmem-stop` (manual: run `/gmem-stop`) |
| You are done for now and want one checkpoint over all of the above | `gmem-bye` |

**Looking after it**

| If you want to | Use |
|---|---|
| Sort the new learnings and get proposals for the good ones | `gmem-judge` |
| Audit all memory against the real code and fix it with you | `gmem-tidy` |
| Check the format and layout, changing nothing | `gmem-check` (run it before you commit memory) |

**Reading and orienting**

| If you want to | Use |
|---|---|
| Know what memory says about the task in front of you | `gmem-recall` |
| See the whole garden and the everyday rhythm | `gmem-map` |
| Choose where each kind is stored | `gmem-setup` |

## The four install modes

Every mode is a preset of where the seven kinds live. `${USER}` is your home directory,
`${PROJECT}` is the project root.

| # | Mode | `memory` | `note` | `rules` | `precedents` | `learnings` | `proposals` | `retro` |
|---|---|---|---|---|---|---|---|---|
| 1 | **Central memory** (default) | `${USER}` | `${USER}` | `${USER}` | `${USER}` | `${USER}` | `${USER}` | `${USER}` |
| 2 | **Home Repo Pattern memory** | `${PROJECT}` | `${PROJECT}` | `${PROJECT}` | `${PROJECT}` | `${PROJECT}` | `${PROJECT}` | `${PROJECT}` |
| 3 | **Dedicated agents memory** | `${PROJECT}` | `${PROJECT}` | `${USER}` | `${USER}` | `${USER}` | `${USER}` | `${USER}` |
| 4 | **Custom** | your choice per kind | | | | | | |

| Mode | Fits | Trade-off | Config file |
|---|---|---|---|
| Central memory | Newcomers, and anyone who wants everything in one place in their home directory | One shared `active/` and note pool for every project, so context from different projects can mix. Nothing is in a project's git history. | User level (recommended) |
| Home Repo Pattern memory | One home repo on your own machine that points at many code repos | Everything travels with the repo in git and is easy to share. It only suits work run from that one home. | Project level (recommended) |
| Dedicated agents memory | Each agent or project home keeps its own context and status, while what is learned and decided is shared at user level | Context stays separate per home, and learnings are shared. Learnings from different homes land in one pool. | User level (recommended) |
| Custom | You want a split none of the presets give | You choose each kind, so you also own the consequences. | No recommendation |

Examples live in [examples/](https://github.com/thaitype/gmem/tree/main/examples). The
[home repo](https://github.com/thaitype/gmem/tree/main/examples/home-repo) matches mode 2 (based on
https://www.aihero.dev/the-home-repo-pattern). The
[dedicated agents](https://github.com/thaitype/gmem/tree/main/examples/dedicated-agents) example matches
mode 3: each agent home keeps its own `memory` and `note`, and `rules`, `precedents`, `learnings`,
`proposals` and `retro` live in `~/.gmem`.

## Where to go next

Offer to run `gmem-setup` to pick a mode and write the config. If `gmem-setup` called you,
hand back to it now and let it continue with its next question.
