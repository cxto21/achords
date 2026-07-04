# VALUE_PROPOSITION.md

## Achords: Agent Chords for Repository-Native Multi-Agent Collaboration

### One-line value proposition

**Achords enables multiple agents to collaborate safely and transparently in a repository using lightweight, versioned coordination primitives.**

---

## Problem

As teams adopt AI agents in software delivery, collaboration quickly degrades without shared protocol:

- concurrent edits collide silently
- responsibilities are unclear
- coordination context is fragmented across tools
- governance and traceability are weak
- scaling from one to many agents becomes chaotic

Most solutions are either:
- too heavy (external orchestration platforms), or
- too loose (ad-hoc prompts and conventions)

---

## Solution

Achords introduces a **minimal protocol layer** inside the repo itself:

- **Union onboarding** for agent identity and lifecycle
- **Claims** for explicit pre-edit intent over paths
- **Supervisor alignment checks** in CI for collision and policy enforcement
- **Versioned state files** for transparency and auditability
- **Schema-driven structure** for consistency and portability

No external backend required for the MVP.

---

## Core differentiation

1. **Repo-native by design**
   - Collaboration state lives where work happens: in Git.

2. **Ultra-light operational model**
   - JSON + workflows + docs.
   - Fast to adopt, easy to inspect.

3. **Auditable multi-agent choreography**
   - Intent and decisions become explicit artifacts.

4. **Portable protocol**
   - Reusable across repositories and teams.

5. **Incremental governance**
   - Start advisory, evolve to stricter policy gates as needed.

---

## Who it is for

- Engineering teams introducing multiple AI agents in code workflows
- OSS maintainers coordinating distributed contributors + agents
- Platform teams seeking a standard for agent collaboration patterns

---

## Outcomes for adopters

- Fewer merge collisions from proactive claim discipline
- Better coordination quality with lower communication overhead
- Clearer accountability for agent actions and scope
- Stronger confidence in multi-agent scaling
- Faster onboarding of new agents/projects through reusable protocol

---

## Why now

Multi-agent development is already happening, but coordination standards are immature.
Achords provides a practical, low-friction standard teams can adopt immediately and evolve safely.

---

## MVP scope (this repository)

- `.achords` baseline protocol files
- core schemas (`agent-profile`, `agent-state`, `claim`, `message`)
- CI alignment checks
- operator docs and examples

---

## Future extensions

- objective tracking and dependency graphs
- richer claim semantics (priority, conflict classes, ownership transfer)
- policy profiles (advisory/strict/regulated)
- cross-repo federation patterns
- metrics and observability adapters

---

## Strategic thesis

**Achords is to multi-agent software collaboration what branching conventions were to team Git workflows: a small standard that unlocks reliable scale.**