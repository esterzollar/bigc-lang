# Utilities & Integration

BigC includes a suite of built-in utilities for data generation, security, pattern matching, and external integration.

## 1. The Luck Lab (Identity Generator)

The `luck` module generates random, realistic data. It is particularly useful for seeding databases or automated testing.

**Syntax:** `get luck [Type] & set as {[Variable(s)]}`

| Type | Description | Returns |
| :--- | :--- | :--- |
| `name` | Full Identity | **Two Values:** {First} {Last} |
| `first`| First Name | String |
| `last` | Last Name | String |
| `email`| Random Email | String |
| `random`| Range | `random [Min] [Max]` |
| `uuid` | Unique ID | v4 UUID String |
| `ua`   | User Agent | Browser ID String |
| `zip`  | Zip Code | 5-digit string |
| `street`| Street Name| String |

```bigc
get luck name & set as {First} {Last}
print "Generated User: $First $Last"
```

## 2. Cryptography (Bit)

The **Bit** module provides tools for data encryption and text scrambling.

### NEBC (Native Encryption of BigC)
A lightweight rolling cipher unique to BigC.
*   **Encoding:** `bit code "[Text]" with "[Key]" nebc & set as {[Var]}`
*   **Decoding:** `bit decode "[Secret]" with "[Key]" nebc & set as {[Var]}`

### Universal AES (AES-256-CBC)
Industry-standard encryption.
*   **Syntax:** `bit aes [encrypt/decrypt] "[Data]" key "[32ByteKey]" iv "[16ByteIV]" & set as {[Var]}`

### The Demon (Scrambler)
Irreversibly scrambles text into random noise. 
*   **Syntax:** `bit demon "[Text]" & set as {[Var]}`

## 3. Pattern Matching (Bmath)

Bmath uses the Rust Regex engine to validate text against patterns.

**Syntax:** `bmath "[Text]" @"[Pattern]" & set as {[Result]}`

*   **Result:** Returns string `"true"` or `"false"`.
*   **Note:** Pattern must be attached to `@` with a leading space.

```bigc
# Check if input is a valid email
bmath "tester@bigc.org" @"^.+@.+\..+$" & set as {IsValid}
```

## 4. String Manipulation

Transform text using the `get ... as` modifier.

| Modifier | Description | Example |
| :--- | :--- | :--- |
| `clean` | Trims leading/trailing whitespace. | `get "  hi  " as clean` |
| `bigcap` | Converts to ALL UPPERCASE. | `get "hi" as bigcap` |
| `lower` | Converts to all lowercase. | `get "Hi" as lower` |

### In-Place Replacement
Swap text during a `get` operation.
**Syntax:** `get [Source] replace "[Old]" with "[New]" & set as {[Var]}`

```bigc
get "Apples are Red" replace "Red" with "Green" & set as {Msg}
```

## 5. Time & Performance

### Unix Timestamp
**Syntax:** `get time unix & set as {[Var]}` (Seconds since 1970)

### High-Res Ticks (v0.7)
*   **`tick`**: Milliseconds since the program started.
*   **`delta`**: Milliseconds since the last `delta` check (useful for loops).

```bigc
get time tick & set as {Start}
wait 0.5 s
get time delta & set as {Elapsed}
print "Task took $Elapsed ms"
```

## 6. External Integration (PyBig)

Execute native Python 3 code directly within your BigC script.

**Unlock:** `use pyBig`

```bigc
use pyBig

python3 start
import os
print(f"Current Directory: {os.getcwd()}")
python3 end
```

## 7. CLI Command Arguments

Retrieve text passed to the script via the terminal.

**Syntax:** `get command & set as list {[VariableName]}`

```bigc
# Run: bigrun app.big --silent
get command & set as list {Args}
get from {Args} @1 & set as {FirstArg}
if FirstArg = "--silent" & print "Silent Mode On"
```

## 8. Complete Example (`manual_examples/09_utilities.big`)

```bigc
# Manual Example: 09 Utilities
use pyBig

# 1. Luck
get luck name & set as {F} {L}
print "Generated: $F $L"

# 2. Crypto
Key = "secret-key-12345"
bit code "Hello World" with Key nebc & set as {Secret}
print "Encrypted: $Secret"
bit decode Secret with Key nebc & set as {Plain}
print "Decoded: $Plain"

# 3. Regex
bmath "123-456" @"^\d+-\d+$" & set as {IsMatch}
print "Matches pattern? $IsMatch"

# 4. String
get "  BigC  " as clean & set as {Cleaned}
get Cleaned as bigcap & set as {Final}
print "Final String: '$Final'"

# 5. Time
get time tick & set as {T}
print "Engine Uptime: $T ms"

# 6. Python
python3 start
print("Hello from Python 3!")
python3 end
```
