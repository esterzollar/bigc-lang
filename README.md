# BigC: Beyond Big Complexity (V.1.0 Mandate)

[![Version](https://img.shields.io/badge/Version-1.0--Mandate-blue)](https://bigc.ponpyin.org)
[![License](https://img.shields.io/badge/License-BUPML-green)](LICENSE)
[![Foundation](https://img.shields.io/badge/Foundation-Rust-orange)](https://www.rust-lang.org/)

**BigC** is a human-first, "Living Textbook" programming language designed to eliminate "Indentation Hell" and bring professional creator tools to everyone. Built on a rock-solid **Rust** foundation, BigC is fast, memory-safe, and strictly flat.

> *"Programming should be as readable as a manual and as logical as building blocks."*

---

## Quick Start (1-Line Installation)

Choose the installation method that fits your needs:

### 1. Global Mandate (System-wide Tarball)
Installs the `bigrun` engine globally to your system path. Ideal for developers who want BigC available everywhere.
```bash
curl -sSL https://raw.githubusercontent.com/esterzollar/bigc-lang/main/install.sh | sudo bash
```

### 2. Local Setup (Current Directory)
Downloads the engine and scaffolds the "Blessed Way" project structure in your current folder. No root permissions required.
```bash
curl -sSL https://raw.githubusercontent.com/esterzollar/bigc-lang/main/setup.sh | bash
```

### 3. Windows Setup (PowerShell)
Run this in PowerShell to download the engine and set up your environment:
```powershell
iwr https://raw.githubusercontent.com/esterzollar/bigc-lang/main/setup.ps1 -useb | iex
```

---

## The BigC Philosophy

BigC is built on three core mandates:
1.  **Flat Architecture**: Indentation is reserved exclusively for `loop` blocks. Logic flows linearly from top to bottom.
2.  **Textbook Grammar**: Instructions use natural English verbs (`run`, `open`, `draw`, `look for`).
3.  **Universal Memory**: Scoped sandboxing protects your data automatically while allowing global access via the `Raw` suffix.

---

## The Five Pillars of BigEco

*   **BigGuy**: Native, GPU-accelerated GUI engine. Reactive 60 FPS rendering with zero boilerplate.
*   **BigWeb**: Industrial-grade web server and routing engine. Turn any script into an API in seconds.
*   **BigNet**: High-level networking and scraping client. Built-in JSON extraction and CSS selectors.
*   **The Vault**: Dual-mode storage featuring native **DBIG** (atomic Key-Value) and **DBR** (SQLite).
*   **Math Lab**: High-precision recursive solver with full PEMDAS support.

---

## Code Example: A Simple Ticker

```bigc
# ticker.big
attach statement
Count = 0

s.loop
    Count = Count + 1
    print update "Processing Mission: $Count/100"
    wait 0.1 s
    if $Count = 100 & loop.s
keep 1

run LogSuccess("Mission Accomplished.")
```

---

## Documentation & Wiki

For the full manual, tutorials, and keyword references, visit the official temporary Wiki:
**[bigc.ponpyin.org](https://bigc.ponpyin.org)**

---

## License & Contribution

BigC is released under the **BigC Universal Public Mandate License (BUPML)**.
*   **Property of esterzollar**: The engine and brand are sovereign property.
*   **100% Free**: Free for personal, educational, and commercial use.
*   **Freedom to Fork**: You are encouraged to fork the engine and evolve the logic.
*   **Open GUI**: The GUI Source ("The Face") is open for community contributions!

**Architect:** [esterzollar](https://github.com/esterzollar)

---
*"Flat is Better. Logic is Sovereign."*
