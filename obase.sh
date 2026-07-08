#!/usr/bin/env bash
# ══════════════════════════════════════════════════════════════════════
# obase — Organization Base
# ══════════════════════════════════════════════════════════════════════
# Sets up your GitHub organization for multi-agent collaboration.
#
# Usage:
#   bash obase.sh [org-name]
#
# Examples:
#   bash obase.sh
#   bash obase.sh MyOrg
# ══════════════════════════════════════════════════════════════════════

set -euo pipefail

# ── branding ────────────────────────────────────────────────────────
VERSION="1.0.0"
PRODUCT="obase"
PRODUCT_NAME="Organization Base"
BANNER=$(cat << 'EOF'
  ╔═══════════════════════════════════════════╗
  ║     🎵 A C H O R D S                     ║
  ║     Organization Base                     ║
  ╚═══════════════════════════════════════════╝
EOF
)

# ── helpers ──────────────────────────────────────────────────────────
info()  { printf "\033[1;36m▸\033[0m %s\n" "$*"; }
ok()    { printf "\033[1;32m✓\033[0m %s\n" "$*"; }
warn()  { printf "\033[1;33m⚠\033[0m %s\n" "$*"; }
err()   { printf "\033[1;31m✗\033[0m %s\n" "$*" >&2; }
header(){ printf "\n\033[1;35m── %s ──\033[0m\n" "$*"; }

# ── load .env ────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/.env"

load_env() {
  if [ -f "$ENV_FILE" ]; then
    set -a
    source "$ENV_FILE"
    set +a
  fi
}

# ── create .env if missing ───────────────────────────────────────────
setup_env() {
  if [ ! -f "$ENV_FILE" ]; then
    info "No .env found. Let's configure your organization."
    echo ""
    
    # Get org name from arg or prompt
    if [ -n "${ORG_NAME:-}" ]; then
      READ_ORG="$ORG_NAME"
    else
      read -rp "  Organization name: " READ_ORG
    fi
    
    # Get optional skills repo
    read -rp "  Skills repo URL (optional, press Enter to skip): " READ_SKILLS
    
    # Get work directory
    read -rp "  Work directory [${HOME}/Poincare]: " READ_WORKDIR
    READ_WORKDIR="${READ_WORKDIR:-${HOME}/Poincare}"
    
    # Write .env
    cat > "$ENV_FILE" << EOF
# Organization Configuration
ORG_NAME=${READ_ORG}
WORK_DIR=${READ_WORKDIR}
EOF
    
    if [ -n "$READ_SKILLS" ]; then
      echo "SKILLS_REPO_URL=${READ_SKILLS}" >> "$ENV_FILE"
    fi
    
    ok ".env created"
    echo ""
    load_env
  else
    load_env
  fi
}

# ── check dependencies ───────────────────────────────────────────────
check_deps() {
  header "Checking dependencies"
  
  local missing=0
  for cmd in git gh; do
    if command -v "$cmd" > /dev/null 2>&1; then
      ok "$cmd $(command -v "$cmd")"
    else
      err "$cmd not found"
      missing=$((missing + 1))
    fi
  done
  
  if [ "$missing" -gt 0 ]; then
    echo ""
    err "Install missing dependencies and retry."
    exit 1
  fi
}

# ── check GitHub auth ────────────────────────────────────────────────
check_auth() {
  header "Checking GitHub authentication"
  
  if gh auth status > /dev/null 2>&1; then
    local user
    user=$(gh api user --jq '.login' 2>/dev/null || echo "unknown")
    ok "Authenticated as ${user}"
  else
    err "Not logged in to GitHub CLI."
    echo ""
    echo "  Run: gh auth login"
    exit 1
  fi
}

# ── check organization ───────────────────────────────────────────────
check_org() {
  header "Checking organization"
  
  if gh org view "$ORG_NAME" > /dev/null 2>&1; then
    ok "Organization '${ORG_NAME}' exists"
  else
    err "Organization '${ORG_NAME}' does not exist."
    echo ""
    echo "  ┌─────────────────────────────────────────────────┐"
    echo "  │  Create your organization here:                 │"
    echo "  │                                                 │"
    echo "  │  https://github.com/organizations/new          │"
    echo "  │                                                 │"
    echo "  │  Then re-run this script.                       │"
    echo "  └─────────────────────────────────────────────────┘"
    echo ""
    exit 1
  fi
}

# ── check local state ────────────────────────────────────────────────
check_local() {
  header "Checking local state"
  
  local conflicts=0
  
  for repo in .internal .skills; do
    local dir="${WORK_DIR}/${repo}"
    if [ -d "$dir" ]; then
      local count
      count=$(find "$dir" -mindepth 1 -not -path '*/\.git/*' -not -path '*/\.git' 2>/dev/null | wc -l)
      if [ "$count" -gt 0 ]; then
        err "${repo} exists with content"
        echo "    Location: ${dir}"
        echo "    To reset: rm -rf ${dir}"
        conflicts=$((conflicts + 1))
      fi
    fi
  done
  
  if [ "$conflicts" -gt 0 ]; then
    echo ""
    err "Found ${conflicts} conflict(s). Fix above and retry."
    exit 1
  fi
  
  ok "No conflicts"
}

# ── create repositories ──────────────────────────────────────────────
create_repos() {
  header "Creating repositories"
  
  for repo in .github .internal .skills; do
    if gh repo view "${ORG_NAME}/${repo}" > /dev/null 2>&1; then
      ok "${repo} already exists"
    else
      local visibility="private"
      local desc="Internal team documentation"
      
      if [ "$repo" = ".github" ]; then
        visibility="public"
        desc="GitHub organization profile"
      fi
      
      info "Creating ${repo} (${visibility})..."
      gh repo create "${ORG_NAME}/${repo}" --"${visibility}" --description "$desc" --quiet
      ok "${repo} created"
    fi
  done
}

# ── clone repositories ───────────────────────────────────────────────
clone_repos() {
  header "Cloning repositories"
  
  mkdir -p "$WORK_DIR"
  
  for repo in .github .internal .skills; do
    local target="${WORK_DIR}/${repo}"
    if [ -d "$target" ]; then
      ok "${repo} exists locally"
    else
      info "Cloning ${repo}..."
      git clone "https://github.com/${ORG_NAME}/${repo}.git" "$target" --quiet
      ok "${repo} cloned"
    fi
  done
}

# ── generate base files ──────────────────────────────────────────────
generate_files() {
  header "Generating base files"
  
  # .github profile README
  local profile_dir="${WORK_DIR}/.github/profile"
  mkdir -p "$profile_dir"
  
  cat > "${profile_dir}/README.md" << EOF
# ${ORG_NAME}

> Multi-agent development organization powered by [Achords](https://github.com/cxto21/achords).

## Repositories

| Repo | Purpose |
|------|---------|
| \`.internal\` | Team docs and onboarding |
| \`.skills\` | Shared skills library |
EOF
  ok "Profile README"
  
  # .internal onboarding
  local onboarding_dir="${WORK_DIR}/.internal/onboarding"
  mkdir -p "${onboarding_dir}/scripts"
  mkdir -p "${onboarding_dir}/skills/join-team"
  
  cat > "${onboarding_dir}/README.md" << 'EOF'
# Onboarding

## Quick Start

Run the setup script:
```bash
bash onboarding/scripts/setup.sh
```

Or let your agent do it — point it to:
```
onboarding/skills/join-team/SKILL.md
```

## Files

| File | Purpose |
|------|---------|
| `README.md` | This file |
| `AGENTS.md` | Agent configuration |
| `scripts/setup.sh` | Team member setup |
| `skills/join-team/SKILL.md` | Agent join skill |
EOF
  
  cat > "${onboarding_dir}/AGENTS.md" << 'EOF'
# Agents.md

> Agent configuration and protocols for this organization.

*To be completed by the team.*
EOF
  ok "Onboarding files"
}

# ── import skills if provided ────────────────────────────────────────
import_skills() {
  if [ -n "${SKILLS_REPO_URL:-}" ]; then
    header "Importing skills"
    
    local temp_dir
    temp_dir=$(mktemp -d)
    
    if git clone "$SKILLS_REPO_URL" "$temp_dir" --quiet 2>/dev/null; then
      rm -rf "${WORK_DIR}/.skills"
      mv "$temp_dir" "${WORK_DIR}/.skills"
      ok "Skills imported from ${SKILLS_REPO_URL}"
    else
      warn "Could not clone skills repo"
      echo "  Add it later:"
      echo "    cd ${WORK_DIR}/.skills && git remote add origin ${SKILLS_REPO_URL}"
    fi
    
    rm -rf "$temp_dir"
  fi
}

# ── summary ──────────────────────────────────────────────────────────
summary() {
  echo ""
  echo "  ╔═══════════════════════════════════════════╗"
  echo "  ║  ✓ Setup complete!                        ║"
  echo "  ╚═══════════════════════════════════════════╝"
  echo ""
  echo "  Your organization is ready:"
  echo ""
  echo "    ${WORK_DIR}/"
  echo "    ├── .github/     → Organization profile"
  echo "    ├── .internal/   → Team docs & onboarding"
  echo "    └── .skills/     → Shared skills library"
  echo ""
  echo "  Next steps:"
  echo "    1. Edit ${WORK_DIR}/.github/profile/README.md"
  echo "    2. Add team members to ${WORK_DIR}/.internal/"
  echo "    3. Start adding skills to ${WORK_DIR}/.skills/"
  echo ""
}

# ── main ─────────────────────────────────────────────────────────────
main() {
  echo "$BANNER"
  echo "  Version: ${VERSION}"
  echo ""
  
  # Get org name from arg
  if [ $# -ge 1 ]; then
    ORG_NAME="$1"
  fi
  
  # Setup .env
  setup_env
  
  # Default work dir
  WORK_DIR="${WORK_DIR:-${HOME}/Poincare}"
  
  # Run checks and setup
  check_deps
  check_auth
  check_org
  check_local
  create_repos
  clone_repos
  generate_files
  import_skills
  summary
}

main "$@"
