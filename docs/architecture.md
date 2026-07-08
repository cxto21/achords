# Architecture

Achords is an ecosystem of products for multi-agent collaboration.

## Products

```
┌─────────────────────────────────────────────────────────────┐
│  ORGANIZATION BASE                                          │
│  Status: ✅ Stable                                          │
│  What: Initializes organization with agent resources        │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  REPOSITORY COORDINATION                                    │
│  Status: 🚧 In Development                                 │
│  What: Manages agent coordination on same repo              │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  IA ON CI                                                   │
│  Status: 📋 Planned                                         │
│  What: AI-powered review for repository integration         │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  KB WEB                                                     │
│  Status: 📋 Planned                                         │
│  What: Obsidian-compatible web for docs and memories        │
└─────────────────────────────────────────────────────────────┘
```

## Organization Base

**Status**: ✅ Stable  
**Branch**: main  
**What**: Initializes a GitHub organization configured with resources for agent-assisted development.

| Skill | Purpose |
|-------|---------|
| `org-bootstrap` | Create org structure (repos, files) |
| `org-join` | Team member onboarding |

### What Gets Created

```
your-org/
├── .github/          # Public profile
├── .internal/        # Team docs, onboarding
└── .skills/          # Shared skills library
```

## Repository Coordination

**Status**: 🚧 In Development  
**Branch**: feat/repository-coordination  
**What**: Manages coordination between different agents working on the same repository.

| Skill | Purpose |
|-------|---------|
| `achords-init` | Bootstrap protocol in repo |
| `agent-union` | Register new agent |
| `claim-declaration` | Declare work intent |
| `claim-collision-check` | Detect overlapping claims |
| `alignment-verify` | CI compliance check |

### What Gets Created

```
your-repo/
├── .achords/
│   ├── registry.json       # Agent registry
│   ├── claims.json         # Active claims
│   ├── events.ndjson       # Audit log
│   └── schemas/            # JSON schemas
└── .github/workflows/
    └── achords-*.yml       # CI workflows
```

## IA on CI

**Status**: 📋 Planned  
**Branch**: TBD  
**What**: Manages AI-powered review processes for repository integration.

### Planned Features

- PR review automation
- Code quality checks
- Protocol compliance
- Merge gating

## KB Web

**Status**: 📋 Planned  
**Branch**: TBD  
**What**: Obsidian-compatible web interface for organization documentation, repository history, and memories.

### Planned Features

- Documentation viewer
- Repository history
- Memory browser
- Visual navigation

---

*Next: [Collaboration](./collaboration.md) — How async and sync coordination works.*
