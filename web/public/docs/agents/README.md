# Agent Integration Guide

> How AI agents integrate with achords organization.

## Quick Start

When you start in a repository with `.achords/`:

```bash
# 1. Check for org rules
ls -la .achords/AGENTS.md

# 2. Load org knowledge
mem_search(project: "achords-org", query: "conventions", limit: 5)

# 3. Check repo config
cat .engram/config.json
```

## Reading Order

Always read in this order:

1. `.achords/AGENTS.md` — Org-wide rules
2. `.achords/config/conventions.json` — Code conventions
3. `.achords/config/policies.json` — Org policies
4. `.engram/config.json` — Repo context
5. `AGENTS.md` — Repo-specific rules

## Memory Protocol

### At Session Start

```bash
git submodule update --remote .achords
mem_search(project: "achords-org", query: "últimos cambios", limit: 3)
```

### During Work

Save after significant decisions:

```bash
# Org-wide pattern
mem_save(
  project: "achords-org",
  title: "Decision: use pattern X",
  type: "decision",
  content: "We decided to use X because...",
  topic_key: "decisions/architecture"
)

# Repo-specific
mem_save(
  project: "REPO_NAME",
  title: "Fixed bug in auth",
  type: "bugfix",
  content: "The issue was..."
)
```

### At Session End

```bash
mem_session_summary(content: "## Goal\n...## Accomplished\n...")
```

## SDD Integration

When running SDD phases:

1. Update `.achords` submodule before `sdd-apply` or `sdd-verify`
2. Check skill versions in `.achords/skills/`
3. If you modified a skill, commit new version
4. Sync with `engram sync`

## Modification Rules

- **Don't modify** `.achords/` directly
- **Don't modify** other repos' `.engram/config.json`
- **Do modify** current repo files
- **Do create** shared skills in `.achords/skills/`

## Skills

Load skills when task matches description:

```bash
cat .skills/skills/testing/SKILL.md
```

Skills follow [Agent Skills spec](https://agentskills.io/specification):

```yaml
---
name: skill-name
description: Use when...
metadata:
  version: "1.0.0"
---
```

## Version Management

```bash
achords version   # Check current version
achords update    # Update to latest
```

## Conflict Resolution

When memory conflicts are detected:

1. Review conflicting observations
2. Decide which is current
3. Call `mem_judge` with appropriate relation:
   - `supersedes` — new replaces old
   - `conflicts_with` — they disagree
   - `compatible` — both apply
   - `related` — different scopes
   - `not_conflict` — false positive
