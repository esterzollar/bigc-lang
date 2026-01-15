# Chapter 24: BigGuy Part 2 (The Tagged System)

BigGuy v2.0 introduces the **Tagged System**, which allows you to turn any visual element (like an image or a rectangle) into an interactive component. It also introduces basic audio support.

---

## 1. The Image Tagged System

Instead of using standard buttons, you can draw an image and "tag" it with a name. When the user clicks the image, the engine can detect the interaction.

### Syntax
`draw image "path/to/image.png" tag "MyComponent" at X Y size W H`

### How it works
1.  **Draw**: The engine renders the image.
2.  **Tag**: The engine tracks the bounding box of the element.
3.  **Click**: You can check for clicks on specific tags using `if click "Tag"`.

---

## 2. Interaction Logic

The tagged system allows you to separate your UI from your business logic.

```big
# Define the logic in a doing block
start doing OnPlay()
    print "PLAY BUTTON CLICKED!"
    beep
end doing

# Inside your view
start view Main
    draw image "assets/play.png" tag "PlayBtn" at 100 100 size 50 50
    
    # Check for the interaction
    if click "PlayBtn" & run OnPlay()
end view
```

---

## 3. Audio Support

BigGuy provides simple audio commands for feedback and sound effects.

*   **`beep`**: Plays a short system tone. Useful for debugging or basic UI confirmation.
*   **`play sound "[Path]"`**: Plays an audio file (`.wav`, `.mp3`, or `.ogg`).

---

## 4. Best Practices: Aspect Ratio

When drawing tagged images, always ensure the `size W H` matches the aspect ratio of the source file. If your image is 512x512, use `size 100 100`. Using `size 200 50` will result in a stretched image.

---

## 5. View Cleanliness

By using tags and `doing` blocks, your `view` stays focused on **what** to draw, while your `doing` blocks handle **what happens** when things are clicked.
