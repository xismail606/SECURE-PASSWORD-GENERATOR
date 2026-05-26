#!/usr/bin/env bash

# ============================================
#  Password Strength Meter
#  Evaluates and displays password strength
# ============================================

show_strength() {
    local password="$1"
    local score=0
    local length=${#password}

    # ── Length scoring ──────────────────────
    if (( length >= 20 )); then
        score=$(( score + 35 ))
    elif (( length >= 16 )); then
        score=$(( score + 28 ))
    elif (( length >= 12 )); then
        score=$(( score + 20 ))
    elif (( length >= 8 )); then
        score=$(( score + 12 ))
    elif (( length >= 6 )); then
        score=$(( score + 5 ))
    fi

    # ── Character diversity scoring ────────
    local has_lower=0 has_upper=0 has_num=0 has_symbol=0

    if [[ "$password" =~ [a-z] ]]; then
        has_lower=1
        score=$(( score + 15 ))
    fi
    if [[ "$password" =~ [A-Z] ]]; then
        has_upper=1
        score=$(( score + 15 ))
    fi
    if [[ "$password" =~ [0-9] ]]; then
        has_num=1
        score=$(( score + 15 ))
    fi
    if [[ "$password" =~ [^a-zA-Z0-9] ]]; then
        has_symbol=1
        score=$(( score + 20 ))
    fi

    # ── Bonus for using all types ──────────
    local types_used=$(( has_lower + has_upper + has_num + has_symbol ))
    if (( types_used == 4 )); then
        score=$(( score + 10 ))
    elif (( types_used == 3 )); then
        score=$(( score + 5 ))
    fi

    # ── Extra bonus for very long passwords ─
    if (( length >= 28 )); then
        score=$(( score + 5 ))
    fi

    # Cap score at 100
    if (( score > 100 )); then
        score=100
    fi

    # ── Determine rating ───────────────────
    local rating="" color="" icon=""

    if (( score >= 75 )); then
        rating="Excellent"
        color="\033[1;35m"   # Bold Magenta
        icon="💎"
    elif (( score >= 50 )); then
        rating="Strong"
        color="\033[1;32m"   # Bold Green
        icon="🟢"
    elif (( score >= 30 )); then
        rating="Fair"
        color="\033[1;33m"   # Bold Yellow
        icon="🟡"
    else
        rating="Weak"
        color="\033[1;31m"   # Bold Red
        icon="🔴"
    fi

    local nc="\033[0m"
    local bar_color_filled=""
    local bar_color_empty="\033[0;90m"   # Dark gray

    if (( score >= 75 )); then
        bar_color_filled="\033[1;35m"
    elif (( score >= 50 )); then
        bar_color_filled="\033[1;32m"
    elif (( score >= 30 )); then
        bar_color_filled="\033[1;33m"
    else
        bar_color_filled="\033[1;31m"
    fi

    # ── Build progress bar ─────────────────
    local bar_width=20
    local filled=$(( score * bar_width / 100 ))
    local empty=$(( bar_width - filled ))
    local bar=""

    for (( i=0; i<filled; i++ )); do
        bar="${bar}█"
    done
    for (( i=0; i<empty; i++ )); do
        bar="${bar}░"
    done

    # ── Display ────────────────────────────
    echo ""
    if command -v lolcat &> /dev/null; then
        echo "  Password Strength: ${bar} ${rating} (${score}/100) ${icon}" | lolcat
    else
        echo -e "  Password Strength: ${bar_color_filled}${bar}${nc} ${color}${rating}${nc} (${score}/100) ${icon}"
    fi

    # ── Show breakdown ─────────────────────
    local detail=""
    detail="  Characters: "
    [[ $has_lower -eq 1 ]] && detail="${detail}[a-z] " || detail="${detail}     "
    [[ $has_upper -eq 1 ]] && detail="${detail}[A-Z] " || detail="${detail}     "
    [[ $has_num   -eq 1 ]] && detail="${detail}[0-9] " || detail="${detail}     "
    [[ $has_symbol -eq 1 ]] && detail="${detail}[!@#] " || detail="${detail}     "
    detail="${detail} | Length: ${length}"

    if command -v lolcat &> /dev/null; then
        echo "$detail" | lolcat
    else
        echo -e "  ${detail}"
    fi
}
