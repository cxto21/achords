# Creating Skills

Step-by-step guide to author new skills.

## 1. Create directory

```bash
mkdir -p .skills/skills/my-skill/versions/v1.0.0
```

## 2. Create SKILL.md

```yaml
---
name: my-skill
description: What this skill does
triggers:
  - when to use this skill
scope:
  - "**/*.ts"
  - "**/*.js"
---

# My Skill

## Instructions

1. Step one
2. Step two
3. Step three

## Resources

- [Link](url) — Description
```

## 3. Create manifest.json

```json
{
  "name": "my-skill",
  "description": "What this skill does",
  "versions": {
    "v1.0.0": {
      "created": "2025-03-01",
      "platforms": ["linux"]
    }
  }
}
```

## 4. Add scripts (optional)

```bash
mkdir -p .skills/skills/my-skill/versions/v1.0.0/scripts
```

## 5. Add references (optional)

```bash
mkdir -p .skills/skills/my-skill/versions/v1.0.0/scripts/references
```

## 6. Update global index

Add to `version.json`:

```json
{
  "skills": {
    "my-skill": {
      "latest": "v1.0.0",
      "platforms": ["linux"]
    }
  }
}
```

## Best practices

- Keep SKILL.md concise
- Use clear triggers
- Include examples
- Test with agents

## See also

- [Specification](specification.md)
- [Versioning](versioning.md)
