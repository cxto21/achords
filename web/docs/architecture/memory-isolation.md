# Memory Isolation

How memory is organized across orgs and repos.

## Two levels of memory

```
Org memory (shared)
└── .achords/.engram/
    └── All repos see this

Repo memory (isolated)
└── .engram/
    └── Only this repo sees this
```

## Org memory

Lives in `.achords/.engram/`. Shared across all repos in the org.

Contains:
- Org-wide conventions
- Architecture decisions
- Shared discoveries
- Cross-repo patterns

## Repo memory

Lives in `.engram/`. Specific to each repo.

Contains:
- Repo-specific bugs
- Local patterns
- Feature decisions
- Testing discoveries

## Memory protocol

Agents follow this protocol:

1. **Session start** — Call `mem_context` to recover
2. **During work** — Call `mem_save` after decisions/fixes
3. **Session end** — Call `mem_session_summary`

## See also

- [Engram Integration](../memory/engram.md)
- [Memory Protocol](../memory/protocol.md)
