#!/usr/bin/env bash
# ============================================================
# OpenClaw Team Setup — Recruiter Edition
# ============================================================
# Deploys a team of 4 agents for AI-powered recruiting:
# Headhunter, Interviewer, Coordinator, Compliance.
#
# Usage:
#   ./setup.sh                    # Interactive setup
#   ./setup.sh --clean            # Wipe and reinstall
#   ./setup.sh --uninstall        # Remove everything
#   ./setup.sh --vision "text"    # Set the vision inline
# ============================================================

set -euo pipefail

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

OPENCLAW_DIR="${OPENCLAW_DIR:-$HOME/.openclaw}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

AGENTS=("red-headhunter" "yellow-interviewer" "green-coordinator" "blue-compliance")
AGENT_COLORS=("${RED}" "${YELLOW}" "${GREEN}" "${BLUE}")
AGENT_NAMES=("Headhunter" "Interviewer" "Coordinator" "Compliance")
AGENT_ROLES=("Sourcing & Pipeline" "Interview Design" "Scheduling & Comms" "EEO Compliance")

SKILLS=(
    "candidate-screening"
    "interview-design"
    "job-description"
    "pipeline-management"
    "eeo-compliance"
    "team-standup"
    "daily-report"
    "vision-sync"
)

banner() {
    echo ""
    echo -e "${BOLD}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║  ${RED}●${NC} ${YELLOW}●${NC} ${GREEN}●${NC} ${BLUE}●${NC}  ${BOLD}OpenClaw Team Setup                  ║${NC}"
    echo -e "${BOLD}║        Recruiter Edition                              ║${NC}"
    echo -e "${BOLD}║                                                       ║${NC}"
    echo -e "${BOLD}║  ${DIM}Sourcing · Interviews · Pipeline · Compliance${NC}${BOLD}      ║${NC}"
    echo -e "${BOLD}╚═══════════════════════════════════════════════════════╝${NC}"
    echo ""
}

log_step() { echo -e "\n${BOLD}[SETUP]${NC} $1"; }
log_ok() { echo -e "  ${GREEN}✓${NC} $1"; }
log_warn() { echo -e "  ${YELLOW}!${NC} $1"; }
log_agent() { echo -e "  ${1}●${NC} ${BOLD}${2}${NC}: ${3}"; }

check_openclaw() {
    log_step "Checking prerequisites..."
    if command -v openclaw &> /dev/null; then
        log_ok "openclaw found: $(which openclaw)"
    else
        log_warn "'openclaw' not found — continuing with file deployment"
    fi
}

clean_install() {
    echo -e "${RED}[WARN]${NC} This will remove ALL Recruiter agent data!"
    read -p "  Are you sure? (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        log_step "Cleaning existing installation..."
        for agent in "${AGENTS[@]}"; do
            rm -rf "${OPENCLAW_DIR}/workspace-${agent}"
            log_ok "Removed workspace-${agent}"
        done
        for skill in "${SKILLS[@]}"; do
            rm -rf "${OPENCLAW_DIR}/skills/${skill}"
        done
        rm -rf "${OPENCLAW_DIR}/shared"
    else
        echo "  Aborted."; exit 0
    fi
}

uninstall() {
    log_step "Uninstalling Recruiter team..."
    for agent in "${AGENTS[@]}"; do rm -rf "${OPENCLAW_DIR}/workspace-${agent}"; done
    for skill in "${SKILLS[@]}"; do rm -rf "${OPENCLAW_DIR}/skills/${skill}"; done
    rm -rf "${OPENCLAW_DIR}/shared"
    echo -e "\n${GREEN}Uninstall complete.${NC}"; exit 0
}

create_directories() {
    log_step "Creating directory structure..."
    mkdir -p "${OPENCLAW_DIR}"; chmod 700 "${OPENCLAW_DIR}"
    for agent in "${AGENTS[@]}"; do mkdir -p "${OPENCLAW_DIR}/workspace-${agent}/memory"; done
    mkdir -p "${OPENCLAW_DIR}/shared/candidates" "${OPENCLAW_DIR}/skills"
    log_ok "Directory structure created"
}

deploy_config() {
    log_step "Deploying openclaw.json..."
    local config_file="${OPENCLAW_DIR}/openclaw.json"
    [[ -f "${config_file}" ]] && cp "${config_file}" "${config_file}.backup.$(date +%Y%m%d%H%M%S)" && log_ok "Backed up existing config"
    cp "${SCRIPT_DIR}/openclaw.json" "${config_file}"; chmod 600 "${config_file}"
    log_ok "Deployed openclaw.json"
}

deploy_agent_files() {
    log_step "Deploying agent workspaces..."
    for i in "${!AGENTS[@]}"; do
        local agent="${AGENTS[$i]}" workspace="${OPENCLAW_DIR}/workspace-${AGENTS[$i]}" source="${SCRIPT_DIR}/agents/${AGENTS[$i]}"
        for file in SOUL.md IDENTITY.md AGENTS.md HEARTBEAT.md USER.md; do
            [[ -f "${source}/${file}" ]] && cp "${source}/${file}" "${workspace}/${file}"
        done
        ln -sfn "${OPENCLAW_DIR}/shared" "${workspace}/shared"
        log_agent "${AGENT_COLORS[$i]}" "${AGENT_NAMES[$i]}" "${AGENT_ROLES[$i]}"
    done
    log_ok "All agent workspaces deployed"
}

deploy_shared_files() {
    log_step "Deploying shared workspace..."
    cp "${SCRIPT_DIR}/shared/VISION.md" "${OPENCLAW_DIR}/shared/VISION.md"
    cp "${SCRIPT_DIR}/shared/standup-log.md" "${OPENCLAW_DIR}/shared/standup-log.md"
    log_ok "Shared files deployed"
}

deploy_skills() {
    log_step "Installing skills..."
    for skill in "${SKILLS[@]}"; do
        local source="${SCRIPT_DIR}/shared/skills/${skill}/SKILL.md" dest="${OPENCLAW_DIR}/skills/${skill}"
        if [[ -f "${source}" ]]; then mkdir -p "${dest}"; cp "${source}" "${dest}/SKILL.md"; log_ok "${skill}"
        else log_warn "${skill} — source not found"; fi
    done
}

print_summary() {
    echo ""
    echo -e "${BOLD}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║  Setup Complete!                                      ║${NC}"
    echo -e "${BOLD}╚═══════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BOLD}Your team:${NC}"
    echo -e "  ${RED}● Headhunter${NC}  (Red)    — Sources candidates, drives pipeline"
    echo -e "  ${YELLOW}● Interviewer${NC} (Yellow) — Designs questions, writes JDs"
    echo -e "  ${GREEN}● Coordinator${NC} (Green)  — Scheduling, follow-ups, pipeline tracking"
    echo -e "  ${BLUE}● Compliance${NC}  (Blue)   — EEO tracking, bias detection (read-only)"
    echo ""
    echo -e "${BOLD}Next steps:${NC}"
    echo "  1. Edit ${OPENCLAW_DIR}/shared/VISION.md with your role details"
    echo "  2. Update USER.md in each agent workspace"
    echo "  3. Run: openclaw start"
    echo ""
}

banner

VISION_TEXT=""; DO_CLEAN=false; DO_UNINSTALL=false
while [[ $# -gt 0 ]]; do
    case "$1" in
        --clean) DO_CLEAN=true; shift ;;
        --uninstall) DO_UNINSTALL=true; shift ;;
        --vision) shift; VISION_TEXT="${1:-}"; shift ;;
        *) shift ;;
    esac
done

[[ "$DO_UNINSTALL" == true ]] && uninstall
[[ "$DO_CLEAN" == true ]] && clean_install

check_openclaw; create_directories; deploy_config; deploy_agent_files; deploy_shared_files; deploy_skills; print_summary
