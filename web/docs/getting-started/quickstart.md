# Quick Start

Bootstrap an organization and onboard your first repo in 5 minutes.

## 1. Create your org

```bash
achords obase --org my-company
```

This creates:

```
~/achords/my-company/
├── .achords/      # Org-wide agent rules
├── .skills/       # Shared skills
├── .internal/     # Developer onboarding
└── .github/       # Org profile
```

## 2. Onboard a repo

```bash
cd ~/achords/my-company
achords obase --repo my-app
```

## 3. Verify

```bash
ls -la my-app/
# Should show .engram/ directory
cat my-app/AGENTS.md
# Should show agent instructions
```

## What happened?

1. `.engram` was added for agent memory
2. `AGENTS.md` was created with agent instructions
3. `.achords` and `.skills` were added as submodules
4. Org-wide rules now apply to this repo

## Next steps

- [Concepts](concepts.md) — Understand the mental model
- [Architecture](../architecture/org-structure.md) — What lives where
