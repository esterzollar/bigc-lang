# Chapter 2: Grammar & Syntax

To build with BigC, you must understand the rules of the "Textbook." BigC is strictly flat, meaning every symbol has a physical, predictable meaning. This chapter covers the core syntax that forms the foundation of all BigC applications.

---

## 2.1 Variables & The Equality Rule

In BigC, you create a variable by simply giving it a value. There are no types to declare.

*   **Strings:** Must be wrapped in **double quotes**.
*   **Numbers:** Integers or decimals are supported.
*   **Assignment:** Use a **single `=`**. BigC does not use `==` for comparisons; it uses `=` for everything.

```bigc
Name = "Ester"
Price = 10.50
Score = 100
Total = Price + 1.50  # Direct math assignment
```

> **⚠️ RESERVED WORD:** Never use the variable name `Val`. It is used internally by the engine. Use `Value` or `MyVal` instead.

---

## 2.2 Unlocking & Libraries

BigC is modular. To keep the engine light, advanced features must be "unlocked" or "attached".

### `use` (Module Unlocking)
Unlocks built-in engines like Web, SQL, or Python.
*   `use web` - Unlocks server and networking.
*   `use sql` - Unlocks SQLite database.

### `attach` (Environment Libraries)
Loads external `.bigenv` files from the `env_lib/` folder.
*   `attach statement` - Loads common logic helper libraries.
*   `attach len` - Loads `LenList` and `LenMap` for accurate item counting (see Section 2.7).

### `setting` (System Environment)
Retrieves global system environment variables (like API keys).
*   `setting "PATH" & set as {SysPath}`

---

## 2.3 Global Suffixes (Escaping Scope)

By default, variables created inside a `doing` block (function) are **Local**—they vanish when the block ends. To make a variable **Global** (accessible from anywhere), use one of these reserved suffixes:

*   **`Raw`** (General purpose shared data)
*   **`Content`** (Storage data)
*   **`Layout`** / **`Html`** / **`Biew`** (UI and Web data)

**Example:**
```bigc
start doing Setup()
    StatusRaw = "Online"  # GLOBAL (Accessible everywhere)
    TmpValue = 123        # LOCAL (Dies after "end doing")
end doing
```

---

## 2.3 The Grammar Symbols

BigC relies on four primary symbols to guide the logic:

### 1. `&` (The Connector)
The bridge between **Cause** and **Effect**. Use it to chain commands on a single line.
*   `if $X = 10 & print "Success!"`

### 2. `{}` (The Container)
Used to target a variable for **output**. When you see `{Var}`, think: "Put the result here."
*   `open "file.big" & set as {Data}`

### 3. `$` (The Interpolator)
Inserts the **value** of a variable into a string or comparison.
*   `print "Hello $Name"`
*   `if $Score > 50 & print "Pass"`
*   **Brace Syntax:** Use `${Var}` if the variable is touching other letters.
*   **Escaping:** Use `\$` to print a literal dollar sign.

### 4. `@` (The Target Indicator)
A **Physical Pointer** to a file, a map, or a specific index. 
*   **The Spacing Rule:** You must have a **Space BEFORE** and **No Space AFTER**.
*   **Correct:** `write "Hi" @"file.big"`
*   **Wrong:** `write "Hi"@"file.big"` or `write "Hi" @ "file.big"`

---

## 2.4 Advanced Constructors

### Warp `w()` (Smart Text)
**Warp** is a constructor for building strings without messy concatenation. Words are plain; variables are quoted.
*   `Msg = w(Hello "$Name"! Score: "$Score")`
*   **Currency:** For symbols like `$`, use the double-quote syntax: `$"$Price"`.
*   **Example:** `w(Price: $"$Cost")`

### Solver `S[...]` (Complex Math)
The **Solver** handles recursive math using **PEMDAS** (Parentheses, Exponents, Multi/Div, Add/Sub).
*   `Result = S[(10 + 5) * 2^2]`
*   **Pure Math Only:** You cannot use keywords (like `len`) inside `S[...]`. You must calculate values beforehand.

---

## 2.5 Math Modifiers (`as`)

You can transform and refine numbers using the `get ... as` pattern.

| Modifier | Description | Example |
| :--- | :--- | :--- |
| `floor` | Round DOWN to nearest integer. | `get 10.9 as floor` (10) |
| `ceil` | Round UP to nearest integer. | `get 10.1 as ceil` (11) |
| `round` | Round to NEAREST integer. | `get 10.5 as round` (11) |
| `abs` | Absolute value (remove minus). | `get -50 as abs` (50) |
| `smaller` | Get the lower of two numbers. | `get 10 20 as smaller` (10) |
| `bigger` | Get the higher of two numbers. | `get 10 20 as bigger` (20) |
| `between` | Clamp a value (Value Min Max). | `get X 0 100 as between` |

---

## 2.7 The Length Operator (`len`) vs. `attach len`

### Native `len` (Characters)
Use the native `len` keyword to get the **character count** of a string.
*   `Size = len{$Name}` (Returns 5 for "Ester")
*   **Warning:** If used on a List variable, it counts the characters in the JSON string (e.g., `["A","B"]` is 9 chars), NOT the number of items.

### Library `LenList` (Items)
To count items in a List or Map, use the helper from `attach len`.

```bigc
attach len
MyList = "[\"A\", \"B\", \"C\"]"

# Run the helper function
run LenList($MyList)
print "Items: $LenResultRaw" # Returns 3
```

---

## 2.8 Coder Shorthands

For fast typing, BigC supports symbolic shorthands for loop control.

| Full Command | Shorthand | Description |
| :--- | :--- | :--- |
| `start loop` | `s.loop` | Begins a repeating block. |
| `stop loop` | `loop.s` | Immediately breaks out. |

---

## 2.9 Standard Output (`print`)

The `print` command is the primary way to output text to the terminal.

*   **Standard Print:** Prints the text followed by a new line.
    *   `print "Hello World"`
*   **Update Print (Tickers):** Prints the text and remains on the same line, overwriting the previous `print update` content. This is ideal for progress bars, timers, or live status updates.
    *   `print update "Loading: $Percent%"`

---

### ✅ Verified Example: 02_grammar.big

**File Path:** `manual_examples/02_grammar.big`

```bigc
# 02_grammar.big
# Comprehensive Grammar & Syntax Test

# 1. Unlocking
attach len  # For LenList()

# 2. Scoping
start doing Setup()
    StatusRaw = "Online"
end doing
run Setup()

# 3. Spacing Rule (@)
write "Verified" @"manual_examples/verify.big"

# 4. Math Solver & Modifiers
Math = S[(10 + 5) * 2]
get -50 as abs & set as {Absolute}
get 150 0 100 as between & set as {Clamped}

# 5. Interpolation & Warp
Price = 10.50
Name = "Ester"
# Applying fix for w() currency syntax.
Msg = w(Hello "$Name"! The item costs "$Price".)
print "Warp Output: $Msg"

# 6. Length Operator (Native vs Library)
MyName = "Ester"
MyBackpack = "[\"A\", \"B\", \"C\"]"
NameLen = len{$MyName}
print "Length of '$MyName' is $NameLen"
run LenList($MyBackpack)
# Result is returned in LenResultRaw (Standard for 'len' library)
print "Items in Backpack: $LenResultRaw"

# 7. Standard Loop & Tickers
print "Verifying Loop & Print Update..."
Counter = 0
start loop
    Counter = Counter + 1
    print update "Loading: $Counter / 3"
    wait 0.2 s
keep $Counter < 3
print "\nLoop Finished."

# 8. Coder Shorthands (s.loop / loop.s)
print "Verifying Shorthands..."
ShortCount = 0
s.loop
    ShortCount = ShortCount + 1
    if $ShortCount = 3 & loop.s
keep 1
print "Shorthand Loop Finished at $ShortCount"
```
