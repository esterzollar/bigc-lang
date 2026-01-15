# Chapter 17: The Zen of BigC (Style Guide)

BigC is more than just a language; it is a **Textbook Mindset**. This chapter outlines the principles of writing code that is as readable as a human manual.

---

## 1. The Golden Rule: Flat is Better

BigC rejects "Indentation Hell." In traditional languages, logic is often buried deep within nested `if` statements. BigC encourages **Linear Logic**.

*   **Avoid Nesting**: Use the `&` connector to chain conditions and actions on a single line.
*   **Linear Flow**: Read from top to bottom, left to right.

### The BigC Way (Flat)
```bigc
# Use chains for simple logic
if $Authenticated = "true" & if $Admin = "true" & print "Welcome, Master."
```

---

## 2. GUI Philosophy: Composition over Nesting

When using **BigGuy**, do not create deep trees of layout containers (row inside column inside row).

*   **The BigC Way**: Break complex UIs into small, named **Views** and compose them.
*   **Logic Isolation**: Never write business logic inside a `View` block. Perform calculations in a `doing` block and store results in `Raw` variables for the View to display.

---

## 3. Naming Conventions

To maintain the "Textbook" style, follow these casing rules:

*   **Keywords**: Must be **lowercase** (e.g., `print`, `run`, `if`).
*   **Variables**: Use `PascalCase` (e.g., `CurrentUser`, `TotalScore`).
*   **Doing Blocks**: Use `PascalCase` (e.g., `ProcessOrder`).

---

## 4. Global Scope: The Suffix Rule

BigC uses functional (local) scope by default. To make a variable accessible globally (escaping a `doing` block), you must use a **Global Suffix**.

| Suffix | Purpose |
| :--- | :--- |
| `Raw` | General purpose global data. |
| `Content` | Data storage (e.g., file content). |
| `Layout` | UI structure definitions. |
| `Html` | Web-related content. |
| `Biew` | UI templates. |

---

## 5. Mandatory Spacing (@)

The `@` target indicator is a **Physical Pointer**. To maintain consistency, the engine enforces a strict spacing rule:

*   **Rule**: `[Space] @ [No Space] [Target]`
*   **Correct**: `write "Hi" @"file.txt"`
*   **Correct**: `map set "K" as "V" @{MyMap}`
*   **Wrong**: `write "Hi"@"file.txt"` (Missing space before)
*   **Wrong**: `write "Hi" @ "file.txt"` (Space after @)

---

## 6. Failure-First Logic

Always assume external operations (Network, File I/O) might fail. The "Blessed Way" is to check for bugs immediately.

```bigc
get web "https://site.com" & set as {Html}
if any bug found
    print "System Offline: $BugType"
    stop run
```

---

## 7. Documentation as Code

Code should be self-explanatory.
*   Use descriptive variable names (`ItemCount` instead of `x`).
*   Use clear `doing` block names (`CalculateGrandTotal` instead of `func1`).
*   Write scripts that read like a set of instructions in a manual.
