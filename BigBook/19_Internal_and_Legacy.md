# Chapter 19: Internal & Legacy Features

This chapter catalogs features that are either internal placeholders, reserved for future use, or deprecated legacy syntax kept for backwards compatibility.

---

## 1. Reserved "Ghost" Keywords

These keywords exist in the engine's lexer but are currently placeholders for future development. Using them will not cause an error, but they do not yet have active functionality.

*   `netloop`: Reserved for future high-speed network polling and multi-threaded event loops.
*   `andrun`: Reserved for chained execution patterns.
*   `book`: Reserved for alternative file I/O syntax (superseded by the **Filesystem** module).
*   `to`: Reserved for directional data flow (e.g., `send X to Y`).

---

## 2. Terminology History

*   **Labs**: Originally just general modules, now officially **Libraries of BigC** (User's Experiments).
*   **Backpack**: Formally defined as **Bundle of All Collected Knowledge** (A standard List).

---

## 3. Legacy Input System

Before the `ask input` command was introduced, BigC used a specific token sequence to capture user text. This is still supported.

**Sequence**:
1.  `take response`
2.  `wait type export`

**Effect**: Pauses the engine and waits for a line of input from STDIN, storing it in a special global variable named `export`.

---

## 4. Deprecated Assignment Patterns

In the early "Legacy Phase," BigC used specific identifier patterns to handle lists and values. These are now deprecated in favor of `=` and `split`.

### Item Pointers
*   `item = Name`: Historically used to initialize an item pointer. Now simply sets variable `Name` to `"0"`.

### Value Suffix
*   `Name_value = "Val"`: A legacy way to assign data. Equivalent to `Name = "Val"`.

---

## 5. Internal System Variables (SBIG)

These variables are used by the **SBIG** (Servers of BigC) engine to manage state during execution.

*   `Sbig_Response_Body`: Holds the content for the current Web Server reply.
*   `Sbig_Response_File`: Holds the filename for the current Web Server reply.
*   `RequestPath`: The full URL of the incoming request.
*   `RequestMethod`: The HTTP verb (GET/POST).
*   `RequestExtra`: Captured data from a `+` route.

---

## 6. Hidden Engine Toggles

The engine contains hidden flags that can be toggled via assignment, though their effects in the current build may be minimal or diagnostic.

| Variable | Type | Description |
| :--- | :--- | :--- |
| `BigDebug` | 0/1 | Enables future verbose diagnostic logging. |
| `BigFixer` | 0/1 | Enables/disables indentation forgiveness (superseded by `attach fixer`). |
