# Modular Programming (Labs)

BigC is designed to be lightweight and scalable. To manage complexity as your projects grow, you can use **Labs** and **Environments**.

## 1. Labs (User's Experiments)

A **Lab** is a reusable BigC script containing shared logic, usually `doing` blocks (functions) or global configuration variables. 

### `use lab`
The `use lab` command imports another BigC file into your current script. It is equivalent to copying and pasting the contents of that file at the point where the command is written.

**Syntax:** `use lab "[Filename].big"`

```bigc
# math_utils.big
start doing Square(n)
    Result = S[n * n]
    return Result
end doing

# app.big
use lab "math_utils.big"

run Square(5) & set as {Val}
print "Result is $Val"
```

## 2. Environments (Attached Helpers)

**Environments** are specialized libraries provided by the BigC community or built into the engine's ecosystem. They are stored as `.bigenv` files in the `env_lib/` directory.

### `attach`
The `attach` command specifically searches the `env_lib/` folder for a matching library name.

**Syntax:** `attach [Name]`

```bigc
# Loads env_lib/statement.bigenv
attach statement

run LogInfo("System Initialized")
```

## 3. Recommended Project Structure

To keep your code clean, follow the **Blessed Way** structure:

*   **`app.big`**: Your main entry point.
*   **`logic.big`**: A Lab file containing all your `doing` blocks.
*   **`env_lib/`**: Directory for shared `.bigenv` utilities.
*   **`assets/`**: Images, sounds, and data files.

### Example Entry Point:
```bigc
# 1. Unlocks & Attachments
use web
attach statement

# 2. Logic Labs
use lab "logic.big"

# 3. Execution
run StartApp()
```

## 4. Complete Example (`manual_examples/13_modular.big`)

```bigc
# Manual Example: 13 Modular Programming
# Demonstrates both Labs and Environments

# 1. Attach a standard library
attach statement

# 2. Create a temporary Lab file
write "start doing Helper()\n    print \"Hello from the Lab!\"\nend doing" @"temp_lab.big"

# 3. Use the Lab
use lab "temp_lab.big"

# 4. Run logic from both sources
run Helper()
run LogSuccess("Modular test passed!")

# Cleanup
delete file @"temp_lab.big"
```
