# Achords Protocol Specification

## Overview

Achords is a lightweight, repository-native protocol for multi-agent software collaboration. It provides:

- **Union onboarding** for agent identity and lifecycle
- **Claims** for explicit pre-edit intent over repository paths
- **Supervisor alignment checks** in CI for collision and policy enforcement
- **Versioned state files** for transparency and auditability
- **Agent Skills** for discoverable, self-contained protocol operations

## Protocol Files

### `version.json`
Stores protocol version, initialization date, and status.

### `registry.json`
Canonical list of onboarded agents. New agents are registered via the `agent-union` skill.

### `claims.json`
Active, released, and expired claims over repository paths. Agents declare intent before editing via the `claim-declaration` skill.

### `topology.json`
Team collaboration topology, supervision model, and coordination strategy.

### `policies.json`
Policy flags and enforcement rules:
- Claim requirement (enabled/disabled)
- Exclusive claim overlap handling (blocking/advisory)
- Enforcement level (advisory/strict/regulated)

### `events.ndjson`
Append-only event stream for audit trail. Newline-delimited JSON recording all state transitions and actions.

### `supervisor/state.json`
Supervisor mode (`advisory` or `strict`), alignment check status, and blocked merges.

## Agent Skills

Skills are discoverable, self-contained protocol operations. Located in `.achords/skills/`, each skill has:

- **SKILL.md**: YAML frontmatter + Markdown instructions (agentskills.io format)
- **scripts/**: Executable code (Python, Bash, etc.)
- **assets/**: Templates, reference files
- **references/**: Documentation

### Core Skills

1. **achords-init** - Bootstrap Achords in a new repository
2. **agent-union** - Register a new agent before first contribution
3. **claim-declaration** - Declare work intent (claim) before editing code
4. **claim-collision-check** - Detect overlapping exclusive claims
5. **alignment-verify** - CI validation of protocol compliance

## Collaboration Workflow

```
1. New repository
   ↓ (Run achords-init skill)
2. Initialize .achords/ structure
   ↓ (Read agent-union skill)
3. New agent joins
   ↓ (Agent self-registers via agent-union)
4. Agent in registry.json
   ↓ (Agent reads claim-declaration skill)
5. Agent declares claim in claims.json
   ↓ (Edits source code)
6. Agent commits and opens PR
   ↓ (alignment-verify runs in CI)
7. Supervisor checks protocol compliance
   ↓ (If passed, merge allowed; if failed, blocked)
8. PR merged, event logged to events.ndjson
```

## Claim Lifecycle

A claim has fields:

```json
{
  "id": "claim-001",
  "agent_id": "agent-a-001",
  "paths": ["src/**", "tests/**"],
  "purpose": "Refactor authentication module",
  "mode": "exclusive",
  "ttl_minutes": 240,
  "status": "active",
  "created_at": "2026-07-04T10:00:00Z",
  "released_at": null
}
```

**Status values**: `active`, `released`, `expired`

**Mode values**: 
- `exclusive`: Only this agent can edit paths
- `advisory`: Advisory; overlaps allowed but noted

## Collision Discipline

- **Active exclusive claims** from different agents on overlapping paths → CI blocks merge
- Resolution: coordinate via issue comments, split paths, or change mode
- Supervisor authority: CI checks are final arbiter

## JSON Schema Validation

All protocol files conform to JSON schemas in `.achords/schemas/`:

- `agent-profile.schema.json` - Agent registry entries
- `agent-state.schema.json` - Per-agent state (inbox, metadata)
- `claim.schema.json` - Claim structure and constraints
- `message.schema.json` - Inter-agent message format

## Extensions & Future

Achords is designed for incremental evolution:

- **Phase 1 (MVP)**: Union, claims, basic alignment checks
- **Phase 2**: Objective tracking, dependency graphs, policy profiles
- **Phase 3**: Cross-repo federation, rich metrics, policy enforcement tiers
- **Phase 4**: Agent-to-agent delegation, learned collision patterns

---

See `.achords/skills/` for protocol operations. See `/docs/` for operational guides.
