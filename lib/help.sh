#!/usr/bin/env bash

VERSION="1.0.0"
TOOL_NAME="passgen"

show_help() {
cat << EOF
$TOOL_NAME - Secure Password Generator

Usage:
  $TOOL_NAME [options]

Options:
  -h, --help        Show this help message and exit
  -v, --version     Show version information and exit

Description:
  Interactive secure password generator using /dev/urandom.
  Allows choosing:
    - Lowercase letters
    - Uppercase letters
    - Numbers
    - Special symbols

Security:
  - Cryptographically secure randomness
  - Saved passwords use permission 600

Examples:
  $TOOL_NAME
  $TOOL_NAME --help
  $TOOL_NAME --version

Author:
  x606
EOF
}

show_version() {
  echo "$TOOL_NAME version $VERSION"
}

handle_cli() {
  case "${1:-}" in
    -h|--help)
      show_help
      exit 0
      ;;
    -v|--version)
      show_version
      exit 0
      ;;
  esac
}

