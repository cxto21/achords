# OS Tagging

Platform-specific skills with family inheritance.

## Hierarchy

```
linux
├── debian
│   ├── ubuntu
│   │   ├── ubuntu-22.04
│   │   └── ubuntu-24.04
│   └── debian-12
└── fedora

windows
├── windows-11
└── windows-server-2022
```

## Tag format

```json
{
  "os": "ubuntu",
  "versions": ["22.04", "24.04"],
  "family": "debian"
}
```

## Inheritance

A skill tagged `ubuntu` works on:
- Ubuntu 22.04
- Ubuntu 24.04
- Any Debian-based system

## Incompatibility

Skills can declare incompatibilities:

```json
{
  "os": "windows",
  "incompatible_with": ["linux"]
}
```

## Resolution

When loading a skill:

1. Check exact OS match
2. Check family inheritance
3. Check incompatibilities
4. Load best match

## See also

- [Versioning](versioning.md)
- [Specification](specification.md)
