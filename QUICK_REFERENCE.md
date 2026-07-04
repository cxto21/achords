# Achords Quick Reference

## 🚀 First-Time Setup

For a new repository that has never used Achords:

```bash
# 1. Bootstrap the protocol
python .achords/skills/achords-init/scripts/init.sh

# 2. Commit baseline
git add .achords/
git commit -m "feat: bootstrap Achords protocol, workflows, and docs"

# 3. (Optional) Push to branch and open PR
git push -u origin feat/achords-bootstrap
# Then: Create PR on GitHub
```

## 👤 Register an Agent

Before an agent makes its first contribution:

```bash
# 1. Run registration
python .achords/skills/agent-union/scripts/register-agent.py

# 2. Follow prompts
# Agent ID: agent-a-001
# Name: Claude Code Assistant
# Type: ai

# 3. Commit
git add .achords/registry.json .achords/agents/
git commit -m "feat: register agent-a-001 via agent-union"
```

## 📋 Declare a Claim

Before editing code:

```bash
# 1. Read the guide
cat .achords/skills/claim-declaration/SKILL.md

# 2. Declare claim (script coming soon)
python .achords/skills/claim-declaration/scripts/declare-claim.py

# 3. Answer prompts
# Paths: src/auth/**, tests/auth/**
# Purpose: Refactor JWT validation
# Mode: exclusive
# TTL: 120 minutes

# 4. Edit the files covered by your claim
# ... make your changes ...

# 5. Commit normally
git add src/auth/ tests/auth/
git commit -m "refactor: JWT validation module"
git push origin feature-branch

# 6. Open PR → CI validates automatically
```

## ✅ Check for Collisions

Before opening a PR:

```bash
# Check current collision status
python .achords/skills/claim-collision-check/scripts/check-overlaps.py

# If there's a blocking collision:
# Option A: Coordinate with other agent
# Option B: Change claim mode to 'advisory'
# Option C: Adjust your claimed paths
```

## 📖 Key Documentation

| Resource | When to read |
|----------|--------------|
| `AGENTS.md` | **First thing**: mandatory rules |
| `docs/achords.md` | Full protocol overview |
| `docs/agent-union.md` | Registering agents |
| `docs/claims-and-alignment.md` | Declaring claims + CI checks |
| `.achords/skills/*/SKILL.md` | How to use each skill |

## 🔍 Check Protocol Status

```bash
# View registered agents
cat .achords/registry.json

# View active claims
cat .achords/claims.json

# View audit trail
cat .achords/events.ndjson

# View supervisor state
cat .achords/supervisor/state.json
```

## 🚨 If CI Fails

### Missing files error
→ Run `python .achords/skills/achords-init/scripts/init.sh`

### JSON syntax error
→ Check the error message, fix the JSON, and retry

### Claim collision detected
```bash
# See which claims overlap
python .achords/skills/claim-collision-check/scripts/check-overlaps.py

# Resolve by:
1. Contacting the other agent
2. Changing your claim to 'advisory' mode
3. Adjusting claimed paths
```

## 📚 Agent Skills (agentskills.io Format)

Located in `.achords/skills/`, each skill has:

```
skill-name/
├── SKILL.md                    # metadata + instructions
├── scripts/                    # executable code
└── assets/                     # templates/resources
```

### Core Skills
1. **achords-init** - Bootstrap protocol
2. **agent-union** - Register agent
3. **claim-declaration** - Declare claim
4. **claim-collision-check** - Check overlaps
5. **alignment-verify** - CI validation

---

## 💡 Best Practices

1. **Always declare a claim** before editing code
2. **Use exclusive mode** by default (prevents accidental collisions)
3. **Set TTL** to match your expected work duration
4. **Check for collisions** before opening PR
5. **Coordinate via GitHub issues** if claims overlap
6. **Release claims** when work is done (or let them expire)

---

## 🎯 Policy Modes

| Mode | Behavior | Use When |
|------|----------|----------|
| `exclusive` | Blocks overlapping claims from other agents | Most work; refactoring; critical changes |
| `advisory` | Informational; doesn't block | Large-scale changes; early exploration |

---

## ⏱️ TTL Guidance

| Work Type | TTL | Example |
|-----------|-----|---------|
| Bug fix | 30 min | "Fix null pointer in auth.py" |
| Feature | 120-240 min | "Add OAuth 2.0 flow" |
| Large refactor | 480-1440 min | "Restructure database layer" |
| Exploration | 60-120 min | "Spike on WebSocket implementation" |

---

## 🔧 Troubleshooting

| Problem | Solution |
|---------|----------|
| "agent_id already exists" | Use a different ID (agent-a-002, etc.) |
| "invalid agent_id format" | Use lowercase + hyphens only (^[a-z0-9-]+$) |
| ".achords/ not found" | Run achords-init first |
| "Claim TTL too short" | Redeclare with longer TTL |
| "JSON syntax error" | Fix the JSON and retry |
| "Blocking collision" | Coordinate with other agent or change mode |

---

## 📈 Monitoring

```bash
# Count registered agents
jq '.agents | length' .achords/registry.json

# Count active claims
jq '.claims | map(select(.status=="active")) | length' .achords/claims.json

# View recent events
tail -10 .achords/events.ndjson

# Check supervisor status
cat .achords/supervisor/state.json | jq .alignment_status
```

---

**Need help?** See `/docs/` for detailed guides.
**Mandatory rules?** See `AGENTS.md`.
**Protocol spec?** See `.achords/ACHORDS.md`.
