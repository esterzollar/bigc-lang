# Chapter 27: The Blessed Way (Project Structure)

To build professional and maintainable applications in BigC, we follow **The Blessed Way**. This is a set of structural and logical conventions that keep your code clean, readable, and "Textbook" consistent.

---

## 1. The Standard Project Tree

Professional projects should never be a single giant file. Keep your assets, data, and logic organized into these standard folders:

```text
/ MyAwesomeProject
├── app.big          # The "Brain" (Entry Point & Orchestration)
├── logic.big        # The "Muscle" (Shared doing blocks)
├── assets/          # Images, sounds, and fonts
├── env_lib/         # .bigenv environment libraries
└── data/            # .dbig or .db persistent storage
```

---

## 2. The Standard Entry Point Order

Every `app.big` or `.guy` file should follow this specific sequence to ensure the environment is fully prepared before the first instruction runs.

1.  **Unlocks:** Use `use` and `attach` to enable required engines (guy, web, sql).
2.  **Libraries:** Use `use lab "filename.big"` to import your logic files.
3.  **Initial State:** Set your global `Raw` variables (Title, Score, etc.).
4.  **The Start:** Run your main logic block or `start guy`.

> **CRITICAL CAUTION:** Do NOT use the command `use guy` inside a `.guy` file!
> *   The `.guy` extension *already* launches the window engine.
> *   Adding `use guy` will attempt to launch a **second** window engine inside the first one, causing a "Dual Window" crash or freeze.
> *   Only use `use guy` inside standard `.big` scripts if you intend to launch a window manually.

### Example `app.big`:
```bigc
# 1. Unlocks
use guy

# 2. Libraries
use lab "logic.big"

# 3. Initial State
TitleRaw = "BigC Blessed App"
UserScoreRaw = 100

# 4. Start
start guy Main
```

---

## 3. Core Philosophies

### The "@" Spacing Rule
In BigC, `@` is a **Physical Pointer**. It indicates *where* an action happens.
*   **The Rule:** `[Value] @ [Target]` (Space before, attached after).
*   **Why:** It makes code read like a map. You are doing something *at* a destination.
*   **Examples:** `write "Hello" @"note.txt"` or `draw image "p.png" at 100 100`.

### The Frame-Based Reactive Model
In **BigGuy**, the `view` block is re-read 60 times per second. 
*   **The Benefit:** You don't need "event listeners" to update the UI. Just `draw text "$Score"`. As soon as your logic changes the `Score` variable in the background, the UI updates automatically in the next frame.

---

## 4. The Golden Rule of Logic

**Never write business logic inside a `view` block.**

*   **The Muscle (Logic):** Complex math, database queries, and network calls should live in `doing` blocks.
*   **The Face (View):** The `view` should only be used to **Draw** and **Check Interaction** (like `if click`).

By keeping logic and rendering separate, your application remains fast, organized, and easy to debug.

---

## 5. Master Example: Blessed Logic Sharing

This example demonstrates how a main application imports shared logic from an external file to perform a calculation.

**File 1: `logic.big`**
```bigc
start doing CalculateFinal(base)
    # The Muscle: Perform the heavy lifting
    FinalValueRaw = S[base * 1.5]
    print "Logic: Calculation complete."
end doing
```

**File 2: `app.big`**
```bigc
# 1. Unlocks
use lab

# 2. Libraries (The Blessed Way)
use lab "logic.big"

# 3. State
StartValRaw = 100

# 4. Start
run CalculateFinal(StartValRaw)
print "Result: $FinalValueRaw" # 150
```