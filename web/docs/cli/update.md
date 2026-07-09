# achords update

Update achords to latest version.

## Usage

```bash
achords update
```

## Behavior

1. Checks npm registry for latest version
2. Compares with installed version
3. Asks for confirmation
4. Updates via npm or git pull

## Examples

### Update via npm

```bash
achords update
# Checks npm, asks confirmation, updates
```

### Update from source

If installed from git:

```bash
achords update
# Runs git pull instead
```

## See also

- [version](version.md) — Check current version
