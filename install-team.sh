#!/usr/bin/env bash

# ============================================================
# OpenClaw Team Installer
# ============================================================
# Deploys an agent team into an existing OpenClaw installation.
# Run this after bootstrap.sh + OpenClaw install + onboard.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/zenithventure/openclaw-agent-teams/main/install-team.sh \
#     | bash -s -- --team operator
#
# Full:
#   curl -fsSL ... | bash -s -- \
#     --team operator \
#     --api-key sk-ant-...
#
# Flags:
#   --team <name>     Required. Team to deploy (operator, product-builder, etc.)
#   --api-key <key>   Anthropic API key (default: leave .env as template)
#   --help            Show this help
# ============================================================

if [[ "${1:-}" == "--help" ]]; then
    sed -n '/^# Usage:/,/^# ====/p' "$0" | sed 's/^# \?//'
    exit 0
fi

set -euo pipefail

# ── Colors ─────────────────────────────────────────────────
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# ── Logging ────────────────────────────────────────────────

log_step() {
    echo -e "\n${BOLD}$1${NC}"
}

log_ok() {
    echo -e "  ${GREEN}✓${NC} $1"
}

log_warn() {
    echo -e "  ${YELLOW}!${NC} $1"
}

log_err() {
    echo -e "  ${RED}✗${NC} $1"
}

# ── Cleanup Trap ───────────────────────────────────────────
CLONE_DIR=""
cleanup() {
    if [[ -n "$CLONE_DIR" && -d "$CLONE_DIR" ]]; then
        rm -rf "$CLONE_DIR"
    fi
}
trap cleanup EXIT

# ── Banner ─────────────────────────────────────────────────

banner() {
    echo ""
    echo -e "${BOLD}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║  ${RED}●${NC} ${YELLOW}●${NC} ${GREEN}●${NC} ${BLUE}●${NC}  ${BOLD}OpenClaw Team Installer               ║${NC}"
    echo -e "${BOLD}║        Deploy an agent team                           ║${NC}"
    echo -e "${BOLD}╚═══════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# ── Parse Arguments ────────────────────────────────────────

TEAM=""
API_KEY=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --team)
            shift; TEAM="${1:-}"
            ;;
        --api-key)
            shift; API_KEY="${1:-}"
            ;;
        *)
            log_err "Unknown flag: $1"
            exit 1
            ;;
    esac
    shift
done

# ── Validate ───────────────────────────────────────────────

VALID_TEAMS="product-builder accountant recruiter real-estate modernizer operator"

if [[ -z "$TEAM" ]]; then
    log_err "--team is required"
    echo ""
    echo "  Available teams: ${VALID_TEAMS}"
    echo ""
    echo "  Example:"
    echo "    curl -fsSL https://raw.githubusercontent.com/zenithventure/openclaw-agent-teams/main/install-team.sh \\"
    echo "      | bash -s -- --team operator"
    exit 1
fi

# Validate team name
TEAM_VALID=false
for t in $VALID_TEAMS; do
    if [[ "$t" == "$TEAM" ]]; then
        TEAM_VALID=true
        break
    fi
done
if [[ "$TEAM_VALID" != true ]]; then
    log_err "Unknown team: $TEAM"
    echo "  Available teams: ${VALID_TEAMS}"
    exit 1
fi

# Must be root
if [[ "$(id -u)" -ne 0 ]]; then
    log_err "This script must be run as root"
    exit 1
fi

# Verify openclaw user exists
if ! id openclaw &>/dev/null; then
    log_err "User 'openclaw' does not exist. Run bootstrap.sh first."
    exit 1
fi

OPENCLAW_HOME="/home/openclaw"
OPENCLAW_DIR="${OPENCLAW_HOME}/.openclaw"

# Verify OpenClaw is installed
if ! sudo -u openclaw -H bash -c 'command -v openclaw' &>/dev/null; then
    log_err "OpenClaw binary not found for user 'openclaw'."
    echo "  Install it first:"
    echo "    sudo -u openclaw -i"
    echo "    curl -fsSL https://openclaw.ai/install.sh | bash"
    echo "    openclaw onboard"
    echo "    exit"
    exit 1
fi

# ── Preflight ──────────────────────────────────────────────

banner

echo -e "${BOLD}Configuration:${NC}"
echo -e "  Team:    ${GREEN}${TEAM}${NC}"
echo -e "  API key: ${GREEN}${API_KEY:+<provided>}${API_KEY:-<not set — configure later>}${NC}"
echo ""

# ============================================================
# Deploy Team
# ============================================================

log_step "Deploying team: ${TEAM}..."

REPO_URL="https://github.com/zenithventure/openclaw-agent-teams.git"

# ── Clone repo ─────────────────────────────────────────────
clone_repo() {
    log_step "  Cloning agent teams repo..."

    CLONE_DIR=$(mktemp -d)
    git clone --depth 1 "$REPO_URL" "$CLONE_DIR" > /dev/null 2>&1
    chown -R openclaw:openclaw "$CLONE_DIR"
    log_ok "Cloned to ${CLONE_DIR}"
}

# ── Run team setup.sh ──────────────────────────────────────
run_team_setup() {
    log_step "  Running ${TEAM}/setup.sh..."

    if [[ ! -f "${CLONE_DIR}/${TEAM}/setup.sh" ]]; then
        log_err "setup.sh not found at ${CLONE_DIR}/${TEAM}/setup.sh"
        exit 1
    fi

    sudo -u openclaw -H bash "${CLONE_DIR}/${TEAM}/setup.sh"
    log_ok "Team setup complete"
}

# ── Configure API key ──────────────────────────────────────
configure_api_key() {
    if [[ -n "$API_KEY" ]]; then
        log_step "  Setting Anthropic API key..."

        local env_file="${OPENCLAW_DIR}/.env"
        if [[ -f "$env_file" ]]; then
            # Uncomment and set the key
            if grep -q "^# ANTHROPIC_API_KEY=" "$env_file"; then
                sed -i "s|^# ANTHROPIC_API_KEY=.*|ANTHROPIC_API_KEY=${API_KEY}|" "$env_file"
            elif grep -q "^ANTHROPIC_API_KEY=" "$env_file"; then
                sed -i "s|^ANTHROPIC_API_KEY=.*|ANTHROPIC_API_KEY=${API_KEY}|" "$env_file"
            else
                echo "ANTHROPIC_API_KEY=${API_KEY}" >> "$env_file"
            fi
        else
            mkdir -p "$(dirname "$env_file")"
            echo "ANTHROPIC_API_KEY=${API_KEY}" > "$env_file"
        fi

        chmod 600 "$env_file"
        chown openclaw:openclaw "$env_file"
        log_ok "API key configured"
    else
        log_warn "No --api-key provided — edit ${OPENCLAW_DIR}/.env later"
    fi
}

# ── Fix ownership ──────────────────────────────────────────
fix_ownership() {
    log_step "  Fixing file ownership..."

    chown -R openclaw:openclaw "${OPENCLAW_DIR}"
    chown -R openclaw:openclaw "${OPENCLAW_HOME}"
    log_ok "Ownership set to openclaw:openclaw"
}

clone_repo
run_team_setup
configure_api_key
fix_ownership

# ============================================================
# Summary
# ============================================================

echo ""
echo -e "${BOLD}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║  Team Deployed!                                       ║${NC}"
echo -e "${BOLD}╚═══════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BOLD}What was done:${NC}"
echo -e "  ${GREEN}✓${NC} Team deployed: ${BOLD}${TEAM}${NC}"
if [[ -n "$API_KEY" ]]; then
    echo -e "  ${GREEN}✓${NC} API key configured"
else
    echo -e "  ${YELLOW}!${NC} API key not set — edit ${OPENCLAW_DIR}/.env"
fi
echo -e "  ${GREEN}✓${NC} File ownership set to openclaw:openclaw"
echo ""
echo -e "${BOLD}Next steps:${NC}"
echo ""
echo -e "  1. ${YELLOW}Start the gateway:${NC}"
echo -e "     sudo -u openclaw -i openclaw gateway start"
echo ""
echo -e "  2. ${YELLOW}Edit your vision:${NC}"
echo -e "     sudo -u openclaw nano ${OPENCLAW_DIR}/shared/VISION.md"
echo ""
echo -e "  ${DIM}•${NC} Service management:"
echo -e "     sudo -u openclaw -i openclaw gateway status"
echo -e "     sudo -u openclaw -i openclaw gateway restart"
echo -e "     sudo -u openclaw -i openclaw gateway logs"
echo ""
