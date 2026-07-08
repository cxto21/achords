# Getting Started

Set up Achords in your project in 5 minutes.

## Prerequisites

- Git
- GitHub CLI (`gh`) authenticated
- Bash

## Quick Start

### 1. Clone this repo

```bash
git clone https://github.com/your-org/achords.git
cd achords
```

### 2. Configure

```bash
cp .env.example .env
# Edit .env with your org name
```

### 3. Run dev setup

```bash
bash scripts/dev-setup.sh
```

This adds `.engram` shared memory to your project.

## For Organization Owners

Set up your GitHub organization:

```bash
# Basic bootstrap
bash templates/skills/platform/org-bootstrap/scripts/bootstrap.sh YourOrg

# With team skills from external repo
bash templates/skills/platform/org-bootstrap/scripts/bootstrap.sh YourOrg https://github.com/your-org/team-skills.git
```

## For Team Members

Join an existing organization:

```bash
bash templates/skills/platform/org-join/scripts/setup.sh YourOrg
```

## For Repository Setup

Initialize Achords in a repository:

```bash
bash templates/achords-init.sh
```

## What Happens Next

After setup:

1. **Read `AGENTS.md`** in your project — mandatory rules
2. **Register as an agent** — `agent-union` skill
3. **Declare claims** — before editing code
4. **Open PRs** — CI validates compliance

## Troubleshooting

**"Organization not found"**  
Create it at https://github.com/organizations/new

**"Not logged in"**  
Run `gh auth login`

**"Already initialized"**  
Safe to re-run. Scripts skip existing files.

---

*Next: [Protocol](./protocol.md) — Understand how Achords works.*
