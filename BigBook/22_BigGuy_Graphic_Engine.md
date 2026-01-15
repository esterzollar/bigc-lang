# Chapter 22: BigGuy Graphic Engine (V.1.0 Mandate)

The **BigGuy Engine** is the native, high-performance GUI system for BigC. Unlike terminal scripts, BigGuy opens a real, GPU-accelerated window on your desktop.

---

## 1. The Golden Rule: Use `.guy`

To activate the Graphic Engine, your script **MUST** have the `.guy` file extension.
*   **`.big`**: Runs in console mode (Terminal).
*   **`.guy`**: Launches the BigGuy Window Loop immediately.

> **CRITICAL CAUTION:** Do NOT use the command `use guy` inside a `.guy` file!
> *   The `.guy` extension *already* launches the window engine.
> *   Adding `use guy` will attempt to launch a **second** window engine inside the first one, causing a "Dual Window" crash or freeze.
> *   Only use `use guy` inside standard `.big` scripts if you intend to launch a window manually.

---

## 2. Architecture: Brain & Face

BigGuy uses a **Split-Engine Architecture** for performance:
1.  **The Brain (Interpreter)**: Handles logic, variables, and math.
2.  **The Face (GuyEngine)**: Handles windowing, rendering (60 FPS), and input.

Both engines share the same variable memory. If you update a variable in your logic, the Face sees it instantly.

---

## 3. The View-Based Structure

Modern BigGuy apps use **Views** to organize rendering. A View is reactive; it is re-read and rendered 60 times per second.

```big
start view Main
    # INITIALIZE (Runs Once)
    init
        BallX = 100
        BallY = 100
    end

    # RENDER (Runs Every Frame)
    draw circle at BallX BallY radius 10 fill "Blue"
end view

start guy Main
```

---

## 4. Key Concepts

### Time & Physics (`$Delta`)
`$Delta` holds the time (in seconds) passed since the last frame (~0.016s). Use it to make movement frame-independent.
*   `Pos = Pos + (Speed * $Delta)`

### Smooth Animation (`step`)
The `step` command smoothly interpolates a variable toward a target value.
*   **Syntax**: `step {Variable} towards {Target} speed {Nx}`

### Input Detection
*   **`if btnclick`**: True if a button was clicked this frame.
*   **`if click`**: True if any click occurred on the window.
*   **`if keydown "Key"`**: True if a key (e.g., "space", "w") is held down.

---

## 5. Drawing Reference

| Command | Description |
| :--- | :--- |
| `draw rectangle` | Draws a box at X Y with Size W H. |
| `draw circle` | Draws a circle with Radius N. |
| `draw rounded` | Draws a rounded box with Radius N. |
| `draw text "..."` | Renders text. Supports `size`, `font`, and `fill`. |
| `draw button "..."`| Renders a clickable button. Sets `btnclick`. |
| `draw image "..."` | Renders a PNG/JPG/PPM file. |

---

## 6. Window Control

*   **`set window title "..."`**: Sets the window title.
*   **`set window size W H`**: Sets the window dimensions.
*   **`stop run`**: Closes the window and exits the program.