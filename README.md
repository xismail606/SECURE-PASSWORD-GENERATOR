# 🐧 Bash Script – Linux Compatible
### 📌 Overview

This script is built to run on any standard Linux environment using the Bash shell.
All core functionalities work out of the box, even if optional visual tools are not installed.

✨ When optional tools are available, the script automatically enables enhanced visual output such as colorful banners and styled text.
----------------------------
### 🎨 Optional Visual Enhancements (Not Required)

These tools are optional and only improve the visual appearance.
The script will still run normally without them.

🔹 Install lolcat (Colorful Output)

   #sudo apt install lolcat

🔹 Install Extra figlet Fonts

   #sudo git clone https://github.com/xero/figlet-fonts.git
   
   #cd figlet-fonts
   
   #ls
   
   #rm README.md
   
   #sudo mv * /usr/share/figlet
   
   #showfigfonts


🟢 If these tools are missing, the script gracefully falls back to standard text output.

-------------------------------------------

### ⚙️ Mandatory Requirements

Only the following are required:

🐚 Bash shell (default on most Linux distributions)

💻 Basic command-line environment

No additional dependencies are needed.

-------------------------------

### ▶️ How to Run the Script
 
  1️⃣ Navigate to the script directory:
  
  #cd /path/to/script
  
  
  2️⃣ Make the script executable:
  
  #chmod +x script_name.sh
  
  
  3️⃣ Run the script:
  
  #./script_name.sh
  
   OR
   
  4️⃣ Run the script:
  
  #bash script_name.sh

🚀 The script will start immediately.

----------------------

### 🧠 Design Philosophy

✔️ Works on clean Linux systems

✔️ No forced dependencies

✔️ Automatic feature detection

✔️ Clean and readable output

-----------------------------

### 📎Notes

Tested on common Linux distributions

Safe to run without root (except for optional installations)

Ideal for terminals, servers, and minimal environments

------------------------------------------

                       If you like this project, consider giving it a star ⭐ on GitHub!
