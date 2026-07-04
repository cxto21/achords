# Achords

**Achords (Agent Chords)** is a lightweight, repository-native protocol for multi-agent software collaboration.

It standardizes how agents:
- join a repository (union),
- coordinate work intent (claims),
- exchange state/messages,
- and pass supervisor alignment checks before merge.

---

## ⚠️ Mandatory for all agents

Before doing any work in this repository, **read**:

- [`AGENTS.md`](./AGENTS.md)

That file defines mandatory collaboration rules (union, claim-before-edit, collision handling, alignment authority).

If an agent skips `AGENTS.md`, its contributions are considered non-compliant.

---

## Why Achords

As multi-agent development scales, teams need explicit coordination primitives that are:

- **Repo-native** (state lives in Git)
- **Lightweight** (JSON + workflows)
- **Auditable** (events and decisions are inspectable)
- **Extensible** (schema/policy evolution)

Achords provides those primitives without requiring heavy external orchestration in the MVP.

---

## Repository structure

```text
.
├── AGENTS.md
├── README.md
├── VALUE_PROPOSITION.md
├── docs/
│   ├── achords.md
│   ├── agent-union.md
│   └── claims-and-alignment.md
├── .achords/
│   ├── ACHORDS.md
│   ├── version.json
│   ├── registry.json
│   ├── claims.json
│   ├── topology.json
│   ├── policies.json
│   ├── events.ndjson
│   ├── agents/
│   │   └── .gitkeep
│   ├── supervisor/
│   │   └── state.json
│   └── schemas/
│       ├── agent-profile.schema.json
│       ├── agent-state.schema.json
│       ├── claim.schema.json
│       └── message.schema.json
└── .github/
    └── workflows/
        ├── achords-union.yml
        └── achords-alignment-check.yml
```

---

## Core protocol artifacts (`.achords/`)

- **`ACHORDS.md`**  
  Human-readable protocol specification.

- **`version.json`**  
  Protocol/repo Achords version metadata.

- **`registry.json`**  
  Canonical list of onboarded agents.

- **`claims.json`**  
  Active/released/expired claims over repo paths.

- **`topology.json`**  
  Team/supervisor collaboration topology.

- **`policies.json`**  
  Policy flags (e.g. claim requirement, overlap handling).

- **`events.ndjson`**  
  Append-only event stream (bootstrap, state transitions, actions).

- **`agents/<agent_id>/`**  
  Per-agent state and messaging artifacts.

- **`supervisor/state.json`**  
  Supervisor mode and last alignment status.

- **`schemas/*.schema.json`**  
  JSON schemas for Achords entities.

---

## Collaboration model (MVP)

1. **Union onboarding**  
   Candidate agent is registered into `.achords/registry.json` and gets a folder under `.achords/agents/<agent_id>/`.

2. **Claim-before-edit**  
   Agent declares intent in `.achords/claims.json` before modifying target files.

3. **Alignment checks in CI**  
   PR workflows validate Achords required files, JSON integrity, and claim collision rules (especially active exclusive overlaps).

4. **Merge discipline**  
   Unresolved policy or claim conflicts must be fixed before merge.

---

## Quick start

### 1) Read operational docs
- [`AGENTS.md`](./AGENTS.md)
- [`docs/achords.md`](./docs/achords.md)
- [`docs/agent-union.md`](./docs/agent-union.md)
- [`docs/claims-and-alignment.md`](./docs/claims-and-alignment.md)

### 2) Verify baseline files
Ensure `.achords/` baseline exists and JSON files are valid.

### 3) Open PRs with protocol compliance
- Use union flow for new agents.
- Add/update claims before touching code paths.
- Let workflows evaluate alignment.

---

## Workflows

### `achords-union.yml`
Checks onboarding PRs (e.g. PR title/label includes `agent-union`) and validates required Achords baseline context.

### `achords-alignment-check.yml`
Runs on PR updates and validates:
- required Achords files exist,
- JSON syntax is valid,
- active exclusive claims do not overlap across different agents.

---

## Recommended PR convention

- **Branch:** `feat/achords-bootstrap` (or feature-specific)
- **PR title style:** `feat: <short description>`
- **PR body should include:**
  - what changed,
  - why it changed,
  - policy/claim impact,
  - validation evidence.

---

## Related documents

- [`AGENTS.md`](./AGENTS.md) — mandatory agent rules
- [`VALUE_PROPOSITION.md`](./VALUE_PROPOSITION.md) — strategic/product framing
- [`docs/`](./docs) — operational documentation
- [`.achords/ACHORDS.md`](./.achords/ACHORDS.md) — protocol spec

---

## Current status

This repository is structured as an **Achords MVP bootstrap**:
- protocol artifacts,
- schemas,
- CI checks,
- and operational docs.

Future iterations can add richer semantics (objectives, dependencies, stricter policy tiers, cross-repo federation).