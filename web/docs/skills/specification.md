# Skill Specification

Skills follow the [Agent Skills spec](https://agentskills.io/specification).

## SKILL.md structure

```yaml
---
name: my-skill
description: What this skill does
triggers:
  - when to use this skill
---

# Skill Name

## Instructions

Step-by-step guide for the agent.

## Resources

- [Link](url) — Description
```

## Required fields

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Unique identifier |
| `description` | string | What the skill does |

## Optional fields

| Field | Type | Description |
|-------|------|-------------|
| `triggers` | list | When to use this skill |
| `scope` | string | File patterns that trigger this skill |
| `os` | object | Platform requirements |

## Directory structure

```
skills/
└── {skill-name}/
    ├── manifest.json     # Version metadata
    └── versions/
        └── v{version}/
            ├── SKILL.md   # Instructions
            ├── scripts/   # Helpers
            └── references/ # Data
```

## See also

- [Versioning](versioning.md)
- [OS Tagging](os-tagging.md)
- [Creating Skills](creating.md)
