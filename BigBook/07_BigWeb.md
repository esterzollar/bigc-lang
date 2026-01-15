# BigWeb (Web Server Engine)

BigWeb allows you to turn any BigC script into a functional, lightweight web server. It uses the internal **SBIG** (Servers of BigC) architecture to handle HTTP requests and responses.

## 1. Activation

You must unlock the web engine before using any server commands.

```bigc
use web
# OR
use sbig
```

## 2. Server Configuration (`control`)

Use the `control` command to configure server behavior before starting it.

### Rate Limiting
Limit the number of requests per minute to prevent abuse.
```bigc
# Limit to 100 requests per minute
control limit 100 per mins
```

### Logging
Record all incoming requests to a file.
```bigc
control record @"server.log"
```

### Advanced (Future/Partial)
*   **`control workers [N]`**: Sets the thread pool size (Currently reserved/single-threaded).
*   **`control ssl @"cert.pem" @"key.pem"`**: Configures SSL (Requires specific build features, otherwise falls back to HTTP).

## 3. Routing (`on`)

Define how the server responds to specific URL paths and HTTP methods.

**Syntax:** `on [get/post] "[Path]" run [DoingName]`

### Basic Routes
```bigc
on get "/" run Home
on post "/login" run Login
```

### Wildcard Routes (`+`)
Use `+` at the end of a path to match anything that follows. The matched suffix is stored in `$RequestExtra`.

```bigc
# Matches /user/123, /user/profile, etc.
on get "/user/+" run UserProfile
```

## 4. Request Variables

When a route is matched and the `doing` block is executed, the following global variables are automatically populated:

| Variable | Description |
| :--- | :--- |
| `$RequestPath` | The full URL path (e.g., `/user/123?q=1`). |
| `$RequestMethod` | The HTTP method (GET, POST). |
| `$RequestBody` | The raw body content (useful for POST/JSON). |
| `$RequestExtra` | The wildcard part of the URL (if `+` was used). |

## 5. Sending Replies (`reply`)

Inside your `doing` block, use `reply` commands to construct the response.

### Set Status Code
```bigc
reply point 404
```

### Set Headers
```bigc
reply note "Content-Type" as "application/json"
```

### Send Content
*   **Text/HTML**: Interpolates variables.
    ```bigc
    reply with "Hello $Name!"
    ```
*   **File**: Serves a file directly.
    ```bigc
    reply file "index.html"
    ```
*   **Biew/BSS**: Automatically transpiles UI files to HTML/CSS.
    ```bigc
    reply file "app.biew"
    ```

## 6. Starting the Server

The `start server` command starts the listening loop. **This command is blocking**, meaning the script will stay in this line forever (or until the process is killed).

**Syntax:** `start server @[Port]`

```bigc
print "Server running on port 8080..."
start server @8080
```

## 7. Example: API Server

```bigc
use web

# Configuration
control limit 60 per mins
control record @"api.log"

# Routes
on get "/hello" run SayHello
on post "/data" run ReceiveData

# Logic
start doing SayHello()
    reply note "Content-Type" as "application/json"
    reply with "{\"message\": \"Hello World\"}"
end doing

start doing ReceiveData()
    print "Received: $RequestBody"
    reply point 201
    reply with "Data Saved"
end doing

# Start
print "API listening at 3000"
start server @3000

## 8. Complete Example (`manual_examples/07_bigweb.big`)

```bigc
# Manual Example: 07 BigWeb
use web

# 1. Configuration
control limit 100 per mins
control record @"server_test.log"

# 2. Define Routes
on get "/" run Home
on get "/api/+" run ApiHandler

# 3. Define Logic
start doing Home()
    reply note "Content-Type" as "text/html"
    reply with "<h1>Welcome to BigWeb</h1>"
end doing

start doing ApiHandler()
    # $RequestExtra holds the part after /api/
    reply note "Content-Type" as "application/json"
    reply with "{\"endpoint\": \"$RequestExtra\"}"
end doing

# 4. Start Server
print "Starting BigWeb Test Server on 8085..."
start server @8085
```

```
