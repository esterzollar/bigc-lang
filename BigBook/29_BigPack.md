# Chapter 29: BigPack (Deployment & Security)

BigPack is the distribution engine for BigC. It allows creators to bundle their entire project—scripts, images, and data—into a single, secure file with the `.bigpak` extension.

---

## 1. Why use BigPack?

1.  **Security:** Core files are obfuscated using a XOR-cipher. Normal users cannot read your logic in a text editor.
2.  **In-Memory Execution:** When a `.bigpak` is run, the engine reads files directly into RAM. **No source files are ever written to the user's disk.**
3.  **Simplicity:** Instead of sharing a folder with 100 files, you share one `.bigpak` file.

---

## 2. Creating an Archive (`pack`)

Use the `pack` command to turn a project folder into an archive.

*   **Syntax:** `bigrun pack [folder] [output.bigpak]`
*   **Action:** Recursively bundles everything inside the folder.

```bash
# Example: Pack your 'MyGame' folder
./bigrun pack MyGame release.bigpak
```

---

## 3. Running an Archive

Users can run your archive just like a standard script.

*   **Command:** `bigrun release.bigpak`
*   **Bootstrapping:** The engine will automatically look for `app.big` or `main.guy` inside the archive to start the program.

---

## 4. Extracting an Archive (`bunpack`)

If you need to get your files back out of an archive:

*   **Syntax:** `bigrun bunpack [file.bigpak]`
*   **Action:** Restores the original folder structure and files.

```bash
./bigrun bunpack release.bigpak
```

---

## 5. Security Note

While BigPack obfuscates your code, remember that a determined hacker with a debugger can always see what an engine is doing. BigPack is designed to protect your hard work from **casual tampering and unauthorized copying**, providing a professional "Hidden Source" experience similar to commercial game engines.
