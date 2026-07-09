# Agent Flow

Every agent session follows this flow.

## Session lifecycle

```
┌─────────────────────────────────────────┐
│ 1. Session Start                        │
│    - Detect project from cwd            │
│    - Call mem_context                    │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│ 2. Mandatory Reads                      │
│    - Read .achords/AGENTS.md            │
│    - Read .skills/AGENTS.md             │
│    - Read .engram/config.json           │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│ 3. Memory Sync                          │
│    - Search for prior context           │
│    - Load relevant memories             │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│ 4. Work                                 │
│    - Read skills on-demand              │
│    - Make decisions                     │
│    - Save to memory                     │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│ 5. Session End                          │
│    - Call mem_session_summary           │
│    - Persist important context          │
└─────────────────────────────────────────┘
```

## Mandatory reads

These files MUST be read at session start:

| File | Purpose |
|------|---------|
| `.achords/AGENTS.md` | Org-wide rules |
| `.skills/AGENTS.md` | Skill documentation |
| `.engram/config.json` | Memory configuration |

## On-demand reads

These are read as needed during work:

| File | When |
|------|------|
| `conventions.json` | Before writing code |
| `policies.json` | Before policy decisions |
| Skill manifests | Before using a skill |
| Skill versions | Before executing a skill |

## Memory operations

| Operation | When |
|-----------|------|
| `mem_context` | Session start |
| `mem_search` | Looking for prior work |
| `mem_save` | After decisions/fixes |
| `mem_session_summary` | Session end |

## See also

- [Memory Protocol](../memory/protocol.md)
- [Repo Integration](repo-integration.md)
