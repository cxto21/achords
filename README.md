# 🎵 Achords

**Multi-agent collaboration protocol for software development.**

## Quick start

```bash
# Clone achords
git clone https://github.com/achords-org/achords.git
cd achords

# Set up your organization
./bin/achords obase --org YourOrg
```

## Products

| Product | Command | Description | Status |
|---------|---------|-------------|--------|
| [**Organization Base**](./docs/obase.md) | `achords obase` | Set up your GitHub org | ✅ Stable |
| **Repository Coordination** | — | Claim-based agent coordination | 🚧 In Development |
| **IA on CI** | — | AI-powered review | 📋 Planned |
| **KB Web** | — | Documentation web | 🚧 In Development |

## CLI Usage

```bash
# List available products
./bin/achords

# Show product help
./bin/achords obase --help

# Run product
./bin/achords obase --org MyOrg
```

## How it works

Achords provides three levels of coordination:

1. **Organization** — Set up your GitHub org for multi-agent work
2. **Repository** — Coordinate agents within a repo using claims
3. **Agent** — Register and declare work intent

## Documentation

| Document | Purpose |
|----------|---------|
| [Organization Base](./docs/obase.md) | Set up your org |
| [Architecture](./docs/architecture.md) | Three-level design |
| [Getting Started](./docs/getting-started.md) | Quick start guide |
| [Roadmap](./docs/roadmap.md) | Product status |

## License

MIT
