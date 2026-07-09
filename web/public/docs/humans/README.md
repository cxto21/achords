# Developer Guide

> How to set up and use achords for your team.

## What is Achords?

Achords is an orchestration protocol for multi-agent software development. It lets AI agents (OpenCode, Claude Code, Cursor, etc.) work together with shared knowledge and persistent memory.

## Quick Start

### One Command Setup

```bash
curl -fsSL https://raw.githubusercontent.com/achords-org/.internal/main/onboarding/scripts/setup.sh | bash
```

This installs:
- **OpenCode** — AI coding agent
- **Gentle AI** — Agent orchestration
- **Engram** — Persistent memory

### Manual Setup

1. Install OpenCode:
   ```bash
   curl -fsSL https://opencode.ai/install | bash
   ```

2. Install achords:
   ```bash
   npm install -g achords
   ```

3. Setup your org:
   ```bash
   achords obase --org your-org
   ```

## How It Works

### For Developers

1. Clone your repo with submodules:
   ```bash
   git clone --recurse-submodules https://github.com/your-org/your-repo.git
   ```

2. Open in OpenCode:
   ```bash
   cd your-repo
   opencode
   ```

3. The agent reads `.achords/AGENTS.md` automatically

4. Start working — memory persists across sessions

### For Teams

1. Setup org with achords:
   ```bash
   achords obase --org your-org
   ```

2. Configure existing repos:
   ```bash
   achords obase --repo your-repo
   ```

3. Add team members — they run the setup script

## Directory Structure

```
your-repo/
├── .achords/                    # Org rules (submodule)
│   ├── .engram/                 # Shared org memory
│   ├── AGENTS.md                # Agent rules
│   ├── config/                  # Policies & conventions
│   │   ├── policies.json
│   │   └── conventions.json
│   └── skills/                  # Shared skills
├── .engram/                     # Repo memory
│   └── config.json              # project_name: "your-repo"
├── AGENTS.md                    # Repo agent config
└── src/
```

## Commands

```bash
# Check version
achords version

# Update
achords update

# Setup org
achords obase --org your-org

# Configure repo
achords obase --repo your-repo

# Update profile
achords obase --update-profile --push
```

## Memory

### Org Memory (shared)

Stored in `.achords/.engram/` — synced via git.

Contains:
- Conventions and patterns
- Architecture decisions
- Shared knowledge

### Repo Memory (isolated)

Stored in `.engram/` — per repo.

Contains:
- Repo-specific bugs
- Feature decisions
- Local context

## Updating Org Rules

1. Edit files in `.achords/`
2. Commit and push
3. In each repo:
   ```bash
   git submodule update --remote
   ```

## Troubleshooting

### Agent not reading .achords

```bash
git submodule update --init --recursive
```

### Memory not persisting

```bash
engram doctor
```

### Version mismatch

```bash
achords version  # Check installed vs latest
achords update   # Update
```

## Support

- GitHub: https://github.com/achords-org/.achords/issues
- Docs: See `.achords/AGENTS.md` for agent rules
