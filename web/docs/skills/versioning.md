# Versioning

Skills are versioned by directory.

## Structure

```
.skills/
└── skills/
    └── testing/
        ├── manifest.json
        └── versions/
            ├── v1.0.0/
            │   └── SKILL.md
            └── v1.1.0/
                └── SKILL.md
```

## manifest.json

```json
{
  "name": "testing",
  "description": "Testing patterns",
  "versions": {
    "v1.0.0": {
      "created": "2025-01-15",
      "platforms": ["linux", "windows"]
    },
    "v1.1.0": {
      "created": "2025-02-20",
      "platforms": ["linux"]
    }
  }
}
```

## Forks

Platform-specific versions are forks:

```
versions/
├── v1.0.0/          # Base version
├── v1.1.0/          # Updated base
└── v1.1.0-windows/  # Windows fork
```

Fork manifest:

```json
{
  "forked_from": "v1.1.0",
  "platform": "windows"
}
```

## Global index

`version.json` at skill root:

```json
{
  "version": "1.2.0",
  "skills": {
    "testing": {
      "latest": "v1.1.0",
      "platforms": ["linux"]
    }
  }
}
```

## See also

- [OS Tagging](os-tagging.md)
- [Specification](specification.md)
