# Getting Started — Organization Base

Set up your GitHub organization for multi-agent collaboration in 5 minutes.

## Prerequisites

- Git
- GitHub CLI (`gh`) authenticated
- Bash

## Quick Start

### 1. Clone this repo

```bash
git clone https://github.com/cxto21/achords.git
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

## Bootstrap Your Organization

```bash
# Basic bootstrap
bash bootstrap.sh YourOrg

# With team skills from external repo
bash bootstrap.sh YourOrg https://github.com/your-org/team-skills.git
```

### What It Creates

```
your-org/
├── .github/          # Organization profile (public)
├── .internal/        # Team docs, onboarding
│   └── skills/
│       └── join-team/
│           └── setup.sh
└── .skills/          # Shared skills library
```

## For Team Members

Join an existing organization:

```bash
bash templates/skills/platform/org-join/scripts/setup.sh YourOrg
```

## What Happens Next

After setup:

1. **Read `AGENTS.md`** in your project — mandatory rules
2. **Add team members** — they run `org-join`
3. **Create repositories** — use Achords in them

## Next Steps

- [Architecture](./architecture.md) — Understand the three-level design
- [Roadmap](./roadmap.md) — See all products and their status

## Troubleshooting

**"Organization not found"**  
Create it at https://github.com/organizations/new

**"Not logged in"**  
Run `gh auth login`

**"Already initialized"**  
Safe to re-run. Scripts skip existing files.

---

*Next: [Architecture](./architecture.md) — Understand the three-level design.*
