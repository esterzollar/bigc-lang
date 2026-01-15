# Chapter 28: BigGuy Rich Text & Markdown

BigGuy includes a native Markdown rendering engine powered by **Egui**. This allows you to create rich, formatted text displays—perfect for dialogue systems, help manuals, or quest logs—without manually drawing hundreds of text lines.

---

## 1. The `draw markdown` Command

This command renders a block of Markdown text. It handles word wrapping, scrolling (if inside a scroll area), and styling automatically.

*   **Syntax:** `draw markdown $Variable style [StyleBase] at [X] [Y] width [W]`
*   **$Variable:** The string variable containing the Markdown text.
*   **StyleBase:** The prefix for your sub-styles (e.g., `Wiki`).
*   **Width:** (Optional) Sets the maximum width of the text block before wrapping occurs.

---

## 2. The Sub-Style System

Markdown rendering uses a hierarchical styling system. Instead of defining one style, you define a **Base Name**, and the engine looks for specific suffixes to style different Markdown elements.

### Supported Suffixes
| Suffix | Markdown Element | Example |
| :--- | :--- | :--- |
| `.h1` | `# Header 1` | `Wiki.h1` |
| `.h2` | `## Header 2` | `Wiki.h2` |
| `.body`| Standard Text | `Wiki.body` |
| `.bold`| `**Bold**` | `Wiki.bold` |
| `.italic`| `*Italic*` | `Wiki.italic` |
| `.link` | `[Link](url)` | `Wiki.link` |
| `.quote`| `> Blockquote` | `Wiki.quote` |
| `.code` | `` `Code` `` | `Wiki.code` |

### Defining Sub-Styles
You define these using standard `start style` blocks.

```bigc
# Base Body Text
start style Wiki.body
    size 16
    fill "#FFFFFF"
    font "NotoSans-Regular"
end style

# Header 1 Override
start style Wiki.h1
    size 32
    fill "#00D1FF"
    font "NotoSans-Bold"
end style

# Link Override
start style Wiki.link
    fill "#22C55E"
end style
```

---

## 3. Loading Content

The best practice is to load your Markdown content from an external file using the **Books** (Filesystem) module.

```bigc
open "assets/help.md" & set as {HelpText}
draw markdown $HelpText style Wiki at 20 20 width 760
```

---

## 4. Master Example: The Knowledge Base

This example demonstrates how to set up a complete styling system for a documentation page.

```bigc
# manual_examples/28_bigguy_markdown.guy
use guy

# --- 1. DEFINE STYLES ---
start style Wiki.h1
    size 40
    fill "#00D1FF" # Cyan
end style

start style Wiki.body
    size 18
    fill "#FFFFFF" # White
end style

start style Wiki.bold
    fill "#FFFF00" # Yellow
end style

start style Wiki.link
    fill "#22C55E" # Green
end style

start style Wiki.quote
    fill "#888888" # Grey
end style

# --- 2. VIEW ---
start view Main
    init
        set window title "BigGuy Markdown Verification"
        set window size 800 600
        
        # Markdown Content (Usually loaded from file)
        MDContentRaw = "# Welcome to BigC\nThis is a **Markdown** rendering test.\n\n*   Native Egui Integration\n*   Automatic Word Wrapping\n*   [Click to visit Wiki](https://bigc.org)\n\n> This is a blockquote showing the vertical bar style."
    end

    draw rectangle size 800 600 fill "#1A1A2E" at 0 0

    # Draw Markdown using the 'Wiki' style base
    draw markdown $MDContentRaw style Wiki at 40 40 width 720
    
    if keydown "escape" & stop run
end view

start guy Main
```