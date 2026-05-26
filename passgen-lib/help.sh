#!/usr/bin/env bash

VERSION="2.0.0"
TOOL_NAME="passgen"

# ── CLI State Variables ────────────────────
CLI_LENGTH=""
CLI_COUNT=1
CLI_SAVE=false
CLI_OUTPUT=""
CLI_COPY=false
CLI_ALL=false
CLI_NO_LOWER=false
CLI_NO_UPPER=false
CLI_NO_NUMS=false
CLI_NO_SYMBOLS=false
CLI_PRESET=""
CLI_NON_INTERACTIVE=false

# ── Colors ─────────────────────────────────
C_CYAN='\033[0;36m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_MAGENTA='\033[1;35m'
C_BOLD='\033[1m'
C_DIM='\033[2m'
C_NC='\033[0m'

show_help() {
cat << EOF

$(echo -e "${C_BOLD}${C_CYAN}")  ╔══════════════════════════════════════════════╗
  ║          $TOOL_NAME - Secure Password Generator       ║
  ╚══════════════════════════════════════════════╝$(echo -e "${C_NC}")

$(echo -e "${C_BOLD}")  Usage:$(echo -e "${C_NC}")
    $TOOL_NAME [options]

$(echo -e "${C_BOLD}")  General Options:$(echo -e "${C_NC}")
    $(echo -e "${C_GREEN}")-h, --help$(echo -e "${C_NC}")                Show this help message and exit
    $(echo -e "${C_GREEN}")-v, --version$(echo -e "${C_NC}")             Show version information and exit

$(echo -e "${C_BOLD}")  Generation Options:$(echo -e "${C_NC}")
    $(echo -e "${C_GREEN}")-l, --length $(echo -e "${C_YELLOW}")<N>$(echo -e "${C_NC}")          Set password length (skip prompt)
    $(echo -e "${C_GREEN}")-c, --count $(echo -e "${C_YELLOW}")<N>$(echo -e "${C_NC}")           Generate multiple passwords (default: 1)
    $(echo -e "${C_GREEN}")--all$(echo -e "${C_NC}")                     Include all character types
    $(echo -e "${C_GREEN}")--no-lower$(echo -e "${C_NC}")                Exclude lowercase letters
    $(echo -e "${C_GREEN}")--no-upper$(echo -e "${C_NC}")                Exclude uppercase letters
    $(echo -e "${C_GREEN}")--no-nums$(echo -e "${C_NC}")                 Exclude numbers
    $(echo -e "${C_GREEN}")--no-symbols$(echo -e "${C_NC}")              Exclude special symbols

$(echo -e "${C_BOLD}")  Output Options:$(echo -e "${C_NC}")
    $(echo -e "${C_GREEN}")-s, --save$(echo -e "${C_NC}")                Auto-save password without asking
    $(echo -e "${C_GREEN}")-o, --output $(echo -e "${C_YELLOW}")<file>$(echo -e "${C_NC}")      Save password to a specific file
    $(echo -e "${C_GREEN}")--copy$(echo -e "${C_NC}")                    Copy password to clipboard

$(echo -e "${C_BOLD}")  Presets:$(echo -e "${C_NC}")
    $(echo -e "${C_GREEN}")--preset $(echo -e "${C_YELLOW}")pin$(echo -e "${C_NC}")              4-digit numeric PIN
    $(echo -e "${C_GREEN}")--preset $(echo -e "${C_YELLOW}")strong$(echo -e "${C_NC}")           20 chars, all character types
    $(echo -e "${C_GREEN}")--preset $(echo -e "${C_YELLOW}")wifi$(echo -e "${C_NC}")             63 chars, alphanumeric
    $(echo -e "${C_GREEN}")--preset $(echo -e "${C_YELLOW}")memorable$(echo -e "${C_NC}")        16 chars, lowercase + numbers

$(echo -e "${C_BOLD}")  Description:$(echo -e "${C_NC}")
    Interactive secure password generator using /dev/urandom.
    Run without options for interactive mode, or use flags for
    quick non-interactive generation.

$(echo -e "${C_BOLD}")  Security:$(echo -e "${C_NC}")
    $(echo -e "${C_DIM}")•$(echo -e "${C_NC}") Cryptographically secure randomness via /dev/urandom
    $(echo -e "${C_DIM}")•$(echo -e "${C_NC}") Saved passwords use permission 600 (owner read/write only)
    $(echo -e "${C_DIM}")•$(echo -e "${C_NC}") Password strength meter after each generation

$(echo -e "${C_BOLD}")  Examples:$(echo -e "${C_NC}")
    $(echo -e "${C_DIM}")# Interactive mode$(echo -e "${C_NC}")
    $TOOL_NAME

    $(echo -e "${C_DIM}")# Generate a 16-char password with all character types$(echo -e "${C_NC}")
    $TOOL_NAME -l 16 --all

    $(echo -e "${C_DIM}")# Generate 5 strong passwords and save them$(echo -e "${C_NC}")
    $TOOL_NAME -l 20 --all -c 5 --save

    $(echo -e "${C_DIM}")# Quick PIN generation$(echo -e "${C_NC}")
    $TOOL_NAME --preset pin

    $(echo -e "${C_DIM}")# Generate and copy to clipboard$(echo -e "${C_NC}")
    $TOOL_NAME -l 24 --all --copy

    $(echo -e "${C_DIM}")# Save to specific file$(echo -e "${C_NC}")
    $TOOL_NAME -l 12 --all -o my_password.txt

$(echo -e "${C_BOLD}${C_MAGENTA}")  Tips:$(echo -e "${C_NC}")
    $(echo -e "${C_YELLOW}")★$(echo -e "${C_NC}") Use at least 12 characters for strong passwords
    $(echo -e "${C_YELLOW}")★$(echo -e "${C_NC}") Mix all character types for maximum entropy
    $(echo -e "${C_YELLOW}")★$(echo -e "${C_NC}") Use --preset strong for a quick secure password
    $(echo -e "${C_YELLOW}")★$(echo -e "${C_NC}") Never reuse passwords across different accounts

$(echo -e "${C_BOLD}")  Author:$(echo -e "${C_NC}")
    x606

EOF
}

show_version() {
    echo -e "${C_BOLD}${C_CYAN}$TOOL_NAME${C_NC} version ${C_GREEN}$VERSION${C_NC}"
}

handle_cli() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
                ;;
            -v|--version)
                show_version
                exit 0
                ;;
            -l|--length)
                if [[ -z "${2:-}" ]] || [[ ! "$2" =~ ^[0-9]+$ ]] || [[ "$2" -le 0 ]]; then
                    echo -e "${C_YELLOW}[ERROR]${C_NC} --length requires a positive number."
                    exit 1
                fi
                CLI_LENGTH="$2"
                CLI_NON_INTERACTIVE=true
                shift
                ;;
            -c|--count)
                if [[ -z "${2:-}" ]] || [[ ! "$2" =~ ^[0-9]+$ ]] || [[ "$2" -le 0 ]]; then
                    echo -e "${C_YELLOW}[ERROR]${C_NC} --count requires a positive number."
                    exit 1
                fi
                CLI_COUNT="$2"
                shift
                ;;
            -s|--save)
                CLI_SAVE=true
                ;;
            -o|--output)
                if [[ -z "${2:-}" ]]; then
                    echo -e "${C_YELLOW}[ERROR]${C_NC} --output requires a file path."
                    exit 1
                fi
                CLI_OUTPUT="$2"
                CLI_SAVE=true
                shift
                ;;
            --copy)
                CLI_COPY=true
                ;;
            --all)
                CLI_ALL=true
                CLI_NON_INTERACTIVE=true
                ;;
            --no-lower)
                CLI_NO_LOWER=true
                CLI_NON_INTERACTIVE=true
                ;;
            --no-upper)
                CLI_NO_UPPER=true
                CLI_NON_INTERACTIVE=true
                ;;
            --no-nums)
                CLI_NO_NUMS=true
                CLI_NON_INTERACTIVE=true
                ;;
            --no-symbols)
                CLI_NO_SYMBOLS=true
                CLI_NON_INTERACTIVE=true
                ;;
            --preset)
                if [[ -z "${2:-}" ]]; then
                    echo -e "${C_YELLOW}[ERROR]${C_NC} --preset requires a name: pin, strong, wifi, memorable"
                    exit 1
                fi
                case "$2" in
                    pin|strong|wifi|memorable)
                        CLI_PRESET="$2"
                        CLI_NON_INTERACTIVE=true
                        ;;
                    *)
                        echo -e "${C_YELLOW}[ERROR]${C_NC} Unknown preset: $2"
                        echo "  Available presets: pin, strong, wifi, memorable"
                        exit 1
                        ;;
                esac
                shift
                ;;
            *)
                echo -e "${C_YELLOW}[ERROR]${C_NC} Unknown option: $1"
                echo "  Run '$TOOL_NAME --help' for usage information."
                exit 1
                ;;
        esac
        shift
    done
}
