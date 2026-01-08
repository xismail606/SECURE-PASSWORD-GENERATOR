#!/usr/bin/env bash

show_banner() {
# Check if figlet and lolcat are installed

if command -v figlet &> /dev/null && command -v lolcat &> /dev/null; then
    # if figlet and lolcat available in ur  os
    echo "                        ============================================" | lolcat
    figlet -f Sub-Zero "PASS GEN" | lolcat
    figlet -f small "                      By  x606                        " | lolcat
    echo "                        ============================================" | lolcat
else
    # if lolcat & figlet not available in ur os
    echo "          ============================================"
    echo "                     SECURE PASSWORD GENERATOR"
    echo "                           By x606                    "
    echo "          ============================================"
fi
}
