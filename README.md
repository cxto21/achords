# Achords — Organization Base

**Agent Chords** — Initialize your GitHub organization for multi-agent collaboration.

## What It Does

Sets up the foundation for multi-agent development in your GitHub organization.

## Quick Start

```bash
# Clone
git clone https://github.com/cxto21/achords.git
cd achords

# Configure
cp .env.example .env

# Bootstrap organization
bash bootstrap.sh YourOrg
```

## What It Creates

```
your-org/
├── .github/          # Organization profile (public)
├── .internal/        # Team docs, onboarding
└── .skills/          # Shared skills library
```

## Features

- Multi-org support via `.env`
- Pre-checks for conflicts
- Team onboarding with `org-join`
- `.engram` integration for shared memory

## Products

| Product | Branch | Status |
|---------|--------|--------|
| **Organization Base** | `main` | ✅ Stable |
| **Repository Coordination** | `feat/repository-coordination` | 🚧 In Development |
| **IA on CI** | TBD | 📋 Planned |
| **KB Web** | `main` (Poincare-Space/kb-web) | 🚧 In Development |

## Documentation

| Document | Purpose |
|----------|---------|
| [Architecture](./docs/architecture.md) | Three-level design |
| [Getting Started](./docs/getting-started.md) | Set up your org |
| [Roadmap](./docs/roadmap.md) | Status and plans |

## License

MIT
