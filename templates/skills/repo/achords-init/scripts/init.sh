#!/bin/bash
# achords-init.sh - Bootstrap Achords protocol in a repository

set -e

echo "=== Achords Init ==="

# Check if .achords already exists
if [ -d .achords ]; then
    echo "✗ .achords/ already exists"
    echo "  Use agent-union skill to register agents"
    exit 1
fi

echo "✓ Creating .achords/ directory structure..."
mkdir -p .achords/{agents,supervisor,schemas,skills}

echo "✓ Initializing protocol files..."

# version.json
cat > .achords/version.json << 'EOF'
{
  "achords_version": "1.0.0",
  "spec_date": "2026-07-04",
  "repo_initialized": "2026-07-04T00:00:00Z",
  "protocol_status": "active",
  "notes": "MVP baseline with Agent Skills integration"
}
EOF

# registry.json
cat > .achords/registry.json << 'EOF'
{
  "agents": [],
  "last_updated": "2026-07-04T00:00:00Z",
  "notes": "Agents are registered here via agent-union skill before making contributions"
}
EOF

# claims.json
cat > .achords/claims.json << 'EOF'
{
  "claims": [],
  "last_updated": "2026-07-04T00:00:00Z",
  "notes": "Active, released, and expired claims tracked here"
}
EOF

# supervisor/state.json
cat > .achords/supervisor/state.json << 'EOF'
{
  "mode": "advisory",
  "enabled": true,
  "last_alignment_check": "2026-07-04T00:00:00Z",
  "alignment_status": "initialized",
  "pending_reviews": [],
  "blocked_merges": []
}
EOF

# events.ndjson
echo '{"type":"bootstrap","timestamp":"2026-07-04T00:00:00Z","message":"Achords protocol initialized","version":"1.0.0"}' > .achords/events.ndjson

echo "✓ Achords initialization complete"
echo ""
echo "Next steps:"
echo "1. Register agents: python .achords/skills/agent-union/scripts/register-agent.py"
echo "2. Declare claims: python .achords/skills/claim-declaration/scripts/declare-claim.py"
echo "3. Commit: git add .achords/ && git commit -m 'feat: bootstrap Achords protocol'"
