# Topic Keys

Organizing memory by topic.

## What are topic keys?

Topic keys group related memories. They enable:

- Upserting (updating same topic)
- Scoped search
- Organized retrieval

## Format

```
{category}/{topic}
```

Examples:

- `architecture/auth-model`
- `bugfix/n-plus-one-query`
- `config/engram-setup`

## Usage

### Save with topic

```json
{
  "title": "JWT auth middleware",
  "topic_key": "architecture/auth-model",
  "type": "architecture",
  "content": { ... }
}
```

### Update same topic

Same `topic_key` + same project = upsert (updates existing).

### Search by topic

```
mem_search(query: "architecture/auth-model")
```

## Best practices

- Use lowercase kebab-case
- Start with category
- Keep consistent within project
- Don't overwrite different topics

## See also

- [Memory Protocol](protocol.md)
- [Engram Integration](engram.md)
