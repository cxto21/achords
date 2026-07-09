# Repo Integration

How repos import org rules via git submodules.

## Submodule setup

When you run `achords obase --repo my-app`, it:

1. Adds `.achords` as a submodule
2. Adds `.skills` as a submodule
3. Creates `.engram/` for repo memory
4. Creates `AGENTS.md` with agent instructions

## Resulting structure

```
my-app/
├── .achords → ../.achords/ (submodule)
├── .skills  → ../.skills/  (submodule)
├── .engram/                (repo memory)
├── AGENTS.md               (agent instructions)
├── src/
└── ...
```

## Updating org rules

When org rules change, repos pull updates:

```bash
cd ~/achords/my-company/my-app
git submodule update --remote .achords .skills
```

Or use `--update-headers` to update all repos:

```bash
achords obase --org my-company --update-headers
```

## AGENTS.md

Each repo gets an `AGENTS.md` with:

- Header with version marker
- Mandatory reads section
- Agent flow
- Memory protocol

Agents read this file at session start.

## See also

- [Organization Structure](org-structure.md)
- [Agent Flow](agent-flow.md)
