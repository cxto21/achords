#!/usr/bin/env bash
# Achords — Organization Bootstrap Script
# Creates the initial repository structure for a new organization.
#
# Usage:
#   bash bootstrap.sh <org-name> [skills-repo-url]
#
# Examples:
#   bash bootstrap.sh Poincare-Space
#   bash bootstrap.sh Poincare-Space https://github.com/myorg/team-skills.git

set -euo pipefail

# ── helpers ──────────────────────────────────────────────────────────
info()  { printf "\033[1;34m%s\033[0m %s\n" ">>>" "$*"; }
ok()    { printf "\033[1;32m%s\033[0m %s\n" "OK" "$*"; }
warn()  { printf "\033[1;33m%s\033[0m %s\n" "WARN" "$*"; }
err()   { printf "\033[1;31m%s\033[0m %s\n" "ERR" "$*" >&2; }

# ── config ───────────────────────────────────────────────────────────
if [ $# -lt 1 ]; then
  echo "Usage: bash bootstrap.sh <org-name> [skills-repo-url]"
  echo ""
  echo "Examples:"
  echo "  bash bootstrap.sh Poincare-Space"
  echo "  bash bootstrap.sh Poincare-Space https://github.com/myorg/team-skills.git"
  exit 1
fi

ORG="$1"
SKILLS_URL="${2:-}"
POINCARE_DIR="${HOME}/Poincare"

echo "Achords — Organization Bootstrap"
echo "================================"
echo "Organization: ${ORG}"
if [ -n "$SKILLS_URL" ]; then
  echo "Skills repo:  ${SKILLS_URL}"
fi
echo ""

# Check dependencies
for cmd in git gh; do
  if ! command -v "$cmd" > /dev/null 2>&1; then
    err "Missing: $cmd"
    exit 1
  fi
done

# Check GitHub auth
if ! gh auth status > /dev/null 2>&1; then
  err "Not logged in to GitHub CLI."
  echo "  Run: gh auth login"
  exit 1
fi

ok "Dependencies OK"
echo ""

# Create base directory
mkdir -p "$POINCARE_DIR"

# ── .github ──────────────────────────────────────────────────────────
info "Setting up .github..."

if gh repo view "${ORG}/.github" > /dev/null 2>&1; then
  ok ".github exists on GitHub"
else
  info "Creating .github on GitHub..."
  gh repo create "${ORG}/.github" --public --description "GitHub organization profile" --quiet
  ok ".github created"
fi

GITHUB_DIR="${POINCARE_DIR}/.github"
if [ -d "$GITHUB_DIR" ]; then
  ok ".github exists locally"
else
  info "Cloning .github..."
  git clone "https://github.com/${ORG}/.github.git" "$GITHUB_DIR" --quiet
  ok ".github cloned"
fi

# Generate profile README
PROFILE_DIR="${GITHUB_DIR}/profile"
mkdir -p "$PROFILE_DIR"
echo "# ${ORG}" > "${PROFILE_DIR}/README.md"
echo "" >> "${PROFILE_DIR}/README.md"
echo "> Multi-agent development organization." >> "${PROFILE_DIR}/README.md"
ok "Profile README generated"
echo ""

# ── .internal ────────────────────────────────────────────────────────
info "Setting up .internal..."

if gh repo view "${ORG}/.internal" > /dev/null 2>&1; then
  ok ".internal exists on GitHub"
else
  info "Creating .internal on GitHub..."
  gh repo create "${ORG}/.internal" --private --description "Internal team documentation" --quiet
  ok ".internal created"
fi

INTERNAL_DIR="${POINCARE_DIR}/.internal"
if [ -d "$INTERNAL_DIR" ]; then
  # Check if it has content (more than just .git)
  CONTENT_COUNT=$(find "$INTERNAL_DIR" -mindepth 1 -not -path '*/\.git/*' -not -path '*/\.git' 2>/dev/null | wc -l)
  if [ "$CONTENT_COUNT" -gt 0 ]; then
    warn ".internal exists locally with content — skipping"
    warn "To reset: rm -rf ${INTERNAL_DIR} && bash $0 ${ORG}"
  else
    ok ".internal exists locally (empty)"
  fi
else
  info "Cloning .internal..."
  git clone "https://github.com/${ORG}/.internal.git" "$INTERNAL_DIR" --quiet
  ok ".internal cloned"

  # Generate onboarding files (only if empty)
  ONBOARDING_DIR="${INTERNAL_DIR}/onboarding"
  mkdir -p "${ONBOARDING_DIR}/scripts"
  mkdir -p "${ONBOARDING_DIR}/skills/join-team"

  echo "# Onboarding" > "${ONBOARDING_DIR}/README.md"
  echo "" >> "${ONBOARDING_DIR}/README.md"
  echo "Run: bash onboarding/scripts/setup.sh" >> "${ONBOARDING_DIR}/README.md"

  echo "# Agents.md" > "${ONBOARDING_DIR}/AGENTS.md"
  echo "" >> "${ONBOARDING_DIR}/AGENTS.md"
  echo "Agent configuration placeholder." >> "${ONBOARDING_DIR}/AGENTS.md"

  ok "Onboarding files generated"
fi
echo ""

# ── .skills ──────────────────────────────────────────────────────────
info "Setting up .skills..."

if gh repo view "${ORG}/.skills" > /dev/null 2>&1; then
  ok ".skills exists on GitHub"
else
  info "Creating .skills on GitHub..."
  gh repo create "${ORG}/.skills" --private --description "Agent skills library" --quiet
  ok ".skills created"
fi

SKILLS_DIR="${POINCARE_DIR}/.skills"
if [ -d "$SKILLS_DIR" ]; then
  # Check if it has content
  CONTENT_COUNT=$(find "$SKILLS_DIR" -mindepth 1 -not -path '*/\.git/*' -not -path '*/\.git' 2>/dev/null | wc -l)
  if [ "$CONTENT_COUNT" -gt 0 ]; then
    ok ".skills exists locally with content"
    if [ -n "$SKILLS_URL" ]; then
      warn "Skills repo URL provided but .skills already has content"
      warn "To import: rm -rf ${SKILLS_DIR} && bash $0 ${ORG} ${SKILLS_URL}"
    fi
  else
    ok ".skills exists locally (empty)"
  fi
else
  info "Cloning .skills..."
  git clone "https://github.com/${ORG}/.skills.git" "$SKILLS_DIR" --quiet
  ok ".skills cloned"
fi

# Clone skills repo if provided and .skills is empty
if [ -n "$SKILLS_URL" ]; then
  CONTENT_COUNT=$(find "$SKILLS_DIR" -mindepth 1 -not -path '*/\.git/*' -not -path '*/\.git' 2>/dev/null | wc -l)
  if [ "$CONTENT_COUNT" -eq 0 ]; then
    info "Importing skills from ${SKILLS_URL}..."
    TEMP_DIR=$(mktemp -d)
    if git clone "$SKILLS_URL" "$TEMP_DIR" --quiet 2>/dev/null; then
      # Move contents (including .git)
      rm -rf "${SKILLS_DIR:?}"
      mv "$TEMP_DIR" "$SKILLS_DIR"
      ok "Skills imported"
    else
      warn "Could not clone skills repo"
      echo "  You can add it later:"
      echo "    cd ${SKILLS_DIR} && git remote add origin ${SKILLS_URL} && git pull origin main"
    fi
    rm -rf "$TEMP_DIR"
  fi
fi
echo ""

# ── summary ──────────────────────────────────────────────────────────
ok "Bootstrap complete!"
echo ""
echo "Structure:"
echo "  ~/Poincare/${ORG}/"
echo "  ├── .github/"
echo "  ├── .internal/"
echo "  └── .skills/"
echo ""
echo "Next steps:"
echo "  1. Edit ~/Poincare/${ORG}/.github/profile/README.md"
echo "  2. Edit ~/Poincare/${ORG}/.internal/onboarding/AGENTS.md"
if [ -n "$SKILLS_URL" ]; then
  echo "  3. Skills loaded from ${SKILLS_URL}"
else
  echo "  3. Add skills to ~/Poincare/${ORG}/.skills/"
fi
