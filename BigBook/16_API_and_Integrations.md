# Chapter 16: API & System Integration

BigC is designed to be the "Glue" between different services. This chapter covers how to communicate with external APIs (like Telegram, Discord, or Stripe) and how to orchestrate system-level tasks.

---

## 1. Talking to APIs (The Flow)

A professional API request in BigC typically follows these four steps:

1.  **Identity**: Set your `user-agent` to identify your script.
2.  **Headers**: Use the `header` command to set `Content-Type` or Authorization tokens.
3.  **Action**: Perform a `get post` (or `get web`) with your payload.
4.  **Extraction**: Use `look for json` to parse the response.

### Example: Mock API Call
```bigc
use web

# 1. Setup Identity and Headers
user-agent "BigC Bot 1.0"
header "Content-Type" "application/json"
header "Authorization" "Bearer MY_SECRET_TOKEN"

# 2. Prepare Data
MyMsg = "Hello from BigC"
map set "message" as "$MyMsg" @{PayloadMap}
get {PayloadMap} & set as {Payload}

# 3. Execute POST
# (Note: Using a placeholder URL for this example)
get post "https://httpbin.org/post" with Payload & set as {Response}

# 4. Extract Result
look for json "url" @Response & set as {Result}
print "API reached: $Result"
```

---

## 2. Working with JSON

BigC makes JSON interaction intuitive by treating Maps as objects and strings as data payloads.

### Packing (Object to String)
To send data to an API, convert a Map into a JSON string.
*   **Syntax:** `get {MapName} & set as {[VariableName]}`

### Unpacking (String to Value)
To read data from an API response, use the `json` modifier.
*   **Syntax:** `look for json "[Key]" @[Source] & set as {[VariableName]}`

---

## 3. System Orchestration (Tasks)

BigC can execute system-level commands and capture their output using the `build task` command. This allows integration with any CLI tool (like Git, FFmpeg, or system utilities).

**Syntax:** `build task "[Command]" & set as {[VariableName]}`

*   **Behavior**: Runs the command in the system shell.
*   **Return**: The standard output (stdout) of the command as a string.
*   **Error Handling**: If the command fails, the output will contain a "Build Task Error" and the `any bug found` flag will be raised.

```bigc
# Get current system user
build task "whoami" & set as {User}
get User as clean & set as {User}
print "Current System User: $User"
```

---

## 4. Native Folder Management

While `build task` can handle directories, BigC provides native, cross-platform commands for folder management.

### Create Folder
Creates a new directory and any necessary parent directories.
**Syntax**: `create folder "[Name]" @"[Path]"`

### List Folder
Reads a directory and returns its contents as a BigC List (**Backpack**).
**Syntax**: `list folder @"[Path]" & set as list {[VariableName]}`

```bigc
list folder @"." & set as list {MyFiles}
start loop on {MyFiles} as {Item}
    print "Found: $Item"
keep 1
```

---

## 5. API Best Practices

*   **Secrets**: Never hardcode API keys. Use `setting "VAR_NAME"` to load them from environment variables.
*   **Timeouts**: BigNet has a hard-coded 30-second timeout. Always use `any bug found` to handle network issues.
*   **Sanitization**: Use `get [Var] as [Type]` to validate data before sending it to an API.
