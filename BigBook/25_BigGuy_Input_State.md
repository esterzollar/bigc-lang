# Chapter 25: BigGuy Phase 2 (Input State)

The **BigGuy Input State System** provides granular control over user interaction. While standard buttons (`draw button`) handle clicks automatically, the **Tag System** allows you to transform any shape or image into a fully interactive object capable of detecting hovering, pressing, and dragging.

---

## 1. The Tagged Interaction Model

To make an element "state-aware," you must assign it a **Tag**. This tag acts as a unique identifier that the engine uses to track the mouse's relationship with that specific element.

### Supported Elements
*   **Images:** `draw image "..." tag "MyTag"`
*   **Rectangles:** `draw rectangle tag "MyTag"` (and `draw rounded`)

> **Note:** Tags must be unique within a single View to ensure the engine correctly identifies which element the user is interacting with.

---

## 2. Interaction Conditions

Once an element is tagged, you can use the following conditions inside your `view` or `doing` blocks to create reactive behavior.

### Hover (`if hover "Tag"`)
Returns **True** if the mouse cursor is currently within the bounding box of the tagged element.
*   **Usage:** Creating tooltips, highlight effects, or cursor changes.
*   **Example:** `if hover "Box" & ColorRaw = "#00FF00"`

### Press (`if press "Tag"`)
Returns **True** if the primary mouse button is currently held down while the cursor is over the element.
*   **Usage:** Creating "active" button states or clicking visual feedback.
*   **Example:** `if press "Box" & ColorRaw = "#0000FF"`

### Drag (`if drag "Tag"`)
Returns **True** if the user is moving the mouse while holding the button down on the element.
*   **Usage:** Drag-and-drop interfaces, sliders, or moving characters.
*   **Movement Variables:** When an element is being dragged, the engine automatically populates two high-resolution variables:
    *   `$DragX`: The horizontal distance moved since the last frame.
    *   `$DragY`: The vertical distance moved since the last frame.

```bigc
if drag "MyBox"
    # Update position based on frame delta
    PosX = PosX + $DragX
    PosY = PosY + $DragY
end if
```

---

## 3. Global Interaction Variables

The engine provides several real-time variables to help calculate complex interactions.

| Variable | Description |
| :--- | :--- |
| `$MouseX` | Current horizontal position of the mouse cursor. |
| `$MouseY` | Current vertical position of the mouse cursor. |
| `$DragX` | Horizontal drag delta (movement since last frame). |
| `$DragY` | Vertical drag delta (movement since last frame). |
| `$Tick` | Total milliseconds elapsed since the program started. |

---

## 4. The Golden Rule: Resetting State

Because `view` blocks run 60 times per second, interaction logic should usually follow a **"Reset and Check"** pattern. This ensures that visual effects (like colors) return to their default state as soon as the user stops interacting.

```bigc
# Reset to default every frame
ColorRaw = "#FF0000"

# Check for interaction to override default
if hover "MyBox" & ColorRaw = "#00FF00"
```

---

## 5. Master Example: Input Verification

This example demonstrates a complete interactive system using a single tagged rectangle. It features color-shifting feedback and fluid drag-and-drop movement.

```bigc
# manual_examples/25_bigguy_input.guy

start view Main
    init
        set window title "BigGuy Input State Verification"
        set window size 600 400
        
        # Position using Global Suffixes
        BoxXRaw = 250
        BoxYRaw = 150
        StatusRaw = "Idle"
        BoxColorRaw = "#FF4444"
    end

    # 1. Reset frame state to defaults
    StatusRaw = "Idle"
    BoxColorRaw = "#FF4444"

    # 2. Hover Detection (Visual: Green)
    if hover "TestBox"
        StatusRaw = "Hovering"
        BoxColorRaw = "#44FF44"
    end if

    # 3. Press Detection (Visual: Blue)
    if press "TestBox"
        StatusRaw = "Pressing"
        BoxColorRaw = "#4444FF"
    end if

    # 4. Drag Detection (Logic: Movement)
    if drag "TestBox"
        StatusRaw = "Dragging"
        BoxXRaw = BoxXRaw + $DragX
        BoxYRaw = BoxYRaw + $DragY
    end if

    # --- UI RENDER ---
    draw text "BigGuy Input State Test" at 20 20 size 24
    draw text "Status: $StatusRaw" at 20 60 size 18 fill "#FFFF00"
    draw text "Drag the box below!" at 20 100 size 14
    
    # The Interactive Box
    draw rectangle at BoxXRaw BoxYRaw size 100 100 fill BoxColorRaw tag "TestBox"
    
    # Mouse Position Monitor
    draw text "Mouse: $MouseX , $MouseY" at 450 20 size 12 alpha 0.5
    
    if keydown "escape" & stop run
end view

start guy Main
```

---

## 6. Pro-Tip: Element Ordering

In BigGuy, interaction is handled in the order elements are drawn. If two tagged elements overlap, the one drawn **last** (the one on top) will capture the interaction first. If you are using `use autolayering`, elements on the `"ui"` layer will always capture interaction before those on `"master"` or `"bg"`.