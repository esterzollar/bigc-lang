# Chapter 15: Additional Documents (Deep Dive)

This chapter covers technical nuances, hidden system behaviors, and advanced optimization techniques for professional BigC developers.

---

## 1. System Variables

The BigC engine uses several built-in variables to control behavior and report status. These variables are reserved and should not be used for general data storage.

| Variable | Type | Description |
| :--- | :--- | :--- |
| `BigDebug` | Boolean (0/1) | (Reserved) Future support for verbose logging. |
| `BigFixer` | Boolean (0/1) | (Reserved) Future support for relaxed syntax rules. |
| `$BugType` | String | Contains the error message from the last failed command (e.g., "File Error"). |
| `$RequestExtra`| String | Captures wildcard data from a `+` route in BigWeb. |

---

## 2. Naming Conventions & Scope

BigC enforces strict rules to maintain its characteristic "Textbook" style.

### Case Sensitivity
*   **Keywords**: Must be **lowercase** (e.g., `print`, `run`, `if`).
*   **Variables**: Recommended **PascalCase** (`UserName`, `TotalValue`).

### Global Scope Triggers
While BigC uses local scoping for variables defined inside `doing` blocks, certain variable suffixes trigger **Global Scope**. Any variable ending with one of these suffixes is shared across all blocks:

*   `Raw` (e.g., `ConfigRaw`)
*   `Content` (e.g., `PageContent`)
*   `Layout`
*   `Html`
*   `Biew`

---

## 3. String Escaping

To include special characters in strings without triggering their functional behavior, use the backslash `\` escape.

*   `\n`: New line (inserts a line break).
*   `\t`: Tab (inserts horizontal spacing).
*   `\$`: Literal dollar sign (prevents variable interpolation).
*   `\"`: Literal double quote (useful for nested quotes).

### Example
```bigc
print "First Line\nSecond Line"
print "The item costs \$50.00"
print "She said, \"Hello!\""
```

---

## 4. Performance & Safety

### Recursion Limit
BigC includes a safety mechanism called the **Recursion Guard**. By default, the engine limits nested `doing` calls to **100 levels**. If a script exceeds this limit, the engine will halt with a "Stack Overflow" error to prevent system instability.

### Background Tasks
For operations that don't need to block the main script, use the `background` modifier:

**Syntax:** `run background [DoingName]`

*   **Best for:** Logging, sending network pings, or data cleanup.
*   **Limitation:** Do not use for logic that the main script needs immediate results from, as they run in parallel.

---

## 5. Event Queue (Signals)

BigC features a native global event queue. This acts as a "Nervous System" allowing different parts of your program (such as background threads and the main loop) to communicate asynchronously.

*   **`event push "[Signal]"`**: Adds a message to the end of the queue.
*   **`event pop & set as {[Var]}`**: Removes the first message from the queue. If the queue is empty, it returns the string "nothing".

### Example: Signal Processing
```bigc
# Thread 1: Pushes a signal
event push "Ready"

# Thread 2: Checks for signals
event pop & set as {Signal}

if Signal = "Ready" & print "System is starting..."
```

---

## 6. Error Handling Pattern

The correct way to handle bugs without crashing the script is the **If-Any-Bug** pattern.

```bigc
open "missing_file.txt" & set as {Data}

if any bug found
    print "Warning: $BugType"
    # Logic to handle the failure goes here
```

*Note: The engine will only suppress a fatal crash if the very next command is `if any bug found`.*

---

## 7. Security Boundaries

BigC is designed as a **System Orchestrator**. To maintain a secure environment:
1.  **Sanitize Input**: Always use `get [Var] as [Type]` (e.g., `floor`, `ceil`) to force user input into expected formats.
2.  **Scope Sensitivity**: Keep sensitive data in standard variables inside `doing` blocks so they are deleted automatically when the block ends.

```