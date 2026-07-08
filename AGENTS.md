# AGENTS.md — Achords Project

## Project Status

**⚠️ EVERYTHING IS IN DEVELOPMENT.** No product is production-ready. This is an experimental protocol.

## What is Achords

A multi-agent orchestration protocol for software development. Four products:

| Product | Status | Description |
|---------|--------|-------------|
| Organization Base (obase) | 🟡 Alpha | GitHub org-level resource management |
| Repository Coordination (rcord) | 🔴 Planning | Multi-agent repo coordination |
| IA on CI (iaci) | 🔴 Planning | AI code review in CI/CD |
| KB Web (kbweb) | 🔴 Planning | Living documentation |

## Architecture

- **Unified CLI**: `bin/achords` with product subcommands
- **Shared Memory**: `.engram` submodule for cross-session context
- **Skills**: Product-specific instructions in `.skills/` repos
- **Landing Page**: Vite + Tailwind in `web/`

## Conventions

- **Language**: Code comments and UI in English, user-facing docs in Spanish/English
- **Commits**: Conventional commits (`feat:`, `fix:`, `docs:`)
- **Branches**: `main` = Organization Base, `feat/*` = feature branches
- **CLI**: Bash scripts in `bin/commands/`

## Key Files

- `bin/achords` — Unified CLI entry point
- `bin/commands/obase.sh` — Organization Base subcommand
- `web/index.html` — Landing page
- `web/src/i18n.js` — Translations (ES/EN)
- `docs/obase.md` — Organization Base documentation
- `docs/roadmap.md` — Product status and roadmap
- `llms.txt` — AI/LLM-friendly project summary

## Testing

No automated tests yet. Manual testing via:
```bash
./bin/achords obase --help
./bin/achords obase --check
```

## Contributing

1. Fork the repo
2. Create a feature branch
3. Make changes
4. Submit a PR

**Remember**: This is experimental. Break things, learn, iterate.
