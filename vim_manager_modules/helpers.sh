#!/bin/bash

# ============================================================================
# Vim Manager - Helper Functions Module
# ============================================================================

# --- Helper Functions ---
success() { echo -e "${GREEN}✓ $1${NC}"; }
warning() { echo -e "${YELLOW}⚠ $1${NC}"; }
error() { echo -e "${RED}✗ $1${NC}"; }
info() { echo -e "${BLUE}ℹ $1${NC}"; }
header() { echo -e "${PURPLE}== $1 ==${NC}"; }

command_exists() {
    command -v "$1" >/dev/null 2>&1
}
