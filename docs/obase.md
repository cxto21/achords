# Organization Base

> **obase** — Set up your GitHub organization for multi-agent collaboration.

## What it does

Creates the foundation for multi-agent development in your GitHub organization:

- Organization profile (`.github/`)
- Team documentation and onboarding (`.internal/`)
- Shared skills library (`.skills/`)

## Quick start

```bash
# Interactive setup
bash obase.sh

# Or specify org name
bash obase.sh MyOrg
```

## First run

The script will check for `.env` and prompt you to configure:

```
  ╔═══════════════════════════════════════════╗
  ║     🎵 A C H O R D S                     ║
  ║     Organization Base                     ║
  ╚═══════════════════════════════════════════╝

  No .env found. Let's configure your organization.

  Organization name: MyOrg
  Skills repo URL (optional, press Enter to skip):
  Work directory [/home/user/Poincare]:
```

## What it creates

```
~/Poincare/
├── .github/
│   └── profile/
│       └── README.md      # Organization profile
├── .internal/
│   ├── onboarding/
│   │   ├── README.md
│   │   ├── AGENTS.md
│   │   └── scripts/
│   └── skills/
└── .skills/                # Shared skills library
```

## Configuration

The `.env` file stores your organization settings:

```bash
ORG_NAME=MyOrg                    # Your GitHub org name
WORK_DIR=/home/user/Poincare      # Where to clone repos
SKILLS_REPO_URL=                  # Optional: import skills
```

## Prerequisites

- Git
- GitHub CLI (`gh`) authenticated
- Bash

## Next steps

After running `obase.sh`:

1. Edit `.github/profile/README.md` — your org's public page
2. Add team members — they run the join script
3. Start adding skills to `.skills/`

---

Part of the [Achords](https://github.com/cxto21/achords) ecosystem.
