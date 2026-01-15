# Chapter 23: Math Lab

BigC V.1.0 Mandate introduces a powerful math engine capable of advanced recursive calculations and system monitoring.

---

## 1. Advanced Math Functions

These keywords are available for use in any calculation.

| Keyword | Description | Example |
| :--- | :--- | :--- |
| `remainder` | Modulo operation. | `10 remainder 3` (Returns 1) |
| `sqrt` | Square Root. | `sqrt 16` (Returns 4) |
| `sin`, `cos`, `tan` | Trigonometric functions (Degrees). | `sin 90` (Returns 1) |
| `abs` | Absolute Value. | `abs -50` (Returns 50) |
| `log` | Logarithm (Base 10). | `log 100` (Returns 2) |
| `minimum` | Smallest of two values. | `minimum 10 20` (Returns 10) |
| `maximum` | Largest of two values. | `maximum 10 20` (Returns 20) |
| `pi` | The constant π. | 3.14159... |
| `euler` | The constant *e*. | 2.71828... |

---

## 2. System Variables

The engine automatically updates these variables. They are read-only and available globally.

| Variable | Description |
| :--- | :--- |
| `BigTick` | Total milliseconds elapsed since the program started. |
| `BigDelta` | The time (in seconds) it took to render the previous frame. Essential for physics. |
| `$MouseX` | Current Mouse X position (BigGuy only). |
| `$MouseY` | Current Mouse Y position (BigGuy only). |

---

## 3. The Solver (`S[...]`)

The Solver is the preferred way to perform complex math. It supports full **PEMDAS** order of operations.

*   **Syntax**: `S[ (10 + 2) * sqrt(16) ]`
*   **Recursive**: Parentheses can be nested arbitrarily deep.

```bigc
# Calculate Hypotenuse
SideA = 3
SideB = 4
Hypot = S[ sqrt( SideA^2 + SideB^2 ) ]
print "Hypotenuse: $Hypot"
```
