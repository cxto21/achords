# Achords: Multi-Agent Collaboration Protocol

## Overview

Achords is a lightweight, repository-native protocol for coordinating multiple AI agents (or humans) in collaborative software development. It solves the coordination and collision problems that emerge when multiple agents work in the same repository without explicit synchronization.

## Core problem

As teams scale to use multiple AI agents:
- Concurrent edits to the same files cause collisions
- Responsibilities and ownership are unclear
- Coordination happens outside the repo (Slack, GitHub issues) → context fragmentation
- Scaling from 1 to N agents becomes chaotic without governance

## Achords solution

Three core mechanisms:

### 1. Union Onboarding

Agents register themselves before making any contributions. This establishes identity and enables tracking.

```
New agent → runs agent-union skill → .achords/registry.json updated → agent tracked
```

### 2. Claim-Based Intent

Before editing files, agents declare intent via a "claim" - a pre-edit contract that specifies:
- Which files/paths they plan to modify
- Why they're modifying them
- Whether the claim is exclusive (blocking other agents) or advisory
- Time-to-live (TTL) for the claim

```
Agent plans work → claims paths in .achords/claims.json → CI checks for overlaps → merge allowed/blocked
```

### 3. Supervisor Alignment Checks

CI validates protocol compliance on every PR:
- Required protocol files exist
- JSON is syntactically valid
- No blocking claim overlaps
- Events are logged consistently

```
PR opened → alignment-verify runs → pass? merge allowed; fail? blocked
```

## Why this design

| Goal | How Achords addresses it |
|------|--------------------------|
| **Prevent collisions** | Exclusive claims + CI checks |
| **Clear ownership** | Claims establish intent + agent registry |
| **Auditable decisions** | Events.ndjson logs all state changes |
| **Low operational overhead** | JSON + GitHub Actions, no external backend |
| **Portable** | Reusable across repos using same protocol |
| **Agent-discoverable** | Skills follow agentskills.io standard |
| **Graceful escalation** | Advisory → exclusive → strict policy modes |

## Key concepts

### Agent

An entity (AI, human, or service) that makes changes to the repository. Identified by `agent_id` in `registry.json`.

### Claim

A pre-edit declaration of intent. Specifies paths, purpose, mode, and TTL. Stored in `claims.json`. 

**Mode**:
- `exclusive`: Only this agent can edit claimed paths; blocks overlapping exclusive claims from other agents
- `advisory`: Informational; doesn't block other agents but signals intent

**Status**:
- `active`: Claim is in effect
- `released`: Agent finished, claim was explicitly released
- `expired`: Claim TTL elapsed

### Event

A state change: agent union, claim creation/release, alignment check, error, etc. Logged to `events.ndjson` for audit trail.

### Supervisor

In MVP: GitHub Actions CI workflows that run `alignment-verify` skill. Enforces policy and blocks non-compliant merges.

## Workflow: Agent perspective

```
1. New agent arrives at repository
   ↓
2. Reads AGENTS.md (mandatory)
   ↓
3. Reads .achords/skills/agent-union/SKILL.md
   ↓
4. Runs agent-union skill
   ↓
5. Agent registered in .achords/registry.json
   ↓
6. Reads .achords/skills/claim-declaration/SKILL.md
   ↓
7. Plans work, declares claim in .achords/claims.json
   ↓
8. Makes code changes
   ↓
9. Commits and opens PR
   ↓
10. CI runs alignment-verify skill automatically
    ✓ Alignment PASSED → merge allowed
    ✗ Alignment FAILED → fix and retry
   ↓
11. PR merged, claim auto-releases
    ↓
12. Event logged to events.ndjson
```

## File structure

```
.achords/                           # Protocol directory
├── ACHORDS.md                       # This specification
├── version.json                     # Protocol version
├── registry.json                    # Agent directory
├── claims.json                      # Active/released claims
├── topology.json                    # Team structure
├── policies.json                    # Policy configuration
├── events.ndjson                    # Audit log
├── agents/                          # Per-agent state
│   └── <agent_id>/
│       ├── state.json               # Agent state
│       └── inbox/                   # Message directory
├── supervisor/                      # Supervisor state
│   └── state.json
├── schemas/                         # JSON Schema definitions
│   ├── agent-profile.schema.json
│   ├── agent-state.schema.json
│   ├── claim.schema.json
│   └── message.schema.json
└── skills/                          # Agent Skills (agentskills.io)
    ├── achords-init/
    ├── agent-union/
    ├── claim-declaration/
    ├── claim-collision-check/
    └── alignment-verify/
```

## JSON schemas

All protocol data is validated against schemas in `.achords/schemas/`:

- **agent-profile.schema.json** - Agent registry entries
- **agent-state.schema.json** - Per-agent state
- **claim.schema.json** - Claim structure
- **message.schema.json** - Inter-agent messages

## Claim example

```json
{
  "id": "claim-20260704-001",
  "agent_id": "agent-a-001",
  "paths": ["src/auth/**", "tests/auth/**"],
  "purpose": "Refactor JWT validation module for better error handling",
  "mode": "exclusive",
  "ttl_minutes": 240,
  "status": "active",
  "created_at": "2026-07-04T10:00:00Z",
  "released_at": null
}
```

## Collision handling

When an agent declares an exclusive claim that overlaps with another agent's exclusive claim:

```
Agent A claims: src/auth/**
Agent B claims: src/auth/jwt.py (within A's range)

Result: ✗ BLOCKING COLLISION
Merge blocked until resolved

Resolution options:
1. Contact other agent, negotiate path adjustment
2. Change claim mode to advisory (weaker guarantee)
3. Adjust TTL or release claim early
```

## Policy modes

Achords supports three policy enforcement levels (configured in `policies.json`):

### Advisory mode (MVP default)

- Collisions detected but don't block merge
- Claims recorded for visibility
- Good for getting teams comfortable with the protocol

### Strict mode

- Collisions block merge
- Claims must be valid per schema
- No overrides without supervisor approval

### Regulated mode (future)

- Strict + additional governance
- Requires approval from designated reviewers
- Policy can differ by paths or agent type

## Supervisor and CI

In MVP, the supervisor is implemented via GitHub Actions CI:

1. `.github/workflows/achords-alignment-check.yml` triggers on PR
2. Runs `alignment-verify` skill
3. Checks required files, JSON validity, claim overlaps
4. Sets PR check status (pass/fail)
5. Merge is blocked if checks fail (repository settings)

## Events stream

Every significant action is logged to `events.ndjson`:

```jsonlines
{"type":"bootstrap","timestamp":"2026-07-04T00:00:00Z","message":"Achords initialized"}
{"type":"agent-union","timestamp":"2026-07-04T10:00:00Z","agent_id":"agent-a-001","status":"success"}
{"type":"claim-created","timestamp":"2026-07-04T10:05:00Z","claim_id":"claim-20260704-001","agent_id":"agent-a-001"}
{"type":"alignment-check","timestamp":"2026-07-04T10:30:00Z","pr":"#42","status":"passed"}
```

Lines are newline-delimited JSON (NDJSON), making them queryable and auditable.

## Agent Skills (agentskills.io format)

Achords includes 5 core skills:

1. **achords-init** - Bootstrap protocol in new repo
2. **agent-union** - Register agent
3. **claim-declaration** - Declare/release claims
4. **claim-collision-check** - Detect overlaps
5. **alignment-verify** - CI validation

Each skill has:
- **SKILL.md**: Metadata (name, description, compatibility) + instructions
- **scripts/**: Executable code
- **assets/**: Templates or reference files
- **references/**: Documentation

Skills are discoverable by agents and can be invoked programmatically.

## Next steps for a new repository

1. Run `achords-init` skill to bootstrap `.achords/`
2. Each new agent runs `agent-union` skill to register
3. Before editing, agents run `claim-declaration` skill
4. CI automatically runs `alignment-verify` on PRs
5. For collision debugging, use `claim-collision-check` skill

## Configuration and evolution

### Policies

Edit `.achords/policies.json` to control behavior:

```json
{
  "claim_requirement": {
    "enabled": true,
    "mode": "mandatory"
  },
  "exclusive_claim_overlap": {
    "enabled": true,
    "mode": "blocking"
  },
  "policy_enforcement_level": "advisory"
}
```

### Supervisor mode

Edit `.achords/supervisor/state.json` to change enforcement:

```json
{
  "mode": "strict",
  "enabled": true
}
```

This makes alignment failures blocking instead of advisory.

## Scaling Achords

Phase 1 (MVP - this PR):
- Union, claims, alignment checks
- Agent Skills integration
- CI workflows
- Documentation

Phase 2:
- Objective tracking and dependency graphs
- Richer claim semantics (priority, ownership transfer)
- Policy profiles (advisory/strict/regulated per path)

Phase 3:
- Cross-repo federation
- Metrics and observability
- Learned collision patterns (machine learning)

Phase 4:
- Agent-to-agent delegation
- Smart scheduling
- Predictive collision avoidance

## References

- [Agent Skills Specification](https://agentskills.io/specification.md)
- [AGENTS.md](../AGENTS.md) - Mandatory rules for contributors
- [VALUE_PROPOSITION.md](../VALUE_PROPOSITION.md) - Strategic context
