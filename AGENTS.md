# AGENTS.md

This repository is **Achords-native** and optimized for coordinated multi-agent collaboration.

## Mission

Build and maintain **Achords** as a lightweight, repository-native protocol for multi-agent collaboration across three levels:
- **Platform** — Organization setup and team onboarding
- **Repository** — Claim-based intent and CI alignment
- **Agent** — Identity, registration, and contribution workflow

## Non-negotiable collaboration rules

### Platform rules

1. **Bootstrap before join**
   - Organization owners run `org-bootstrap` first
   - Creates required repository structure

2. **Join before contribute**
   - Team members run `org-join` to clone repos
   - Environment must be set up before contributions

### Repository rules

3. **Init before union**
   - Run `achords-init` before agents register
   - Creates `.achords/` directory and protocol files

4. **Union first**
   - Agents register before contributing
   - Creates agent state and registry entry

5. **Claim before code edits**
   - Declare intent in `claims.json` before modifying files
   - Include: `id`, `agent_id`, `paths`, `purpose`, `mode`, `ttl_minutes`

### Agent rules

6. **Inbox-first iteration**
   - Check `.achords/agents/<agent_id>/state.json` for messages
   - Process inbox before continuing

7. **Collision discipline**
   - Never proceed with overlapping exclusive claims
   - Resolve via coordination, path split, or mode change

8. **Supervisor authority**
   - CI checks are authoritative for merge safety
   - Block merges with unresolved conflicts

## Definition of done

A PR is done when:

1. Documentation is clear and accurate
2. Scripts work as documented
3. No conflicting claims in `claims.json`
4. CI passes

## Repository structure

```
achords/
├── README.md
├── AGENTS.md
├── .env.example
├── docs/                  # Documentation
├── templates/             # Files copied to projects
├── protocol/              # Specification
├── scripts/               # Setup scripts
└── .github/workflows/     # CI
```

## Branch and PR conventions

- Branch: `feat/description` or `fix/description`
- PR title: `feat: description` or `fix: description`
- PR body: What changed, why, how to verify
