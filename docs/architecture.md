# Architecture

Achords operates across three levels. Each level has a distinct scope and status.

```
┌─────────────────────────────────────────────────────────────┐
│  ORGANIZATION BASE                                          │
│  Status: ✅ Stable                                          │
│  Scope: GitHub org, team onboarding                         │
│  Skills: org-bootstrap, org-join                            │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  REPOSITORY RULES                                           │
│  Status: 🚧 In Development                                 │
│  Scope: Single repo, claim management, CI                   │
│  Skills: achords-init, agent-union, claims, alignment       │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  AGENT                                                      │
│  Status: 📋 Planned                                         │
│  Scope: Individual agent, contribution workflow             │
│  TBD: Name and scope still being defined                    │
└─────────────────────────────────────────────────────────────┘
```

## Organization Base

**Status**: ✅ Stable (main branch)  
**Scope**: GitHub organization  
**Owner**: Organization admin  
**One-time**: Set up once per org

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

## Repository Rules

**Status**: 🚧 In Development (feature branch)  
**Scope**: Single repository  
**Owner**: Repository maintainers  
**Per-repo**: Initialize once per repo

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
    ├── achords-union.yml
    └── achords-alignment-check.yml
```

## Agent

**Status**: 📋 Planned  
**Scope**: Individual agent  
**Owner**: The agent itself  
**Name**: TBD

### Planned Features

- Agent registration
- Claim lifecycle
- Inbox messaging
- State tracking

## Branch Strategy

```
main
├── Organization Base (stable)
└── Documentation

feat/repository-rules
└── Repository Rules (in development)
```

---

*Next: [Collaboration](./collaboration.md) — How async and sync coordination works.*
