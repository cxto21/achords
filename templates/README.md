# Templates

Files that get copied to projects when initializing Achords.

## Structure

```
templates/
├── achords-init.sh          # Repository initialization script
├── skills/
│   ├── platform/            # Organization-level skills
│   │   ├── org-bootstrap/
│   │   └── org-join/
│   └── repo/                # Repository-level skills
│       ├── achords-init/
│       ├── agent-union/
│       ├── claim-declaration/
│       ├── claim-collision-check/
│       └── alignment-verify/
├── schemas/                 # JSON schemas for protocol files
│   ├── agent-profile.schema.json
│   ├── agent-state.schema.json
│   ├── claim.schema.json
│   └── message.schema.json
└── workflows/               # GitHub Actions workflows
    ├── achords-union.yml
    └── achords-alignment-check.yml
```

## Usage

### Automatic

Run `achords-init.sh` in your project:

```bash
bash templates/achords-init.sh
```

### Manual

Copy specific files:

```bash
# Copy a skill
cp -r templates/skills/repo/agent-union/ .achords/skills/

# Copy a schema
cp templates/schemas/claim.schema.json .achords/schemas/

# Copy a workflow
cp templates/workflows/achords-alignment-check.yml .github/workflows/
```

## Customization

These templates are starting points. Modify them for your team:

- Edit `skills/*/SKILL.md` to add team-specific instructions
- Modify `schemas/*.json` to extend protocol entities
- Update `workflows/*.yml` to adjust CI behavior

---

*These files are copied once during initialization. After that, manage them in your project.*
