# Roadmap

Current status and planned features.

## Status Legend

| Status | Meaning |
|--------|---------|
| ✅ Ready | Fully implemented, tested, documented |
| 🚧 In Progress | Partially implemented, being refined |
| 📋 Planned | Designed but not yet implemented |

## Platform Level

| Feature | Status | Notes |
|---------|--------|-------|
| `org-bootstrap` | 🚧 In Progress | Basic flow works, error handling being refined |
| `org-join` | ✅ Ready | Clones repos, sets up environment |
| `.engram` integration | ✅ Ready | Shared memory as submodule |
| Multi-org support | ✅ Ready | `.env` configuration |

## Repository Level

| Feature | Status | Notes |
|---------|--------|-------|
| `achords-init` | 📋 Planned | Will bootstrap `.achords/` structure |
| `agent-union` | 📋 Planned | Agent registration |
| `claim-declaration` | 📋 Planned | Intent declaration |
| `claim-collision-check` | 📋 Planned | Overlap detection |
| `alignment-verify` | 📋 Planned | CI validation |

## Agent Level

| Feature | Status | Notes |
|---------|--------|-------|
| Claim lifecycle | 📋 Planned | Create → active → released/expired |
| Inbox messaging | 📋 Planned | Agent-to-agent communication |
| State tracking | 📋 Planned | Activity and status |

## Documentation

| Document | Status | Notes |
|----------|--------|-------|
| Protocol overview | ✅ Ready | `docs/protocol.md` |
| Architecture | ✅ Ready | `docs/architecture.md` |
| Collaboration modes | ✅ Ready | `docs/collaboration.md` |
| Getting started | 🚧 In Progress | Being written |
| Full specification | 📋 Planned | `protocol/specification.md` |

## Completed

- [x] Repository structure reorganization
- [x] Platform skills (org-bootstrap, org-join)
- [x] Developer setup script
- [x] `.engram` shared memory integration
- [x] `.env` configuration support
- [x] Error handling and pre-checks
- [x] Documentation structure

## In Progress

- [ ] Org bootstrap error handling refinement
- [ ] Getting started guide
- [ ] achords-init implementation

## Planned

- [ ] Agent registration system
- [ ] Claims management
- [ ] CI workflow templates
- [ ] JSON schemas
- [ ] Collision detection
- [ ] Policy configuration

---

*This roadmap is updated as features are implemented.*
