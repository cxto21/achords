# Memory Protocol

When to save, search, and summarize.

## Session lifecycle

```
Session start
    ↓
mem_context (recover prior context)
    ↓
Work...
    ↓
mem_save (after decisions/fixes)
    ↓
mem_session_summary (before ending)
```

## When to save

Call `mem_save` immediately after:

- Architecture decision
- Bug fix
- Non-obvious discovery
- Configuration change
- Pattern established

## Format

```json
{
  "title": "Short searchable title",
  "type": "decision|bugfix|discovery|pattern|config",
  "content": {
    "What": "What was done",
    "Why": "What motivated it",
    "Where": "Files affected",
    "Learned": "Gotchas and edge cases"
  }
}
```

## When to search

- Before starting work (check if done before)
- When user references past work
- When you encounter a familiar pattern

## Search flow

1. `mem_context` — Recent session history
2. `mem_search` — Full-text search
3. `mem_get_observation` — Full content

## See also

- [Engram Integration](engram.md)
- [Topic Keys](topic-keys.md)
