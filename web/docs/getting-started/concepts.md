# Concepts

Core mental model for Achords.

## Organizations

An organization is the top-level container. It holds:

- Agent rules (`.achords/`)
- Skills (`.skills/`)
- Developer onboarding (`.internal/`)
- GitHub profile (`.github/`)

Each org gets its own subdirectory: `~/achords/{org-name}/`

## Repos

Repos are individual projects. They import org rules via git submodules:

```
my-repo/
├── .achords/ → ../.achords/ (submodule)
├── .skills/  → ../.skills/  (submodule)
├── .engram/  (repo-specific memory)
└── AGENTS.md (agent instructions)
```

## Skills

Skills are reusable capabilities for agents. They follow the [Agent Skills spec](https://agentskills.io/specification).

Each skill has:
- `SKILL.md` — Instructions and resources
- `scripts/` — Executable helpers
- `references/` — Static data

Skills are versioned by directory:

```
.skills/
└── skills/
    └── testing/
        ├── v1.0.0/
        │   └── SKILL.md
        └── v1.1.0/
            └── SKILL.md
```

## Memory

Memory is managed by [Engram](https://github.com/Gentleman-Programming/engram). It provides:

- **Org memory** — Shared across all repos (`.achords/.engram/`)
- **Repo memory** — Specific to each repo (`.engram/`)

Memory survives across sessions. Agents can search, save, and update context.

## Agent Flow

Every agent session follows this flow:

```
Session start
    ↓
Read .achords/AGENTS.md (mandatory)
    ↓
Read .skills/AGENTS.md (mandatory)
    ↓
Sync memory (mem_context)
    ↓
Work (read on-demand as needed)
    ↓
Session end (mem_session_summary)
```

## See also

- [Organization Structure](../architecture/org-structure.md)
- [Memory Isolation](../architecture/memory-isolation.md)
- [Skill Specification](../skills/specification.md)
