#!/usr/bin/env bash
set -e

echo "[*] Installing optional requirements for passgen..."
echo "[*] These are NOT mandatory."

# Check sudo
if [[ $EUID -ne 0 ]]; then
  echo "[INFO] This script requires sudo privileges."
  echo "Run again with: sudo ./optional-requirements.sh"
  exit 1
fi

echo "[*] Installing optional packages (lolcat, figlet, git)..."
apt install -y lolcat figlet git

TMP_DIR="/tmp/figlet-fonts"

echo "[*] Downloading figlet fonts..."
rm -rf "$TMP_DIR"
git clone https://github.com/xero/figlet-fonts.git "$TMP_DIR"

echo "[*] Installing figlet fonts..."
rm -f /usr/share/figlet/README.md 2>/dev/null || true
cp -r "$TMP_DIR"/* /usr/share/figlet/

echo "[*] Cleaning up..."
rm -rf "$TMP_DIR"

echo "[✔] Optional requirements installed successfully!"
echo "[✔] Restart passgen to enjoy colored output and banners."
