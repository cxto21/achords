# Achords

**Agent Chords** — A lightweight protocol for multi-agent software collaboration.

## What It Does

When multiple AI agents work on the same codebase, you need coordination. Achords provides:

- **Claims** — Agents declare intent before editing
- **Collision detection** — CI blocks conflicting changes
- **Audit trail** — Every action is logged
- **Repo-native** — All state lives in Git

## Levels

| Level | Name | Status | Scope |
|-------|------|--------|-------|
| **Organization Base** | Foundation | ✅ Stable | GitHub org, team onboarding |
| **Repository Rules** | Coordination | 🚧 In Development | Claims, CI, protocol |
| **Agent** | TBD | 📋 Planned | Individual contribution |

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

## Organization Base (Stable)

Set up your GitHub organization for multi-agent collaboration.

```bash
bash bootstrap.sh YourOrg
```

Creates:
- `.github/` — Organization profile
- `.internal/` — Team docs, onboarding
- `.skills/` — Shared skills library

## Repository Rules (In Development)

Manage agent coordination within a repository.

**Coming soon:**
- Claim declaration
- Collision detection
- CI validation

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
