#!/usr/bin/env bash
set -euo pipefail

# ============================================
#  PassGen Installer
#  Sets permissions & installs system-wide
# ============================================

INSTALL_DIR="/usr/local/bin"
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

# ── Colors ──────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# ── Functions ───────────────────────────────
info()    { echo -e "${CYAN}[*]${NC} $1"; }
success() { echo -e "${GREEN}[✔]${NC} $1"; }
warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
error()   { echo -e "${RED}[✘]${NC} $1"; exit 1; }

# ── Banner ──────────────────────────────────
echo ""
echo -e "${BOLD}${CYAN}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║        PassGen Installer             ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${NC}"

# ── Check sudo ──────────────────────────────
if [[ $EUID -ne 0 ]]; then
    error "This installer requires root privileges.\n   Run again with: ${BOLD}sudo ./install.sh${NC}"
fi

# ── Verify project files exist ──────────────
info "Verifying project files..."

if [[ ! -f "$SCRIPT_DIR/passgen" ]]; then
    error "Missing file: passgen (main script not found)"
fi

for lib_file in utils.sh help.sh generator.sh banner.sh strength.sh; do
    if [[ ! -f "$SCRIPT_DIR/passgen-lib/$lib_file" ]]; then
        error "Missing file: passgen-lib/$lib_file"
    fi
done

success "All project files found."

# ── Set execute permissions ─────────────────
info "Setting execute permissions..."

chmod +x "$SCRIPT_DIR/passgen"
chmod +x "$SCRIPT_DIR/passgen-lib"/*.sh

success "Permissions set on passgen and passgen-lib/*.sh"

# ── Remove old installation (if exists) ─────
if [[ -f "$INSTALL_DIR/passgen" ]] || [[ -d "$INSTALL_DIR/passgen-lib" ]]; then
    warn "Previous installation detected. Removing..."
    rm -f  "$INSTALL_DIR/passgen"
    rm -rf "$INSTALL_DIR/passgen-lib"
    success "Old installation removed."
fi

# ── Install system-wide ────────────────────
info "Installing passgen to ${INSTALL_DIR}/..."

cp "$SCRIPT_DIR/passgen" "$INSTALL_DIR/passgen"
cp -r "$SCRIPT_DIR/passgen-lib" "$INSTALL_DIR/passgen-lib"

# Ensure permissions are correct after copy
chmod +x "$INSTALL_DIR/passgen"
chmod +x "$INSTALL_DIR/passgen-lib"/*.sh

success "Files installed successfully."

# ── Verify installation ────────────────────
info "Verifying installation..."

if command -v passgen &>/dev/null; then
    success "passgen is now available system-wide!"
else
    warn "passgen was installed but may not be in your PATH."
    warn "Make sure ${INSTALL_DIR} is in your PATH variable."
fi

# ── Final layout ───────────────────────────
echo ""
echo -e "${BOLD}${GREEN}  Installation Complete! ${NC}"
echo ""
echo -e "  ${CYAN}Final layout:${NC}"
echo -e "  ${INSTALL_DIR}/"
echo -e "  ├── passgen"
echo -e "  └── passgen-lib/"
echo -e "      ├── utils.sh"
echo -e "      ├── help.sh"
echo -e "      ├── generator.sh"
echo -e "      ├── banner.sh"
echo -e "      └── strength.sh"
echo ""
echo -e "  ${BOLD}Usage:${NC}"
echo -e "    passgen            ${CYAN}# Run the generator${NC}"
echo -e "    passgen --help     ${CYAN}# Show help${NC}"
echo -e "    passgen --version  ${CYAN}# Show version${NC}"
echo ""
