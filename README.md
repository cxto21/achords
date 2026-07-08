# Achords

**Agent Chords** — A lightweight protocol for multi-agent software collaboration.

## What It Does

When multiple AI agents work on the same codebase, you need coordination. Achords provides:

- **Claims** — Agents declare intent before editing
- **Collision detection** — CI blocks conflicting changes
- **Audit trail** — Every action is logged
- **Repo-native** — All state lives in Git

## Quick Start

```bash
# Clone
git clone https://github.com/your-org/achords.git
cd achords

# Configure
cp .env.example .env

# Setup
bash scripts/dev-setup.sh
```

## Structure

```
achords/
├── docs/              # Documentation
│   ├── protocol.md    # What Achords is
│   ├── architecture.md # Three-level design
│   ├── collaboration.md # Async/sync modes
│   └── roadmap.md     # Status and plans
├── templates/         # Files copied to projects
│   ├── skills/        # Protocol skills
│   ├── schemas/       # JSON schemas
│   └── workflows/     # CI workflows
├── protocol/          # Specification
├── scripts/           # Setup scripts
└── .env.example       # Configuration template
```

## Documentation

| Document | Purpose |
|----------|---------|
| [Protocol](./docs/protocol.md) | What Achords is and why |
| [Architecture](./docs/architecture.md) | Three-level design |
| [Collaboration](./docs/collaboration.md) | Async, sync, repo modes |
| [Getting Started](./docs/getting-started.md) | Set up your project |
| [Roadmap](./docs/roadmap.md) | What's ready, what's coming |

## Status

See [Roadmap](./docs/roadmap.md) for current status.

**Ready**: Platform setup, documentation  
**In Progress**: Org bootstrap refinement  
**Planned**: Repository-level skills, claims, CI

## License

MIT
