# Chapter 14: Standard Libraries (attach)

BigC features a modular "Environment" system designed for rapid development. Unlike `use lab`, which imports local project files, the `attach` command loads community-standard logic and system-wide helpers from the central `env_lib/` folder.

---

## 1. The Environment Philosophy

In BigC, we don't believe in "Indentation Hell" or complex object hierarchies. Our standard libraries follow the **Global Messenger Pattern**:
1.  **Set the Data:** You place your input into a global "Raw" variable (e.g., `MsgRaw`).
2.  **Attach the Power:** You load the library that knows how to handle that data.
3.  **Run the Block:** You call the specific function to process the data.

---

## 2. Library Reference

### **Statement** (`attach statement`)
The most common library. It provides standardized logging blocks.

*   **Global Variable:** `MsgRaw` (The text you want to log).
*   **Blocks:**
    *   `run LogInfo()`: Prefixes with `[INFO]`.
    *   `run LogWarning()`: Prefixes with `[WARNING]`.
    *   `run LogError()`: Prefixes with `[ERROR]`.
    *   `run LogSuccess()`: Prefixes with `[SUCCESS]`.

**Example:**
```bigc
attach statement
MsgRaw = "System initialized."
run LogSuccess()
```

### **Picker** (`attach picker`)
A wrapper for the `luck` engine that handles random number generation.

*   **Global Variable:** `ResultRaw` (Where the generated number is stored).
*   **Blocks:**
    *   `run Random()`: Generates a number between 1 and 100.

**Example:**
```bigc
attach picker
run Random()
print "The universe chose: $ResultRaw"
```

### **Gethor** (`attach gethor`)
Used for environment setup. It ensures necessary configuration files exist before your main logic runs.

*   **Logic:** Checks for `config.txt`. If missing, creates a default one.
*   **Blocks:**
    *   `run EnsureConfig()`

### **Fixer** (`attach fixer`)
The BigC "Code Doctor." Simply attaching this library changes how the engine behaves.

*   **Abilities:** Enables **Indentation Forgiveness**. When attached, the engine becomes less strict about tab/space matching in loops, attempting to "heal" your structure automatically.

---

## 3. Chaining Commands (`&`)

You can attach and use libraries on a single line using the `&` connector. This is the preferred "Professional Creator" style.

```bigc
attach statement & MsgRaw = "Quick Log" & run LogInfo()
```

---

## 4. Master Example: The Secure Bootloader

This example demonstrates using `gethor` to setup, `picker` to generate a security nonce, and `statement` to report status.

```bigc
# 1. Setup Environment
attach gethor & attach statement
attach picker & attach fixer

# 2. Ensure Configuration
run EnsureConfig()

# 3. Generate Security Nonce
run Random()
SecurityNonceRaw = ResultRaw

# 4. Report Status using Global Messenger Pattern
MsgRaw = w(Booting System with Nonce: "$SecurityNonceRaw")
run LogInfo()

# 5. Logic Check
if SecurityNonceRaw > 50
    MsgRaw = "Security level: HIGH"
    run LogSuccess()
or
    MsgRaw = "Security level: NORMAL"
    run LogWarning()

# 6. Final Clean Output
print "--- BOOT COMPLETE ---"
```

---

## 5. Creating Your Own
To add a library to your system, create a file ending in `.bigenv` inside your project's `env_lib/` folder. It will then be instantly available via the `attach` command in any script.