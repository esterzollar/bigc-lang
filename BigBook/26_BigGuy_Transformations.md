# Chapter 26: BigGuy Visual Transformations (Visual Magic)

BigGuy provides a suite of math-based visual modifiers that allow you to animate, colorize, and style your UI elements dynamically. These transformations are applied directly in the `draw` command, making them easy to link with variables for smooth animation.

---

## 1. Visual Modifiers

You can apply these modifiers to **Images**, **Rectangles**, and other shapes.

### Rotation (`rotate`)
Rotates the element around its center point.
*   **Unit:** Degrees (0 to 360).
*   **Syntax:** `rotate [Degrees]`
*   **Example:** `draw image "wheel.png" rotate $Angle`

### Scaling (`scale`)
Resizes the element relative to its base `size`.
*   **Unit:** Multiplier (1.0 = Normal, 0.5 = Half Size, 2.0 = Double Size).
*   **Syntax:** `scale [Factor]`
*   **Example:** `draw rectangle size 100 100 scale $PulseFactor`
*   **Note:** Scaling affects the visual size but maintains the center position.

### Opacity (`alpha`)
Controls the transparency of the element.
*   **Unit:** 0.0 (Invisible) to 1.0 (Fully Opaque).
*   **Syntax:** `alpha [Value]`
*   **Example:** `draw text "Ghost" alpha 0.5`

### Color Tint (`tint`)
**For Images Only:** Multiplies the image's pixels by a specific color.
*   **Syntax:** `tint "#HexCode"`
*   **Usage:** Useful for status effects (Red for damage, Blue for frozen) or theming white icons.
*   **Example:** `draw image "icon.png" tint "#FF0000"` (Turns white pixels red).

---

## 2. Styling Shapes (Outlines)

You can add borders to `rectangle`, `circle`, and `triangle` commands.

*   **`stroke "#HexCode"`**: Sets the color of the outline.
*   **`border [Thickness]`**: Sets the width of the outline in pixels.

```bigc
# Draw a black box with a thick purple outline
draw rectangle size 200 100 fill "#000000" stroke "#FF00FF" border 5
```

---

## 3. Auto-Layering (The Ren'Py Standard)

By default, BigGuy draws elements in the order they appear in your code (Painters Algorithm). However, for complex scenes like Visual Novels or Games, you often want specific elements (like backgrounds) to *always* stay behind characters, regardless of code order.

### Enabling Auto-Layering
Add this command at the top of your `.guy` file:
```bigc
use autolayering
```

### Assigning Layers
Add the `layer "[Name]"` property to your draw commands. The engine renders layers in this specific order:

1.  **`"bg"`** or **`"background"`**: The deepest layer. Drawn first.
2.  **`"master"`** (Default): The standard middle layer for characters and objects.
3.  **`"ui"`** or **`"overlay"`**: The topmost layer. Drawn last (on top of everything).

```bigc
# Even if written first, this draws on top!
draw text "Score: 100" layer "ui"

# Even if written last, this draws behind!
draw image "sky.jpg" layer "bg"
```

---

## 4. Master Example: Visual Magic Showcase

This example demonstrates all three major transformation types (Rotation, Scale, Alpha) running simultaneously, along with Auto-Layering to manage the scene depth.

```bigc
# manual_examples/26_bigguy_transform.guy
use autolayering

start view Main
    init
        set window title "BigGuy Transformations Verification"
        set window size 800 600
        
        # Animation State
        RotationRaw = 0
        ScaleRaw = 1.0
        ScaleDirRaw = 1
        AlphaRaw = 1.0
        AlphaDirRaw = -1
    end

    # --- LOGIC (Animation Math) ---
    
    # 1. Rotate (0 to 360)
    RotationRaw = RotationRaw + 2
    if RotationRaw > 360 & RotationRaw = 0
    
    # 2. Pulse Scale (0.8 to 1.2)
    if ScaleDirRaw = 1 & ScaleRaw = ScaleRaw + 0.005
    if ScaleDirRaw = -1 & ScaleRaw = ScaleRaw - 0.005
    if ScaleRaw > 1.2 & ScaleDirRaw = -1
    if ScaleRaw < 0.8 & ScaleDirRaw = 1
    
    # 3. Fade Alpha (0.2 to 1.0)
    if AlphaDirRaw = 1 & AlphaRaw = AlphaRaw + 0.005
    if AlphaDirRaw = -1 & AlphaRaw = AlphaRaw - 0.005
    if AlphaRaw > 1.0 & AlphaDirRaw = -1
    if AlphaRaw < 0.2 & AlphaDirRaw = 1

    # --- RENDER ---
    
    # Layer: bg (Background - Static)
    draw rectangle size 800 600 fill "#111122" layer "bg" at 0 0

    # Layer: master (Transformations)
    
    # A. Rotation & Tint (Red Tinted Spinning Backpack)
    draw text "Rotation & Tint" at 100 50 size 16 layer "master"
    draw image "png folder/backpack.png" at 150 150 size 100 100 rotate RotationRaw tint "#FF8888" layer "master"
    
    # B. Scale & Stroke (Pulsing Box with White Border)
    draw text "Scale & Stroke" at 350 50 size 16 layer "master"
    draw rectangle at 400 150 size 100 100 fill "#4444FF" scale ScaleRaw stroke "#FFFFFF" border 4 layer "master"
    
    # C. Alpha (Ghosting Character)
    draw text "Alpha Fade" at 600 50 size 16 layer "master"
    draw image "png folder/mrincredible.png" at 600 150 size 100 150 alpha AlphaRaw layer "master"

    # Layer: ui (On Top)
    draw text "BigGuy Phase 2: Visual Magic" at 20 550 size 24 layer "ui" fill "#FFFFFF"
    
    if keydown "escape" & stop run
end view

start guy Main
```
