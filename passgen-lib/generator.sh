#!/usr/bin/env bash

# ============================================
#  Password Generator Engine
#  Supports both interactive and CLI modes
# ============================================

# ── Clipboard Helper ───────────────────────
copy_to_clipboard() {
    local text="$1"
    if command -v xclip &> /dev/null; then
        echo -n "$text" | xclip -selection clipboard
        return 0
    elif command -v xsel &> /dev/null; then
        echo -n "$text" | xsel --clipboard --input
        return 0
    elif command -v pbcopy &> /dev/null; then
        echo -n "$text" | pbcopy
        return 0
    elif command -v wl-copy &> /dev/null; then
        echo -n "$text" | wl-copy
        return 0
    else
        return 1
    fi
}

# ── Apply Preset ───────────────────────────
apply_preset() {
    local preset="$1"
    case "$preset" in
        pin)
            CLI_LENGTH=4
            CLI_NO_LOWER=true
            CLI_NO_UPPER=true
            CLI_NO_SYMBOLS=true
            # Only numbers
            ;;
        strong)
            CLI_LENGTH=20
            CLI_ALL=true
            ;;
        wifi)
            CLI_LENGTH=63
            CLI_NO_SYMBOLS=true
            # Alphanumeric only
            ;;
        memorable)
            CLI_LENGTH=16
            CLI_NO_UPPER=true
            CLI_NO_SYMBOLS=true
            # Lowercase + numbers
            ;;
    esac
}

# ── Generate Single Password ──────────────
generate_password() {
    local charset="$1"
    local pass_len="$2"
    local password=""
    local charset_len=${#charset}

    for (( i=0; i<pass_len; i++ )); do
        # Using /dev/urandom for cryptographic security
        # 'od' reads 2 bytes of random data and converts to integer
        rand_int=$(od -An -N2 -tu2 < /dev/urandom | tr -d '[:space:]')
        rand_idx=$(( rand_int % charset_len ))
        char=${charset:$rand_idx:1}
        password="${password}${char}"
    done

    echo "$password"
}

# ── Save Password to File ─────────────────
save_password() {
    local password="$1"
    local output_file="$2"
    local pass_index="${3:-}"

    if [[ -n "$output_file" ]]; then
        # User specified output file
        local dir
        dir=$(dirname "$output_file")
        mkdir -p "$dir" 2>/dev/null || true

        if [[ -n "$pass_index" ]] && (( CLI_COUNT > 1 )); then
            echo "$password" >> "$output_file"
        else
            echo "$password" > "$output_file"
        fi
        chmod 600 "$output_file"

        if command -v lolcat &> /dev/null; then
            echo "" | lolcat
            echo " [SUCCESS] Password saved to: $output_file" | lolcat
            echo " [SECURE]  Permissions set to 600 (Owner Read/Write only)" | lolcat
        else
            echo ""
            echo -e " ${C_GREEN}[SUCCESS]${C_NC} Password saved to: $output_file"
            echo -e " ${C_GREEN}[SECURE]${C_NC}  Permissions set to 600 (Owner Read/Write only)"
        fi
    else
        # Default save location
        local FOLDER_NAME="By_606"
        mkdir -p "$FOLDER_NAME"

        local FILE_NAME="pass_606_$(date +%Y-%m-%d_%H-%M-%S).txt"
        local FULL_PATH="$FOLDER_NAME/$FILE_NAME"

        if [[ -n "$pass_index" ]] && (( CLI_COUNT > 1 )); then
            echo "$password" >> "$FULL_PATH"
        else
            echo "$password" > "$FULL_PATH"
        fi
        chmod 600 "$FULL_PATH"

        if command -v lolcat &> /dev/null; then
            echo "----------------------------------------------------------" | lolcat
            echo "" | lolcat
            echo " [SUCCESS] Password saved to folder: $FOLDER_NAME" | lolcat
            echo " [FILE]    $FILE_NAME" | lolcat
            echo " [SECURE]  Permissions set to 600 (Owner Read/Write only)" | lolcat
            echo "" | lolcat
            echo "----------------------------------------------------------" | lolcat
        else
            echo "----------------------------------------------------------"
            echo ""
            echo -e " ${C_GREEN}[SUCCESS]${C_NC} Password saved to folder: $FOLDER_NAME"
            echo -e " ${C_GREEN}[FILE]${C_NC}    $FILE_NAME"
            echo -e " ${C_GREEN}[SECURE]${C_NC}  Permissions set to 600 (Owner Read/Write only)"
            echo ""
            echo "----------------------------------------------------------"
        fi
    fi
}

# ── Display Password ──────────────────────
display_password() {
    local password="$1"
    local index="${2:-}"
    local label=""

    if [[ -n "$index" ]] && (( CLI_COUNT > 1 )); then
        label="PASSWORD #${index}:"
    else
        label="YOUR PASSWORD:"
    fi

    echo ""
    if command -v figlet &> /dev/null && command -v lolcat &> /dev/null; then
        echo "##########################################################" | lolcat
        echo "$label" | lolcat
        echo "" | lolcat
        echo "$password" | lolcat
        echo "" | lolcat
        echo "##########################################################" | lolcat
    else
        echo -e "${C_CYAN}##########################################################${C_NC}"
        echo -e "${C_BOLD}${label}${C_NC}"
        echo ""
        echo -e "${C_GREEN}${password}${C_NC}"
        echo ""
        echo -e "${C_CYAN}##########################################################${C_NC}"
    fi
}

# ── Loading Animation ─────────────────────
show_loading() {
    if command -v lolcat &> /dev/null; then
        echo -n "Generating password... " | lolcat
        for i in {1..8}; do
            echo -n "$i... " | lolcat
            sleep 0.2
        done
        echo ""
    else
        echo -n "Generating password... "
        for i in {1..8}; do
            echo -n "$i... "
            sleep 0.2
        done
        echo ""
    fi
}

# ── Build Charset from CLI Flags ──────────
build_charset_from_flags() {
    local charset=""

    if [[ "$CLI_ALL" == true ]]; then
        charset="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()-_=+[]{};:,.<>?"
    else
        # Default: include everything, then remove what's excluded
        local lower="abcdefghijklmnopqrstuvwxyz"
        local upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        local nums="0123456789"
        local symbols='!@#$%^&*()-_=+[]{};:,.<>?'

        [[ "$CLI_NO_LOWER" != true ]]   && charset="${charset}${lower}"
        [[ "$CLI_NO_UPPER" != true ]]   && charset="${charset}${upper}"
        [[ "$CLI_NO_NUMS" != true ]]    && charset="${charset}${nums}"
        [[ "$CLI_NO_SYMBOLS" != true ]] && charset="${charset}${symbols}"
    fi

    echo "$charset"
}

# ── Non-Interactive Mode ──────────────────
run_non_interactive() {
    # Apply preset if specified
    if [[ -n "$CLI_PRESET" ]]; then
        apply_preset "$CLI_PRESET"
    fi

    # Default length if not set
    if [[ -z "$CLI_LENGTH" ]]; then
        CLI_LENGTH=16
    fi

    # Build charset
    local charset
    charset=$(build_charset_from_flags)

    if [[ -z "$charset" ]]; then
        echo -e "${C_YELLOW}[ERROR]${C_NC} No character types selected! Use --all or remove some --no-* flags."
        exit 1
    fi

    local pass_len="$CLI_LENGTH"

    show_loading

    for (( n=1; n<=CLI_COUNT; n++ )); do
        local password
        password=$(generate_password "$charset" "$pass_len")

        # Display
        display_password "$password" "$n"

        # Strength meter
        show_strength "$password"

        # Copy to clipboard (only the last one if multiple)
        if [[ "$CLI_COPY" == true ]] && (( n == CLI_COUNT )); then
            echo ""
            if copy_to_clipboard "$password"; then
                if command -v lolcat &> /dev/null; then
                    echo " [COPIED] Password copied to clipboard!" | lolcat
                else
                    echo -e " ${C_GREEN}[COPIED]${C_NC} Password copied to clipboard!"
                fi
            else
                if command -v lolcat &> /dev/null; then
                    echo " [WARNING] Clipboard tool not found (install xclip, xsel, or wl-copy)" | lolcat
                else
                    echo -e " ${C_YELLOW}[WARNING]${C_NC} Clipboard tool not found (install xclip, xsel, or wl-copy)"
                fi
            fi
        fi

        # Save
        if [[ "$CLI_SAVE" == true ]]; then
            save_password "$password" "$CLI_OUTPUT" "$n"
        fi

        echo ""
    done

    # Footer
    if command -v lolcat &> /dev/null; then
        echo "                    ╔═══════════════╗                      " | lolcat
        echo "                    ║    BY x606    ║                      " | lolcat
        echo "                    ╚═══════════════╝                      " | lolcat
    else
        echo -e "${C_BOLD}                            BY x606${C_NC}"
    fi
    echo ""
}

# ═══════════════════════════════════════════
#  MAIN: run_generator
# ═══════════════════════════════════════════

run_generator() {

    # ── Non-Interactive Mode ───────────────
    if [[ "$CLI_NON_INTERACTIVE" == true ]]; then
        run_non_interactive
        return
    fi

    # ══════════════════════════════════════
    #  Interactive Mode (Original Behavior)
    # ══════════════════════════════════════

    echo ""

    #------------------1. GET PASSWORD LENGTH-------------------

    while true; do
        read -p "Enter desired password length you need :) : " pass_len

        # Validate input is a number and greater than 0

        if [[ "$pass_len" =~ ^[0-9]+$ ]] && [ "$pass_len" -gt 0 ]; then
            break
        else
            echo "Invalid length. Please enter a number greater than 0."
        fi
    done
    echo ""

    if command -v figlet &> /dev/null && command -v lolcat &> /dev/null; then

        echo "---------------------Complexity Options---------------------" | lolcat

    else
        echo "---------------------Complexity Options---------------------"

    fi
    echo ""
    # -------2. BUILD CHARACTER POOL-------

    charset=""

    # Ask for Lowercase

    read -p "Include Lowercase letters? (y/n): " opt_lower
    if [[ "${opt_lower,,}" == "y" ]]; then
        charset="${charset}abcdefghijklmnopqrstuvwxyz"
    fi

    # Ask for Uppercase

    echo ""
    read -p "Include Uppercase letters? (y/n): " opt_upper
    if [[ "${opt_upper,,}" == "y" ]]; then
        charset="${charset}ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    fi

    # Ask for Numbers

    echo ""
    read -p "Include Numbers? (y/n): " opt_nums
    if [[ "${opt_nums,,}" == "y" ]]; then
        charset="${charset}0123456789"
    fi

    # Ask for Symbols
    echo ""
    read -p "Include Special Symbols? (y/n): " opt_syms
    if [[ "${opt_syms,,}" == "y" ]]; then
        charset="${charset}!@#\$%^&*()-_=+[]{};:,.<>?"
    fi

    echo ""

    #========================================
    #Check if the user said 'n' to everything
    #==========================================

    if [[ -z "$charset" ]]; then
        if command -v lolcat &> /dev/null; then
            echo " [ERROR] You must select at least one character type!" | lolcat
            echo ""
            echo "             Exiting..." | lolcat
        else
            echo " [ERROR] You must select at least one character type!"
            echo ""
            echo "             Exiting..."
        fi

        exit 1
    fi

    #=================================
    #LOADING EFFECT
    #=================================

    show_loading

    #------- 3. GENERATE THE PASSWORD-------

    local password
    password=$(generate_password "$charset" "$pass_len")

    # Display
    display_password "$password"

    # Show strength meter
    show_strength "$password"

    echo ""

    #=======================================
    # 4. COPY TO CLIPBOARD (if --copy flag)
    #=======================================

    if [[ "$CLI_COPY" == true ]]; then
        if copy_to_clipboard "$password"; then
            if command -v lolcat &> /dev/null; then
                echo " [COPIED] Password copied to clipboard!" | lolcat
            else
                echo -e " ${C_GREEN}[COPIED]${C_NC} Password copied to clipboard!"
            fi
        else
            if command -v lolcat &> /dev/null; then
                echo " [WARNING] Clipboard tool not found (install xclip, xsel, or wl-copy)" | lolcat
            else
                echo -e " ${C_YELLOW}[WARNING]${C_NC} Clipboard tool not found (install xclip, xsel, or wl-copy)"
            fi
        fi
        echo ""
    fi

    #=======================================
    # 5. ASK USER IF THEY WANT TO SAVE
    #=======================================

    if [[ "$CLI_SAVE" == true ]]; then
        # Auto-save if --save flag was used
        save_password "$password" "$CLI_OUTPUT"
    else
        read -p "Do you want to save this password to a file? (y/n): " save_choice
        echo ""

        if [[ "${save_choice,,}" == "y" ]]; then
            save_password "$password" ""
        else
            if command -v lolcat &> /dev/null; then
                echo "Password not saved to file." | lolcat
            else
                echo "Password not saved to file."
            fi
        fi
    fi

    echo ""

    # Footer
    if command -v lolcat &> /dev/null; then
        echo "                    ╔═══════════════╗                      " | lolcat
        echo "                    ║    BY x606    ║                      " | lolcat
        echo "                    ╚═══════════════╝                      " | lolcat
    else
        echo -e "${C_BOLD}                            BY x606${C_NC}"
    fi
    echo ""
}
