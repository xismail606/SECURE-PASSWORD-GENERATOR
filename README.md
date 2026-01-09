<!-- ===================== HEADER ===================== -->
<div align="center">
  <img 
    src="https://capsule-render.vercel.app/api?type=waving&color=gradient&text=x606PassGen&height=140&section=header"
    alt="PassGen Header"
    width="100%"
  />
</div>

---

<!-- ===================== TITLE ===================== -->
<h1 align="center"> 🐧 PassGen – Secure Password Generator </h1>

<p align="center">
  A secure, modular, and Linux-compatible password generator written in Bash.<br>
  Designed for clean systems with zero forced dependencies.
</p>

---

<!-- ===================== ABOUT ===================== -->
<h2 align="center"> 💡 About The Project </h2>

```bash
tool_name: PassGen
type: CLI Security Utility
language: Bash
platform: Linux
design_principles:
  - Security First
  - Zero Forced Dependencies
  - Modular Architecture
  - Clean CLI Experience
```
---

<!-- ===================== FEATURES ===================== -->
<h2 align="center"> ✨ Features </h2>

<ul>
  <li>🔐 Cryptographically secure randomness using <code>/dev/urandom</code></li>
  <li>⚙️ Custom password length</li>
  <li>🔡 Character set selection:
    <ul>
      <li>Lowercase letters</li>
      <li>Uppercase letters</li>
      <li>Numbers</li>
      <li>Special symbols</li>
    </ul>
  </li>
  <li>🎨 Automatic detection of <code>figlet</code> & <code>lolcat</code></li>
  <li>💾 Optional secure password saving</li>
  <li>🔒 Saved files use permission <code>600</code></li>
</ul>

---

<!-- ===================== REQUIREMENTS ===================== -->
<h2 align="center"> ⚙️ Requirements </h2>

<ul>
  <li>🐚 Bash shell</li>
  <li>💻 Basic Linux command-line environment</li>
</ul>

<p align="center"><strong>No additional dependencies required</strong></p>

---

<!-- ===================== CLONE ===================== -->
<h2 align="center"> 📥 Clone The Repository </h2>

<p align="center">
Get the project source code directly from GitHub:
</p>

```bash
+ git clone https://github.com/xismail606/SECURE-PASSWORD-GENERATOR.git
+ cd SECURE-PASSWORD-GENERATOR
```

<p align="center">
After cloning, follow the installation steps below to set permissions and install the tool system-wide.
</p>

---

<!-- ===================== STRUCTURE ===================== -->
<h2 align="center"> 📁 Project Structure </h2>

```bash
SECURE-PASSWORD-GENERATOR
├── passgen
├── optional-requirements.sh
└──passgen-lib/
  ├── utils.sh        # Helper & utility functions
  ├── help.sh         # CLI help & version handling
  ├── generator.sh    # Core password generation logic
  └── banner.sh       # Visual banner & output handling
```

---

<!-- ===================== OPTIONAL SCRIPT ===================== -->
<h2 align="center"> 🧩(Optional) Automatic Visual Enhancements Setup "Script" </h2>

<p align="center">
For convenience, PassGen provides an optional installation script that automatically installs
all visual enhancement tools.
</p>

<p align="center">
<strong>This step is optional</strong> and only affects appearance (colors & banners).
</p>

```bash
chmod +x optional-requirements.sh
./optional-requirements.sh
```

<p align="center">
The script will:
</p>

<ul>
  <li>Install <code>lolcat</code>, <code>figlet</code>, and <code>git</code></li>
  <li>Download and install extra <code>figlet</code> fonts</li>
  <li>Keep PassGen fully functional even if skipped</li>
</ul>

<p align="center">
⚠️ <strong>Note:</strong> The script requires <code>sudo</code> privileges.
</p>

---

<!-- ===================== MANUAL INSTALLATION ===================== -->
<h2 align="center"> 🛠️ (Optional) Manual Visual Enhancements Setup </h2>

<p align="center">
These steps are <strong>manual</strong> and only enhance visual output.<br />
PassGen works perfectly without them.
</p>

```bash
sudo apt install lolcat

git clone https://github.com/xero/figlet-fonts.git
cd figlet-fonts
rm README.md
sudo mv * /usr/share/figlet
```

---

<!-- ===================== PERMISSIONS ===================== -->
<h2 align="center"> 🔐 Set Execute Permissions </h2>

```bash
chmod +x passgen
chmod +x passgen-lib/*.sh
```

---

<!-- ===================== INSTALLATION ===================== -->
<h2 align="center"> 📦 System-Wide Installation </h2>

```bash
sudo mv passgen /usr/local/bin/
sudo mv passgen-lib /usr/local/bin/
```

<p align="center">
Final installation layout:
</p>

```bash
/usr/local/bin/
├── passgen
└── passgen-lib/
    ├── utils.sh
    ├── help.sh
    ├── generator.sh
    └── banner.sh
```

---

<!-- ===================== USAGE ===================== -->
<h2 align="center"> ▶️ Usage </h2>

```bash
passgen
-
passgen --help
passgen --version
```


---

<!-- ===================== SECURITY ===================== -->
<h2 align="center"> 🔐 Security Notes </h2>

<ul>
  <li>Uses <code>/dev/urandom</code> for cryptographic randomness</li>
  <li>No predictable randomness (<code>$RANDOM</code> not used)</li>
  <li>Saved passwords are local and restricted</li>
  <li>Safe to run without root (except installation)</li>
</ul>

---

<!-- ===================== AUTHOR ===================== -->
<h2 align="center"> 👤 Author </h2>

<p align="center">
<strong>x606</strong><br>
Penetration Testing Enthusiast<br>
 • Offensive Security • Red Team Fundamentals •
</p>

---

<!-- ===================== FOOTER ===================== -->
<div align="center">
  <img 
    src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=100&section=footer"
    width="100%"
  />
</div>
