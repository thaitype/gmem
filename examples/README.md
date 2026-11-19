# Examples

Two ways to lay out agents and memory with gmem. Everything here is fictional (a
made-up company, `acme`) and is docs, config and sample memory only.

- **[Home repo](home-repo/): one home, many repos.** One agent works from a home repo
  that points at several code repositories. One memory covers all of them. Based on
  [The Home Repo Pattern](https://www.aihero.dev/the-home-repo-pattern) on AI Hero.
- **[Dedicated agents](dedicated-agents/): one agent, one home.** Each agent has its own
  folder, identity and memory. Rules and precedents are shared.

| | Home repo | Dedicated agents |
|---|---|---|
| Who remembers what | One agent remembers the whole system | Each agent remembers what its role needs |
| Where memory lives | The home repo's `.gmem/` | Each agent's own `.gmem/`; rules and precedents in a shared folder |
| Rules and precedents | In `~/.gmem` by default | In `shared/`, set per agent in `gmem-config.toml` |
| Work across repos | Notes track a change that spans repos | A hand-off note names the owner |
| Where the agent works | Inside its home (repos are cloned into `workspace/`) | Outside its home, so it needs access beyond one project; run it under tight security controls |
| Main benefit | One place for instructions, skills and memory | Memory stays separate for each agent |
| Pick it when | You work across several repos and want one agent | You want separate roles, for example plan and build |

In both, the agent reads memory with `gmem-recall` and writes through the gmem skills.
See the [root README](../README.md) for how gmem works.
