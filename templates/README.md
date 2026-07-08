# Templates — Organization Base

Files that get copied to projects when initializing an organization.

## Structure

```
templates/
└── skills/
    └── platform/            # Organization-level skills
        ├── org-bootstrap/   # Create org structure
        └── org-join/        # Team member onboarding
```

## Usage

### Automatic

Run `bootstrap.sh` from the root:

```bash
bash bootstrap.sh YourOrg
```

### Manual

Copy specific skills:

```bash
# Copy org-bootstrap skill
cp -r templates/skills/platform/org-bootstrap/ /path/to/skills/

# Copy org-join skill
cp -r templates/skills/platform/org-join/ /path/to/skills/
```

## Customization

These templates are starting points. Modify them for your team:

- Edit `skills/*/SKILL.md` to add team-specific instructions
- Modify `scripts/*.sh` to adjust behavior

---

*These files are copied once during initialization. After that, manage them in your project.*
