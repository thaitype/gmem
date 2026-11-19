# Acme home repo

This is the home repo for the Acme engineering agent. Work happens in the child
repositories under `workspace/`. This file tells you what exists and how to work in it.

## Child repositories

- **Storefront (Next.js app):** `workspace/storefront`. Clone from
  `git@github.com:acme/storefront.git` if missing. Read its `AGENTS.md` before changing it.
- **Payments API (Node service):** `workspace/payments-api`. Clone from
  `git@github.com:acme/payments-api.git` if missing. Read its `AGENTS.md` before changing it.
- **Infra (Terraform):** `workspace/infra`. Clone from `git@github.com:acme/infra.git`
  if missing. Read-only unless the task says otherwise.

## How to work

- Follow [docs/coding-standards.md](docs/coding-standards.md) in every repository.
- Use the terms in [docs/glossary.md](docs/glossary.md) in code, commits and replies.
- A change that spans repositories gets one note in `.gmem/note/`, so the next
  session sees the whole picture.
- Open a pull request per repository. Never push to `main`.
- For a release, use the `release-checklist` skill.

## Memory (gmem)

This project uses gmem. At the start of a session or before non-trivial work, open
`gmem-map` and follow it.
