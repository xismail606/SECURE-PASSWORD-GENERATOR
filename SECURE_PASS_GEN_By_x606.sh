#!/bin/bash

# Clear the screen
clear

# Check if figlet and lolcat are installed
command -v lolcat &> /dev/null;
echo "                        ============================================" | lolcat

if command -v figlet &> /dev/null && command -v lolcat &> /dev/null; then
    figlet -f Sub-Zero "PASS GEN" | lolcat
    figlet -f small "                      By x606" | lolcat 
    echo "                        ============================================" | lolcat
else
    # Fallback if tools are missing
    echo "##########################################################"
    echo "                SECURE PASSWORD GENERATOR"
    echo "##########################################################"
    echo "(Install 'figlet' and 'lolcat' to see the cool banner!)"
fi

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
echo "---------------------Complexity Options---------------------" | lolcat

# -------2. BUILD CHARACTER POOL-------

charset=""

# -------Ask for Lowercase-------

read -p "Include Lowercase letters? (y/n): " opt_lower
if [[ "${opt_lower,,}" == "y" ]]; then
    charset="${charset}abcdefghijklmnopqrstuvwxyz"
fi

#------- Ask for Uppercase-------

echo ""
read -p "Include Uppercase letters? (y/n): " opt_upper
if [[ "${opt_upper,,}" == "y" ]]; then
    charset="${charset}ABCDEFGHIJKLMNOPQRSTUVWXYZ"
fi

#------- Ask for Numbers-------

echo ""
read -p "Include Numbers? (y/n): " opt_nums
if [[ "${opt_nums,,}" == "y" ]]; then
    charset="${charset}0123456789"
fi

#------- Ask for Symbols-------
echo ""
read -p "Include Special Symbols? (y/n): " opt_syms
if [[ "${opt_syms,,}" == "y" ]]; then
    charset="${charset}!@#$%^&*()-_=+[]{};:,.<>?"
fi

echo ""

# ========================================================
# Check if the user said 'n' to everything
# ========================================================

if [[ -z "$charset" ]]; then
    echo " [ERROR] You must select at least one character type!" 
    if command -v lolcat &> /dev/null; then
        echo "Exiting..." | lolcat
    else
        echo "Exiting..."
    fi
    exit 1
fi

# ========================================================
# LOADING EFFECT (COUNT TO 8)
# ========================================================

echo -n "Generating password... " | lolcat

for i in {1..8}; do
    
    echo -n "$i... " | lolcat
    
    sleep 0.2
done

echo "" 

#------- 3. GENERATE THE PASSWORD-------

password=""
charset_len=${#charset}

for (( i=0; i<pass_len; i++ )); do

# ========================================================
# Using /dev/urandom instead of $RANDOM for security
# We use 'od' to read 2 bytes of random data and convert to integer
# ========================================================
    
    rand_int=$(od -An -N2 -tu2 < /dev/urandom | tr -d '[:space:]')
    rand_idx=$(( rand_int % charset_len ))

    #------- Extract character at index-------
    char=${charset:$rand_idx:1}

    #------- Append to password-------
    password="${password}${char}"

done

echo ""

if command -v figlet &> /dev/null && command -v lolcat &> /dev/null; then
    echo "##########################################################" | lolcat
    echo "YOUR PASSWORD:" | lolcat
    echo ""
    echo "$password" | lolcat
    echo ""
    echo "##########################################################" | lolcat
else
    echo "##########################################################"
    echo "YOUR PASSWORD:"
    echo ""
    echo "$password"
    echo ""
    echo "##########################################################"
fi

echo ""
# ========================================================
# 4. SAVE TO FOLDER & FILE
# ========================================================

#------- Name of the folder to create-------
FOLDER_NAME="By_606"
mkdir -p "$FOLDER_NAME"

#------- Name of the file (using date and time to be unique)-------
FILE_NAME="pass_606_$(date +%Y-%m-%d_%H-%M-%S).txt"
FULL_PATH="$FOLDER_NAME/$FILE_NAME"

#------- Write the password to the file-------
echo "$password" > "$FULL_PATH"

# ========================================================
#  Set read/write for owner only (rw-------)
# ========================================================
chmod 600 "$FULL_PATH"

echo "----------------------------------------------------------" | lolcat
echo ""
echo " [SUCCESS] Password saved to folder: $FOLDER_NAME" | lolcat
echo " [FILE]    $FILE_NAME" | lolcat
echo " [SECURE]  Permissions set to 600 (Owner Read/Write only)" | lolcat
echo ""
echo "----------------------------------------------------------" | lolcat
echo ""