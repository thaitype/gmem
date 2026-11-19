# Dedicated agents: one agent, one home

Each agent has its own home folder, its own identity (`AGENTS.md`, `SOUL.md`) and its
own gmem memory. What humans decide, the rules and precedents, is shared by all of them.

In this example Acme has two agents:

- [`team-leader`](team-leader/): takes work, assigns it, reviews what comes back. It
  remembers priorities and decisions.
- [`builder`](builder/): writes code and tests. It remembers technical gotchas.

## Compared with the home repo

| | [Home repo](../home-repo/) | Dedicated agents |
|---|---|---|
| Agents | One | Several, each with a role |
| Identity | One `AGENTS.md` | One `AGENTS.md` and `SOUL.md` per agent |
| Memory | One, shared across repos | One per agent, plus shared rules |
| Hand-off | Not needed | Through notes that name an owner |

## When to use it

- You want agents with separate roles, such as one that plans and one that builds.
- You want each agent to remember only what its role needs, so its memory stays small.
- You want the human-decided rules to stay identical for every agent.

## Trade-off: agents work outside their home

An agent's home holds its identity and memory, not the code. To do real work, the agent
reads and writes outside its own home: in the code repositories, and in `shared/`. Your
tools then have to let the agent reach folders outside the project it was opened in.

- **Cost:** the agent's access is wider than one project, so run this pattern where
  security is tightly controlled. Sandbox the agents, and allow each one only the paths
  its role needs. For example, `builder` gets the code repositories, and every agent gets
  `shared/` as read-only.
- **Benefit:** each agent's memory stays separate. The builder's gotchas never mix with
  the team leader's decisions, and you can review, prune or reset one agent without
  touching the others.

If one agent is enough, use the home repo pattern. You can also combine them: each
dedicated agent can have child repos under its own `workspace/`.

## Memory split

```
shared/.gmem/
  rules/            decided by a human, read by every agent
  precedents/       decided by a human, read by every agent

team-leader/.gmem/                    builder/.gmem/
  memory/  priorities, decisions        memory/  technical gotchas
  note/    assignments                  note/    status of owned work
  learnings/ proposals/ retro/          learnings/ proposals/ retro/
```

Each agent's [`gmem-config.toml`](builder/.gmem/gmem-config.toml) keeps `memory`,
`note`, `learnings`, `proposals` and `retro` in its own home with `${PROJECT}`, and
points `rules` and `precedents` at `../shared`. gmem reads `rules > precedents >
active memory > learnings`, so a shared rule beats anything an agent remembers.

## Sharing rules and precedents

`../shared` is a relative path, and gmem resolves a relative path against the project
root. The project root is the Git root, or the current directory if the folder is not a
Git repo. So this works when each agent home is its own Git repository (or plain
folder) and `shared` sits beside it:

```
agents/
  shared/           its own repo; rules and precedents live in shared/.gmem/
  team-leader/      its own repo
  builder/          its own repo
```

If your agent homes sit inside one larger Git repository, the project root is that
repository's root, and `../shared` points outside it. In that case set `rules` and
`precedents` to `${PROJECT}/agents/shared` (or another path built from the root), or
to `${USER}` to share through `~/.gmem` on one machine.

Only humans edit `shared/`. Agents read it through `gmem-recall` and never write to it.

## Hand-off

The team leader writes a note that names the owner, for example
[`team-leader/.gmem/note/2026-11-12_0930_eur-checkout.md`](team-leader/.gmem/note/2026-11-12_0930_eur-checkout.md).
The builder writes its own note for the work and references the team leader's note, as
in [`builder/.gmem/note/2026-11-13_1015_payment-intent-currency.md`](builder/.gmem/note/2026-11-13_1015_payment-intent-currency.md).
Each agent keeps its own note current. Neither edits the other's.

## Try it

1. Copy `shared`, `team-leader` and `builder` side by side, and run `git init` in each.
2. Install the gmem plugin (see the [root README](../../README.md#install)).
3. Open Claude Code in `builder/` and ask: "Run gmem-recall and list the files you
   read." It should list its own memory and the shared rule and precedent.
