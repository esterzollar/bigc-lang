# Chapter 3: Control Flow

In BigC, "Control Flow" is the art of directing the engine's attention. Unlike other languages that use complex brackets `{}` for logic, BigC uses a strict linear path with one exception: **Indentation implies Repetition**.

---

## 3.1 Logic & The Linear Path

The engine reads your book (script) line by line. Logic commands allow you to skip lines or execute them conditionally.

### The `if` Command
*   **Syntax:** `if [Condition] & [Action]`
*   **Behavior:** If the condition is True, the Action (after `&`) is executed. If False, the engine ignores the rest of the line.

### Comparison Operators
BigC uses the following operators for logic checks:

*   `=`  : Equal
*   `=x` : Not Equal (Commonly `!=` in other languages)
*   `>`  : Greater than
*   `<`  : Less than
*   `>=` : Greater or Equal
*   `<=` : Less or Equal

> **Note:** The operator for "Not Equal" is specifically `=x`. The engine does not recognize `!=`.

### Numeric Truth
In BigC, "Truth" is numeric.
*   **True:** Any number `> 0`.
*   **False:** The number `0`.
*   **Strings:** String comparisons return `1` (True) or `0` (False).

```bigc
Status = 1
if $Status & print "System Online"  # Prints because 1 > 0
```

---

## 3.2 Loops (The Indentation Rule)

BigC has a strict rule: **Indentation = Repetition**.
The `start loop` command is the *only* command that expects the following lines to be indented.

### 1. Standard Loop
A standard loop spins indefinitely until you explicitly tell it to stop using the `keep` guard.

*   **Structure:**
    1.  `start loop`: Marks the beginning of the spin.
    2.  (Indented Code): The payload that repeats.
    3.  `keep [Condition]`: The guard at the bottom. If True, it spins again. If False, it falls through.

### 2. Smart Loops (`loop.r.N`)
Infinite loops freeze software. BigC solves this with the **Smart Loop**.
*   **Syntax:** `start loop.r.50` (where 50 is the limit).
*   **Mechanism:** The engine creates a hidden "Safety Counter". Every spin increments this counter. If it hits the limit, the loop breaks automatically—saving your app from freezing.

### 3. Refueling (`keep loop`)
Sometimes a loop works correctly but takes a long time (e.g., downloading a large file).
*   **Command:** `keep loop`
*   **Effect:** Sets the hidden Safety Counter back to `0`. It buys you another full cycle of time.

---

## 3.3 For-Each (Collection Iteration)

Instead of manually counting indices (`0, 1, 2...`), use `loop on` to iterate over containers directly.

### Backpacks (Lists)
*   **Syntax:** `start loop on {[ListVar]} as {[ItemVar]}`
*   **Example:** `start loop on {MyList} as {Product}`. Inside the loop, `$Product` will hold the current item.

### Maps (Dictionaries)
*   **Syntax:** `start loop on {[MapVar]} as {[KeyVar]} {[ValVar]}`
*   **Example:** `start loop on {UserMap} as {Key} {Val}`.

---

## 3.4 Doing (Functions & The Scope Wall)

A `doing` block allows you to create your own commands. However, you must understand the **Scope Wall**.

### The Partial Executor
A `doing` block is a "Partial Executor". It spins up a temporary, isolated memory space.
*   **Variables defined inside** die when the block ends.
*   **Variables defined outside** are visible inside (Read-Only by default behavior in many languages, but in BigC, writing to a variable name creates a NEW local variable unless it's global).

### Escaping the Wall (Global Suffixes)
To write to the "Universal Memory" (Global) from inside a function, you must use a reserved suffix. The engine detects these suffixes and bypasses the Scope Wall.

*   **`Raw`**: General data (`ScoreRaw`).
*   **`Content`**: Large text/data (`FileContent`).
*   **`Layout`** / **`Html`**: UI and Web (`PageHtml`).

```bigc
start doing UpdateScore()
    Score = 50      # Creates a LOCAL variable 'Score'. Dies at 'end'.
    ScoreRaw = 100  # Updates the GLOBAL variable 'ScoreRaw'. Persists.
end doing
```

---

## 3.5 The Mechanics of Failure (`bug`)

BigC does not crash on errors (like missing files or bad math). Instead, it raises a silent flag.

*   **Command:** `any bug found`
*   **Behavior:** Returns True if the *very last command* failed.
*   **Diagnostic:** The system variable `$BugType` holds the reason (e.g., "FileNotFound").

**Best Practice:** Always check `any bug found` immediately after interacting with the "Outside World" (Files, Web, Database).

---

### ✅ Verified Example: 03_control_flow.big
**File Path:** `manual_examples/03_control_flow.big`
```bigc
# 03_control_flow.big
# Control Flow Verification

# 1. Logic & Numeric Truth
Status = 1
if $Status & print "System is Online (1 is True)"

# 2. Smart Loops & Refuel
Fuel = 0
start loop.r.5
    Fuel = Fuel + 1
    if $Fuel = 4
        print "Refueling at 4..."
        keep loop
keep $Fuel < 8
print "Loop finished with Fuel: $Fuel"

# 3. For-Each Iteration
Backpack = "[\"Sword\", \"Shield\"]"
start loop on {Backpack} as {Item}
    print "Found: $Item"
keep 1

# 4. Functions & Scope
GlobalRaw = "Old"
start doing Change()
    Local = "Private"
    GlobalRaw = "New"
end doing
run Change()
print "Global: $GlobalRaw"

# 5. Bug Catching
delete file "nonexistent.big"
if any bug found & print "Caught Expected Bug: $BugType"
```

```