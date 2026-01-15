# Chapter 5: Filesystem (Books)

The **Books** module provides a high-level, safe interface for interacting with the file system. BigC refers to files as "Books" in some contexts, but the commands use standard terms like `file` and `folder`.

---

## 5.1 Writing & Reading

### Write (Overwrite)
Creates a new file or completely overwrites an existing one.
*   **Syntax:** `write "[Content]" @"[Filename]"`
*   **Safety:** Automatically creates missing files.

```bigc
write "Chapter 1: The Beginning" @"story.txt"
```

### Add (Append)
Adds text to the end of a file without deleting existing content.
*   **Syntax:** `add "[Content]" @"[Filename]"`

```bigc
add "\nChapter 2: The Middle" @"story.txt"
```

### Open (Read)
Reads an entire file into a variable.
*   **Syntax:** `open "[Filename]" & set as {[Variable]}`
*   **Failure:** If the file is missing, the variable is empty, and `$BugType` is set.

```bigc
open "story.txt" & set as {Content}
print "File says: $Content"
```

---

## 5.2 Management (Create, Copy, Move, Delete)

### Create
Explicitly create empty files or folders.
*   `create file "config.txt" @"."`
*   `create folder "logs" @"."`

### Copy & Move
Duplicate or rename files.
*   **Copy:** `copy file @"source.txt" to @"dest.txt"`
*   **Move:** `move file @"old.txt" to @"new.txt"`

### Delete
Removes a file or a directory (and all its contents!).
*   **Syntax:** `delete file @"[Path]"`

```bigc
delete file @"temp.txt"
```

---

## 5.3 Advanced: Search & Replace

You can perform "Search & Replace" operations directly on files without manually opening them.

*   **Syntax:** `replace "[Old]" with "[New]" @"[Filename]"`

```bigc
# Updates config.txt directly on disk
replace "DEBUG=False" with "DEBUG=True" @"config.txt"
```

---

## 5.4 System Checks

### Check Existence
Verifies if a file or folder exists.
*   **Syntax:** `check if "[Path]" here & set as {[Result]}`
*   **Result:** Returns strings `"true"` or `"false"`.

```bigc
check if "save.json" here & set as {Exists}
if $Exists = "true" & print "Save found!"
```

### List Folder
Gets a list of all files in a directory.
*   **Syntax:** `list folder @"[Path]" & set as list {[ListVar]}`

```bigc
list folder @"." & set as list {Files}
start loop on {Files} as {File}
    print "Found: $File"
keep 1
```

---

### ✅ Verified Example: 05_filesystem.big
**File Path:** `manual_examples/05_filesystem.big`
```bigc
# 05_filesystem.big
# Verification of Filesystem Operations

# 1. Write & Append
write "Line 1" @"test_book.txt"
add "\nLine 2" @"test_book.txt"

# 2. Read
open "test_book.txt" & set as {Content}
print "Read Content: $Content"

# 3. Replace on Disk
replace "Line 1" with "Header" @"test_book.txt"
open "test_book.txt" & set as {Updated}
print "Updated Content: $Updated"

# 4. Folder Management
create folder "test_logs" @"."
create file "log.txt" @"test_logs"
check if "test_logs/log.txt" here & set as {Exists}
print "File Exists: $Exists"

# 5. List Folder
list folder @"test_logs" & set as list {Files}
start loop on {Files} as {F}
    print "Folder contains: $F"
keep 1

# 6. Cleanup
delete file @"test_logs"
delete file @"test_book.txt"
print "Cleanup Complete."
```
