# Organization Structure

What lives where in an Achords organization.

## Directory layout

```
~/achords/{org-name}/
├── .achords/           # Org-wide agent rules
│   ├── AGENTS.md       # Rules for all agents
│   ├── .engram/        # Shared org memory
│   ├── conventions.json
│   └── policies.json
├── .skills/            # Shared skills
│   ├── AGENTS.md       # Skill docs
│   ├── version.json    # Global skill index
│   └── skills/
│       ├── testing/
│       ├── code-review/
│       └── ...
├── .internal/          # Developer onboarding
│   ├── README.md
│   ├── AGENTS.md
│   └── scripts/
├── .github/            # Org profile
│   └── profile/
│       └── README.md
└── repos/              # Your projects
    ├── app-1/
    ├── app-2/
    └── ...
```

## .achords

The source of truth for agent behavior. Contains:

- `AGENTS.md` — Instructions for all agents
- `.engram/` — Shared memory database
- `conventions.json` — Coding conventions
- `policies.json` — Organizational policies

## .skills

Versioned skills that agents can use. Each skill is a directory:

```
.skills/
└── skills/
    └── {skill-name}/
        ├── manifest.json
        └── versions/
            ├── v1.0.0/
            │   └── SKILL.md
            └── v1.1.0/
                └── SKILL.md
```

## .internal

Developer onboarding and internal docs. Private by default.

## .github

Org profile and GitHub-specific config. Public.

## See also

- [Repo Integration](repo-integration.md)
- [Memory Isolation](memory-isolation.md)
