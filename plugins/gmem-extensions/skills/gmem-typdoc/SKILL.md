---
name: gmem-typdoc
description: Sets up typdoc on gmem memory, so each .gmem/ folder becomes a typdoc project whose frontmatter is checked against schemas and whose body links are tracked. Ships the schemas for learnings, retros, proposals, notes and the free-form kinds. Use when the user wants typdoc for gmem, asks to "set up typdoc", or when gmem-setup asks whether to use typdoc and the user says yes. Run gmem-check afterwards to see the findings. Not for fixing what typdoc reports — use gmem-tidy or gmem-migrate.
---

# gmem-typdoc

Turn every `.gmem/` folder that gmem uses into a typdoc project, so
`typdoc validate` can check frontmatter and links. This skill only sets typdoc up and
reports. It never edits a memory file.

typdoc treats a folder of Markdown files as typed documents. This skill was written for
typdoc 0.7.0. Source and docs: https://github.com/thaitype/typdoc

## 1. Check typdoc and its skill

typdoc has two parts to install: the `typdoc` command, and the `typdoc` skill that
teaches the agent its commands. Check both.

**The command.**

```
typdoc --version
```

- If it is not found, try `~/.local/bin/typdoc --version`; the installer puts it there
  and never edits `PATH`.
- If it is not installed, say so and show the install command for macOS or Linux. Run
  it only if the user agrees, because it downloads and runs a script:
  ```
  curl -fsSL https://typdoc.thaitype.dev/install | TYPDOC_VERSION=v0.7.0 sh
  ```
- On Windows, or for any other install method, point the user to
  https://github.com/thaitype/typdoc and follow the instructions there. Don't guess a
  command.
- If the version is not 0.7.0, tell the user, and trust `typdoc <command> --help` over
  this skill where they disagree.

**The skill.** Check whether a skill named `typdoc` is among the skills available in
this session. If it is, read it before going further. If it is missing, show the command
and run it only if the user agrees:

```
npx skills@latest add thaitype/typdoc
```

A newly installed skill may only show up in a new session. This skill still works
without it; the `typdoc` skill only helps when you read typdoc's findings or use typdoc
for anything beyond `validate`.

## 2. Find the .gmem/ folders

Resolve the gmem config, using the rules in `gmem-setup`. Group the seven kinds by the
`.gmem/` folder they resolve into, which is `<location.<kind>>/<memory_dir>/`. With the
recommended setup there are two:

```
<project>/.gmem/   memory, note
~/.gmem/           rules, precedents, learnings, proposals, retro
```

Each of those folders becomes one typdoc project. A kind with a custom location adds
its own folder.

## 3. Write the typdoc project

In each `.gmem/` folder, create `.typdoc/` with a config, the schemas, and one collection
per kind that lives in that folder:

```
.gmem/.typdoc/
├── config.json
├── schemas/        copied from this skill's schemas/ folder
└── collections/    one file per kind in this folder
```

`config.json`:

```json
{ "version": 1 }
```

Copy `schemas/learning.json`, `retro.json`, `proposal.json`, `note.json` and `free.json`
from this skill's folder into `.typdoc/schemas/`.

Copy into `.typdoc/collections/` the files from this skill's `collections/` folder, one
per kind, but **only for the kinds that live in this `.gmem/` folder**. Each file is
named after its kind (`memory.json`, `note.json`, `rules.json`, and so on), and its
`match` is relative to the `.gmem/` folder.

The files in `schemas/` and `collections/` are the source of truth. Read them there;
don't restate them.

The required fields in these base schemas must match the `fm.*` rows in `gmem-check`,
which checks format when typdoc is not set up. If you change one, change the other in
the same commit.

Before writing:

- If `.typdoc/` already exists in a folder, show what is there and what would change,
  and ask before overwriting any file.
- Create the `.gmem/` folder only if it is missing and the user agrees.

## 4. Validate and report

Run typdoc against each folder. The `.gmem/` folder is the typdoc project, so point at it
with `TYPDOC_DIR`:

```
TYPDOC_DIR=<project>/.gmem typdoc validate --json
TYPDOC_DIR=~/.gmem typdoc validate --json
```

Exit 0 means no errors, exit 2 means at least one error. Report the findings grouped by
folder and rule, and name the skill that fixes each kind of finding: a missing or wrong
field usually comes from a hand edit (fix with `gmem-tidy`), and an old layout from
before this version (fix with `gmem-migrate`). Do not fix anything here.

From now on, `gmem-check` uses typdoc for these folders.

## Custom fields

The schemas this skill ships are a base: they hold only the fields the gmem skills
write. You can add your own fields to any kind, for example `tags` on learnings or
`owner` on notes, so typdoc checks them too.

- Edit the copy in that folder's `.gmem/.typdoc/schemas/`, not the file in this skill.
  The copy is yours; this skill's `schemas/` stays the base for new setups.
- Use the `typdoc` skill to write the change. It covers the field types (`string`,
  `enum`, `date`, `list`, `ref`, and more), `required`, `default`, and `extends`. If it
  is not installed: `npx skills@latest add thaitype/typdoc`.
- Run `typdoc validate` on that folder afterwards, so existing files that lack a new
  required field show up.
- The gmem skills don't know about a custom field. They won't fill it when they write a
  file, so make a new field optional, or give it a `default`, unless you will fill it
  yourself.
- `gmem-check` checks custom fields only through typdoc. Its own fallback check knows
  only the base fields.

When you run this skill again on a folder that already has `.typdoc/`, it shows what
would change and asks before overwriting. Keep your customized schemas when it asks.

## Don't

- Don't edit, move or delete a memory file. This skill writes only inside `.typdoc/`.
- Don't install typdoc without the user's yes.
- Don't add fields to this skill's own `schemas/` that no gmem skill writes; custom
  fields go in the user's copy (see Custom fields). If a gmem skill starts writing a new
  field, update its schema here in the same change.
- Don't use `typdoc set`, `new` or `mv` on memory files from this skill.
