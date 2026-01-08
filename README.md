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

<pre style="color:#ff6b6b;"><strong>
tool_name: PassGen
type: CLI Security Utility
language: Bash
platform: Linux
design_principles:
  - Security First
  - Zero Forced Dependencies
  - Modular Architecture
  - Clean CLI Experience
</strong></pre>

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

<!-- ===================== OPTIONAL TOOLS ===================== -->
<h2 align="center"> 🎨 Optional Visual Enhancements </h2>

<p align="center">
These tools are <strong>optional</strong> and only enhance visual output.<br>
PassGen works perfectly without them.
</p>

<pre><strong>
sudo apt install lolcat

git clone https://github.com/xero/figlet-fonts.git
cd figlet-fonts
rm README.md
sudo mv * /usr/share/figlet
</strong></pre>

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

```md
+ git clone https://github.com/xismail606/SECURE-PASSWORD-GENERATOR.git
+ cd SECURE-PASSWORD-GENERATOR
```

<p align="center">
After cloning, follow the installation steps below to set permissions and install the tool system-wide.
</p>

---

<!-- ===================== STRUCTURE ===================== -->
<h2 align="center"> 📁 Project Structure </h2>

<pre style="color:#b388ff;"><strong>
SECURE-PASSWORD-GENERATOR
├── passgen
└──passgen-lib/
  ├── utils.sh        # Helper & utility functions
  ├── help.sh         # CLI help & version handling
  ├── generator.sh    # Core password generation logic
  └── banner.sh       # Visual banner & output handling
</strong></pre>

---

<!-- ===================== PERMISSIONS ===================== -->
<h2 align="center"> 🔐 Set Execute Permissions </h2>

<pre style="color:#00ff99;"><strong>
chmod +x passgen
chmod +x passgen-lib/*.sh
</strong></pre>

---

<!-- ===================== INSTALLATION ===================== -->
<h2 align="center"> 📦 System-Wide Installation </h2>

<pre style="color:#00ff99;"><strong>
sudo mv passgen /usr/local/bin/
sudo mv passgen-lib /usr/local/bin/
</strong></pre>

<p align="center">
Final installation layout:
</p>

<pre style="color:#b388ff;"><strong>
/usr/local/bin/
├── passgen
└── passgen-lib/
    ├── utils.sh
    ├── help.sh
    ├── generator.sh
    └── banner.sh
</strong></pre>

---

<!-- ===================== USAGE ===================== -->
<h2 align="center"> ▶️ Usage </h2>

<pre style="color:#00ff99;"><strong>
passgen
-
passgen --help
passgen --version
</strong></pre>


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
