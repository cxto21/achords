# Architecture

Achords operates across three levels. Each level has a distinct scope and set of operations.

```
┌─────────────────────────────────────────────────────────────┐
│  PLATFORM (Organization)                                    │
│  Scope: GitHub org, team onboarding                         │
│  Skills: org-bootstrap, org-join                            │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  REPOSITORY                                                 │
│  Scope: Single repo, claim management, CI                   │
│  Skills: achords-init, agent-union, claims, alignment       │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  AGENT                                                      │
│  Scope: Individual agent, contribution workflow             │
│  Operations: Register, claim, work, PR                      │
└─────────────────────────────────────────────────────────────┘
```

## Platform Level

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

## Repository Level

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
│   ├── schemas/            # JSON schemas
│   └── skills/             # Protocol skills
└── .github/workflows/
    ├── achords-union.yml
    └── achords-alignment-check.yml
```

## Agent Level

**Scope**: Individual agent  
**Owner**: The agent itself  
**Continuous**: Every contribution

### Workflow

```
1. Read AGENTS.md (mandatory)
        ↓
2. Register via agent-union
        ↓
3. Declare claim before editing
        ↓
4. Make changes
        ↓
5. Open PR
        ↓
6. CI validates → merge or block
```

## Data Flow

```
Platform setup
    ↓
Repository initialization
    ↓
Agent registration
    ↓
Claim declaration
    ↓
Code changes
    ↓
PR + CI validation
    ↓
Merge + event logged
```

---

*Next: [Collaboration](./collaboration.md) — How async and sync coordination works.*
