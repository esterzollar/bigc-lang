# Chapter 20: Untitled Functions (Hidden Logic)

This chapter reveals internal engine behaviors and "Secret" logic patterns that are not part of the standard keyword set but still function within the BigC engine.

---

## 1. Advanced Math Precedence

While most math in BigC is evaluated linearly, the Solver (`S[]`) and the `get` command use a multi-pass parser to prioritize specific operations.

**Precedence Order:**
1.  **Parentheses** `( )`: Handled recursively.
2.  **Exponents** `^`: Pass 0.
3.  **Multiplication/Division** `* /`: Pass 1.
4.  **Addition/Subtraction** `+ -`: Pass 2.

> **Safety Note**: Division by zero is caught by the engine. In some builds, it sets `$BugType` to `DivisionByZero` and returns `0.0`, while in others it may trigger a diagnostic `DEBUG HALT`.

---

## 2. Smart Indexing (Human Logic)

When using `get from {List} @Index`, the engine performs a "Smart Parse" to align with human intuition:
*   **1-Based**: Humans start counting at 1. The engine automatically converts this to 0-based for internal memory.
*   **Coercion**: If you pass a float like `@1.0`, it is automatically coerced to the integer `1`.

---

## 3. Atomic Spin-Locking

Every time a `dbig` command is executed, the engine ensures data integrity through **Atomic Spin-Locking**.
*   **Lock Files**: The engine creates a temporary `.lock` file (e.g., `data.dbig.lock`) to signal other processes to wait.
*   **Retries**: If a file is locked, the engine will "spin" (retry) up to **100 times**, waiting 10ms between each attempt.
*   **Safety**: This allows multiple BigC scripts or web server workers to write to the same database file simultaneously without corruption.

---

## 4. Multi-Value Packing

The `& set as` connector can bundle multiple return values into a single variable if specified.

**Syntax**: `... & set as list {[VariableName]}`

If a command (like `list folder`) returns multiple items, providing a single variable with the `list` modifier will cause the engine to pack all items into a valid JSON array string.

---

## 5. The "Doctor" Effect

When `attach fixer` is active, the engine enables internal **Indentation Healing**.
*   **Heuristic Alignment**: It attempts to "heal" broken loops by guessing the user's intent based on the starting token's indentation level.
*   **Indentation Tolerance**: The lexer becomes less strict about mixing tabs and spaces within indented blocks.
