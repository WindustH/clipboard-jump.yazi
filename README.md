<h1 align="center">📋 clipboard-jump.yazi</h1>
<p align="center">
  <b>A simple plugin for <a href="https://github.com/sxyazi/yazi">Yazi</a> to jump to a path from the system clipboard.</b><br>
  <i>Copy a path, then jump to it instantly.</i>
</p>

---

## 📖 Table of Contents

- [Features](#-features)
- [Installation](#%EF%B8%8F-installation)
- [Keymap Example](#-keymap-example)
- [Usage](#%EF%B8%8F-usage)

---

## 🚀 Features

- **Instant jump:** Jump directly to any path stored in your system clipboard.
- **Cross-platform clipboard:** Supports `wl-paste` (Wayland) and `xclip` (X11).
- **Smart directory fallback:** If the clipboard contains a file path, jumps to its parent directory automatically.
- **Clear notifications:** Provides feedback on success or failure.

---

## ⚡️ Installation

```bash
# Unix/Linux
git clone https://github.com/WindustH/clipboard-jump.yazi.git ~/.config/yazi/plugins/clipboard-jump.yazi

# Windows (CMD, not PowerShell!)
git clone https://github.com/WindustH/clipboard-jump.yazi.git %AppData%\\yazi\\config\\plugins\\clipboard-jump.yazi

# Or with a yazi package manager (e.g., https://github.com/yazi-rs/yazi/wiki/Awesome-Yazi#package-managers)
ya pkg add WindustH/clipboard-jump
```

---

## 🎹 Keymap Example

Add a keybinding to your `keymap.toml` to use the plugin:

```toml
[[mgr.prepend_keymap]]
on   = [ "g", "p" ]
run  = "plugin clipboard-jump"
desc = "Jump to clipboard path"
```

---

## 🛠️ Usage

1. Copy any file or directory path to your system clipboard (e.g., `Ctrl+Shift+C` in a file manager, or `pwd | wl-copy` in a terminal).
2. Press the configured keybinding (e.g., `gc`) inside Yazi.
3. Yazi will navigate to the directory:
   - If the clipboard contains a **directory path**, jumps directly to it.
   - If the clipboard contains a **file path**, jumps to its parent directory.
