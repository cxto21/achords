# TODO_IMPLEMENTATION.md

## Goal

Implement full Achords bootstrap in this repository with a production-ready MVP structure.

## 1) Repository documentation

- [ ] Create/refresh `README.md` with:
  - [ ] what Achords is
  - [ ] quick start
  - [ ] repository layout
  - [ ] link to docs and protocol files

- [ ] Add `VALUE_PROPOSITION.md` (business + strategic narrative)
- [ ] Add/update `AGENTS.md` (multi-agent operational rules)

## 2) Achords protocol structure

Create:

- [ ] `.achords/ACHORDS.md`
- [ ] `.achords/version.json`
- [ ] `.achords/registry.json`
- [ ] `.achords/claims.json`
- [ ] `.achords/topology.json`
- [ ] `.achords/policies.json`
- [ ] `.achords/events.ndjson`
- [ ] `.achords/agents/.gitkeep` (or `README.md`)
- [ ] `.achords/supervisor/state.json`

Recommended initial `events.ndjson` line:
```json
{"type":"bootstrap","timestamp":"2026-07-04T00:00:00Z","message":"Achords initialized"}
```

## 3) JSON schemas

Create:

- [ ] `.achords/schemas/agent-profile.schema.json`
- [ ] `.achords/schemas/agent-state.schema.json`
- [ ] `.achords/schemas/claim.schema.json`
- [ ] `.achords/schemas/message.schema.json`

Requirements:
- [ ] valid JSON Schema draft (2020-12 preferred)
- [ ] strict required fields for MVP
- [ ] explicit enums for status/modes where applicable

## 4) GitHub workflows

Create:

- [ ] `.github/workflows/achords-union.yml`
- [ ] `.github/workflows/achords-alignment-check.yml`

### achords-union.yml (minimum behavior)

- [ ] Trigger on PR events
- [ ] Detect union PRs (title/label contains `agent-union`)
- [ ] Validate presence of baseline Achords files
- [ ] Emit advisory output for required union artifacts

### achords-alignment-check.yml (minimum behavior)

- [ ] Trigger on PR events
- [ ] Validate required Achords files exist
- [ ] Validate JSON syntax for protocol files
- [ ] Check active exclusive claim path overlaps and fail on conflict

## 5) `/docs` content

Create:

- [ ] `docs/achords.md`
- [ ] `docs/agent-union.md`
- [ ] `docs/claims-and-alignment.md`

Docs must include:
- [ ] onboarding flow
- [ ] claim lifecycle
- [ ] collision handling
- [ ] how CI gates merges

## 6) Quality gates

Before PR:

- [ ] all JSON files parse correctly
- [ ] workflows are valid YAML
- [ ] no empty files that break tooling (use minimal content for placeholders)
- [ ] links in docs are correct
- [ ] terminology is consistent (`Achords`, `agent_id`, `claim`, `union`, `alignment`)

## 7) PR delivery

- [ ] Branch: `feat/achords-bootstrap`
- [ ] Commit message:
  - [ ] `feat: bootstrap Achords protocol, workflows, and docs`
- [ ] PR title:
  - [ ] `feat: bootstrap Achords protocol, workflows, and docs`
- [ ] PR body includes:
  - [ ] Summary
  - [ ] Files added
  - [ ] Validation steps
  - [ ] Follow-up roadmap

## Optional stretch (if time allows)

- [ ] Add sample `.achords/agents/a-0001/profile.json` + `state.json`
- [ ] Add JSON schema validation step in CI (beyond syntax)
- [ ] Add policy modes: advisory vs strict in supervisor state