# Master Keyword Reference

BigC uses natural English verbs to make code readable. This reference covers all officially supported keywords in V.1.0 Mandate.

## 1. Core Engine
| Keyword | Description | Example |
| :--- | :--- | :--- |
| `use` | Unlocks modules (web, sql, guy, pyBig). | `use web` |
| `print` | Outputs text. Use `print update` for tickers. | `print "Hi"` |
| `ask input`| Prompts for terminal input. | `ask input ">"` |
| `replace` | Swaps text in variable/file. | `replace "A" with "B"` |
| `len` | Returns length of string or list. | `len"Hello"` |
| `tick / delta`| High-res time (ms). | `get time delta` |
| `event` | Manages global signal queue. | `event push "Ready"` |
| `wait` | Pauses execution (seconds). | `wait 1.5 s` |
| `build task`| Executes a system shell command. | `build task "ls"` |
| `stop run` | Immediately terminates the script. | `stop run` |

## 2. Logic & Flow
| Keyword | Description | Example |
| :--- | :--- | :--- |
| `if / or` | Linear logic conditions. | `if X > 10` |
| `doing` | Defines a logic block (function). | `start doing Greet()` |
| `run` | Executes a block or command. | `run Greet()` |
| `return` | Exits block with a value. | `return $Val` |
| `start loop`| Repeats code block (uses indentation). | `start loop` |
| `loop.r.N` | Safety loop with max retry limit. | `start loop.r.50` |
| `keep` | Loop condition check. | `keep X < 10` |
| `keep loop` | Resets safety loop counter. | `keep loop` |
| `stop loop` | Breaks the current loop. | `stop loop` |
| `any bug` | Checks if previous command failed. | `if any bug found` |

## 3. Data & Objects
| Keyword | Description | Example |
| :--- | :--- | :--- |
| `blueprint` | Defines a data template. | `[Blueprint: Hero]` |
| `pin` | Creates object from template. | `pin Hero to "p"` |
| `list` | backpack operations (add, sort, cut). | `list add "X" @{L}` |
| `map` | Dictionary operations (set, get, merge). | `map set "K" as "V"` |
| `pack` | Serializes Map to JSON string. | `pack {M} as json` |
| `unpack` | Deserializes JSON string to Map. | `unpack $S as map` |

## 4. Web & Networking
| Keyword | Description | Example |
| :--- | :--- | :--- |
| `on get/post`| Defines server route. | `on get "/" run Home` |
| `start server`| Launches web listener (blocking). | `start server @80` |
| `reply` | Construct server response. | `reply with "HTML"` |
| `get web` | HTTP GET request. | `get web "URL"` |
| `get post` | HTTP POST request. | `get post "URL"` |
| `look for` | Scrapes HTML/JSON. | `look for "h1" @Html` |

## 5. BigGuy (Graphics)
| Keyword | Description | Example |
| :--- | :--- | :--- |
| `start guy` | Launches UI window (blocking). | `start guy Main` |
| `view` | Defines UI screen and logic. | `start view Main` |
| `draw` | Renders widget or shape. | `draw button "OK"` |
| `step` | Smoothly animates a variable. | `step X towards 100` |
| `btnclick` | True if last button was clicked. | `if btnclick` |
| `keydown` | True if specific key is held. | `if keydown "a"` |

## 6. Filesystem
| Keyword | Description | Example |
| :--- | :--- | :--- |
| `open` | Reads file into variable. | `open "f.txt" & set` |
| `write / add`| Creates or appends to file. | `write "Hi" @"f.txt"` |
| `delete file`| Removes file or folder. | `delete file @"temp"` |
| `create folder`| Creates directory. | `create folder "App"` |
| `list folder`| Returns contents as a list. | `list folder @"."` |
| `check ... here`| Verifies existence. | `check if "f" here` |

## 7. Symbols
| Symbol | Name | Description |
| :--- | :--- | :--- |
| `&` | Connector | Links Cause to Effect. |
| `{}` | Container | Wraps variables for target/output. |
| `@` | Target | Physical pointer (Files/Maps). |
| `$` | Interpolator| Variable placeholder in strings. |
| `.` | Dot | Object property or shorthand. |
| `=x`| Not Equal | Logic operator (match failure). |
| `S[]`| Solver | Complex math constructor. |
| `w()`| Warp | Smart text constructor. |
