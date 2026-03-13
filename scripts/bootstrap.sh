#!/bin/bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash "$REPO_DIR/scripts/install_dependencies.sh"
bash "$REPO_DIR/vim-manager" install
