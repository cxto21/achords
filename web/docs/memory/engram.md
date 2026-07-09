# Engram Integration

Persistent memory across sessions via [Engram](https://github.com/Gentleman-Programming/engram).

## What is Engram?

Engram is a Go-based memory system with:

- SQLite + FTS5 for fast search
- MCP server for agent integration
- HTTP API for programmatic access
- CLI and TUI for management

## Setup

Engram is automatically configured when you run `achords obase`.

### Per org

```
.achords/.engram/    # Shared org memory
```

### Per repo

```
.engram/             # Repo-specific memory
```

## Configuration

`.engram/config.json`:

```json
{
  "project": "my-app",
  "memory_backend": "sqlite",
  "auto_save": true
}
```

## Key APIs

| API | Purpose |
|-----|---------|
| `mem_save` | Save a memory |
| `mem_search` | Search memories |
| `mem_context` | Get recent context |
| `mem_session_summary` | End-of-session summary |

## See also

- [Memory Protocol](protocol.md)
- [Topic Keys](topic-keys.md)
