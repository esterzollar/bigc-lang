# Chapter 18: Troubleshooting & Debugging

Even in a textbook language, mistakes happen. This chapter covers the tools and patterns used to find and fix issues in your BigC scripts.

---

## 1. The Fixer (Indentation Forgiveness)

Starting in **V.1.0 Mandate**, BigC includes a "Code Doctor" library that can automatically repair common formatting mistakes.

**Command**: `attach fixer`

When the Fixer is attached, the engine uses **Heuristic Lexing** to guess your intent:
*   **Loop Healing**: If you start a loop but forget the `keep` keyword or have inconsistent indentation, the Fixer attempts to "heal" the block.
*   **Usage**: Recommended for beginners or when porting code between different editors.

---

## 2. Deciphering $BugType

BigC does not use complex stack traces. Instead, it sets a global variable named `$BugType` when an operation fails.

| BugType | Meaning |
| :--- | :--- |
| `File Error` | Permission denied or file not found. |
| `BigNet Error` | DNS failure, Timeout, or invalid URL. |
| `DivisionByZero` | Attempted division by zero. |
| `Stack Overflow` | Recursive `doing` blocks called too deeply (>100 levels). |

---

## 3. The "Blessed Check" Pattern

Because BigC is designed to be resilient, it will not always crash on error. You must learn to "listen" for errors using the `any bug found` command.

### The Right Way
```bigc
open "secrets.txt" & set as {Data}

if any bug found
    print "Error loading secrets: $BugType"
or
    print "Secrets loaded successfully."
```

---

## 4. Common Pitfalls

### "Manual page not found" (404)
*   **Cause**: Variable scope issue. A local variable was accessed outside its `doing` block.
*   **Fix**: Add the `Raw` suffix to the variable (e.g., `ResultRaw`).

### "Safety Lock!" Error
*   **Cause**: Using a feature (like `sql` or `web`) without unlocking it.
*   **Fix**: Add `use sql` or `use web` at the top of your script.

### "Missing space before @"
*   **Cause**: Writing `write "Hi"@"file.txt"`.
*   **Fix**: Add a space: `write "Hi" @"file.txt"`.

### Reserved Keyword (Val)
*   **Cause**: Using `Val` as a variable name.
*   **Fix**: `Val` is reserved for internal engine use. Use `Value` or `MyVal` instead.

### Using Keywords as Variables (Step, Loop, etc.)
*   **Cause**: Using a command keyword like `Step`, `Loop`, or `Wait` as a variable name.
*   **Effect**: This can cause the engine to misinterpret your code, leading to infinite loops or commands being skipped. For example, writing `Step = 1` may be seen as a broken animation command rather than an assignment.
*   **Fix**: Always use descriptive names like `Counter`, `MyStep`, or `LoopIndex`.

---

## 5. Manual Debugging

The primary way to debug in V.1.0 Mandate is through manual inspection.
*   **Print**: Use `print "DEBUG: $VarName"` at various steps.
*   **Show**: Use `bigrun show [file]` from the terminal to see code statistics and structure.
*   **Whatis**: Use `bigrun whatis [keyword]` to verify the behavior of a specific command.
