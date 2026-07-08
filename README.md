# Achords

**Agent Chords** — A lightweight protocol for multi-agent software collaboration.

## What It Does

When multiple AI agents work on the same codebase, you need coordination. Achords provides the infrastructure for that.

## Products

| Product | What It Does | Status |
|---------|--------------|--------|
| **Organization Base** | Initializes an organization with resources for agent development | ✅ Stable |
| **Repository Coordination** | Manages coordination between agents on the same repo | 🚧 In Development |
| **IA on CI** | AI-powered review for repository integration | 📋 Planned |
| **KB Web** | Obsidian-compatible web for docs, history, and memories | 📋 Planned |

## Organization Base

Set up your GitHub organization for multi-agent collaboration.

```bash
bash bootstrap.sh YourOrg
```

Creates:
- `.github/` — Organization profile
- `.internal/` — Team docs, onboarding
- `.skills/` — Shared skills library

## Repository Coordination

**Coming soon**: Manage agent coordination within a repository.

- Claim declaration
- Collision detection
- CI validation

## IA on CI

**Coming soon**: AI-powered review for repository integration.

- PR review automation
- Code quality checks
- Protocol compliance

## KB Web

**Coming soon**: Obsidian-compatible web interface.

- Documentation viewer
- Repository history
- Memory browser

## Quick Start

```bash
# Clone
git clone https://github.com/your-org/achords.git
cd achords

# Configure
cp .env.example .env

# Bootstrap organization
bash bootstrap.sh YourOrg
```

## Documentation

| Document | Purpose |
|----------|---------|
| [Protocol](./docs/protocol.md) | What Achords is |
| [Architecture](./docs/architecture.md) | Three-level design |
| [Collaboration](./docs/collaboration.md) | Async/sync modes |
| [Getting Started](./docs/getting-started.md) | Set up your project |
| [Roadmap](./docs/roadmap.md) | Status and plans |

## License

MIT
