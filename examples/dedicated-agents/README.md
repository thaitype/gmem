# Dedicated agents: one agent, one home

This folder stands for your home directory `~`. The `.gmem/` folder here is
`~/.gmem`, and each agent's home is a folder inside it: `~/team-leader` and `~/builder`.

This example is the **Dedicated agents memory** install mode (mode 3) of
[`gmem-setup`](../../plugins/gmem/skills/gmem-setup/SKILL.md). Each agent has its own
identity (`AGENTS.md`, `SOUL.md`) and its own context and status. What is learned and
decided is kept in one place, `~/.gmem`, for all of them.

In this example Acme has two agents:

- [`team-leader`](team-leader/): takes work, assigns it, reviews what comes back. It
  remembers priorities and decisions.
- [`builder`](builder/): writes code and tests. It remembers technical gotchas.

## Memory split

```
~/.gmem/                              config, and what is learned and decided
  gmem-config.toml                    the mode 3 preset
  rules/            decided by a human, read by every agent
  precedents/       decided by a human, read by every agent
  learnings/ proposals/ retro/        written by every agent (created on first save)

~/team-leader/.gmem/                  ~/builder/.gmem/
  memory/  priorities, decisions        memory/  technical gotchas
  note/    assignments                  note/    status of owned work
```

The config is [`.gmem/gmem-config.toml`](.gmem/gmem-config.toml), at user level, so every
agent home uses it. It keeps `memory` and `note` in the agent's own home (`${PROJECT}`)
and the other five kinds in `~/.gmem` (`${USER}`). gmem reads
`rules > precedents > active memory > learnings`, so a rule beats anything an agent
remembers.

Only humans edit `rules/` and `precedents/`. Agents read them through `gmem-recall`.

## Compared with the home repo

| | [Home repo](../home-repo/) | Dedicated agents |
|---|---|---|
| Install mode | Home Repo Pattern memory (mode 2) | Dedicated agents memory (mode 3) |
| Agents | One | Several, each with a role |
| Identity | One `AGENTS.md` | One `AGENTS.md` and `SOUL.md` per agent |
| Memory and notes | One, shared across repos | One per agent |
| Rules, precedents, learnings, proposals, retro | In the home repo | In `~/.gmem`, shared by all agents |
| Config location | Project level | User level (`~/.gmem/gmem-config.toml`) |
| Hand-off | Not needed | Through notes that name an owner |

## When to use it

- You want agents with separate roles, such as one that plans and one that builds.
- You want each agent to remember only what its role needs, so its memory stays small.
- You want the human-decided rules to stay identical for every agent.

## Trade-offs

**Learnings, proposals and retro from every agent land in one pool in `~/.gmem`.** That
is fine for one person on their own machine. If you want per-agent learnings, use the
Custom mode and point those kinds at each agent's home.

**Agents work outside their home.** An agent's home holds its identity, context and
status, not the code. To do real work, the agent reads and writes outside its own home:
in the code repositories and in `~/.gmem`. Your tools then have to let it reach folders
outside the project it was opened in.

- **Cost:** the access is wider than one project, so run this pattern where security is
  tightly controlled. Sandbox the agents and allow each one only the paths its role
  needs. Every agent may read `~/.gmem` and write only `learnings/`, `proposals/` and
  `retro/` there. `builder` also gets the code repositories.
- **Benefit:** each agent's context stays separate. The builder's gotchas never mix with
  the team leader's decisions, and you can review, prune or reset one agent without
  touching the others.

If one agent is enough, use the home repo pattern. You can also combine them: each
dedicated agent can have child repos under its own `workspace/`.

## Hand-off

The team leader writes a note that names the owner, for example
[`team-leader/.gmem/note/2026-11-12_0930_eur-checkout.md`](team-leader/.gmem/note/2026-11-12_0930_eur-checkout.md).
The builder writes its own note for the work and references the team leader's note, as
in [`builder/.gmem/note/2026-11-13_1015_payment-intent-currency.md`](builder/.gmem/note/2026-11-13_1015_payment-intent-currency.md).
Each agent keeps its own note current. Neither edits the other's.

## Try it

1. Install the gmem plugin (see the [root README](../../README.md#install)).
2. Copy `team-leader` and `builder` into your home directory (or anywhere you like).
3. Copy `.gmem` to `~/.gmem`.

   **Warning:** if `~/.gmem` already exists, back it up or merge by hand. Never
   overwrite it, because it may hold your own memory and config.
4. Open Claude Code in `~/builder` and ask: "Run gmem-recall and list the files you
   read." It should list its own memory and the rule and precedent in `~/.gmem`.
