# achords obase

Initialize an organization or configure a repo.

## Usage

```bash
achords obase [options]
```

## Options

| Flag | Description | Default |
|------|-------------|---------|
| `--org` | Organization name | Required |
| `--repo` | Repo to configure | None |
| `--dir` | Custom work directory | `~/achords/{org}` |
| `--skills` | Skills repo URL | None |
| `--update-headers` | Update AGENTS.md in all repos | false |
| `--push` | Push changes to GitHub | false |

## Examples

### Initialize org

```bash
achords obase --org my-company
```

Creates `~/achords/my-company/` with full structure.

### Configure existing repo

```bash
cd ~/achords/my-company
achords obase --repo my-app
```

### Update all repos

```bash
achords obase --org my-company --update-headers
```

Iterates all repos, creates/updates AGENTS.md with headers.

### Custom directory

```bash
achords obase --org my-company --dir /custom/path
```

## What it creates

### Org init

```
~/achords/my-company/
├── .achords/
├── .skills/
├── .internal/
└── .github/
```

### Repo config

```
my-app/
├── .achords → (submodule)
├── .skills  → (submodule)
├── .engram/
└── AGENTS.md
```

## See also

- [Organization Structure](../architecture/org-structure.md)
- [Repo Integration](../architecture/repo-integration.md)
