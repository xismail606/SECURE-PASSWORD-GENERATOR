#!/usr/bin/env bash

# Check if command exists
command_exists() {
  command -v "$1" &>/dev/null
}

# Print info message
info() {
  if command_exists lolcat; then
    echo "[INFO] $1" | lolcat
  else
    echo "[INFO] $1"
  fi
}

# Print error message
error() {
  if command_exists lolcat; then
    echo "[ERROR] $1" | lolcat
  else
    echo "[ERROR] $1"
  fi
}

# Print success message
success() {
  if command_exists lolcat; then
    echo "[SUCCESS] $1" | lolcat
  else
    echo "[SUCCESS] $1"
  fi
}

# Loading animation
loading() {
  local msg="$1"
  echo -n "$msg "
  for i in {1..8}; do
    echo -n "$i... "
    sleep 0.2
  done
  echo ""
}

