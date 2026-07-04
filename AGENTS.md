# AGENTS.md

This repository is **Achords-native** and optimized for coordinated multi-agent collaboration.

## Mission

Build and maintain **Achords** as a lightweight, repository-native protocol for multi-agent orchestration:
- predictable onboarding (union)
- explicit edit intent (claims)
- supervised alignment (CI checks)
- transparent collaboration state (versioned files)

## Non-negotiable collaboration rules

1. **Union first**
   - New agents must be onboarded before normal contributions.
   - Onboarding creates `.achords/agents/<agent_id>/` and updates `.achords/registry.json`.

2. **Claim before code edits**
   - Before modifying source files, an agent must register/update a claim in `.achords/claims.json`.
   - Claims must include: `id`, `agent_id`, `paths`, `purpose`, `mode`, `ttl_minutes`, `status`, `created_at`.

3. **Inbox-first iteration**
   - On each iteration, check `.achords/agents/<agent_id>/state.json`.
   - If `has_messages = 1`, process inbox before continuing.

4. **Collision discipline**
   - Never proceed with overlapping active exclusive claims.
   - Resolve via coordination, path split, or claim mode change.

5. **Supervisor authority**
   - CI alignment checks are authoritative for merge safety.
   - Merge must be blocked for unresolved claim overlaps or invalid Achords state.

## Repository outcomes required in this implementation

- Baseline Achords protocol files in `.achords/`
- JSON schemas for key protocol entities
- CI workflows for union + alignment checks
- Practical docs in `/docs`
- Clean README and clear value proposition

## Implementation constraints

- Keep it lightweight: JSON files + GitHub workflows.
- Avoid overengineering or backend dependencies.
- Preserve repo-native auditable state.
- Favor clear extension points over speculative complexity.

## Definition of done (DoD)

A PR is done when:

1. The following exist and are coherent:

   - `README.md`
   - `VALUE_PROPOSITION.md`
   - `.achords/ACHORDS.md`
   - `.achords/version.json`
   - `.achords/registry.json`
   - `.achords/claims.json`
   - `.achords/topology.json`
   - `.achords/policies.json`
   - `.achords/events.ndjson`
   - `.achords/supervisor/state.json`
   - `.achords/schemas/*.schema.json`
   - `.github/workflows/achords-union.yml`
   - `.github/workflows/achords-alignment-check.yml`
   - `docs/achords.md`
   - `docs/agent-union.md`
   - `docs/claims-and-alignment.md`

2. Workflows run successfully on PR.
3. Basic claim-overlap guard works for active exclusive claims.
4. Documentation explains the operational flow end-to-end.

## Suggested branch and PR conventions

- Branch: `feat/achords-bootstrap`
- PR title: `feat: bootstrap Achords protocol, workflows, and docs`
- PR body sections:
  - What was added
  - Why this structure
  - Validation and checks
  - Next extension steps