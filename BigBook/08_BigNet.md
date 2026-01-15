# BigNet (Networking & Scraping)

BigNet is the engine's window to the internet. It provides a high-level, blocking client for fetching web pages, interacting with APIs, and extracting data from HTML and JSON.

## 1. HTTP Requests

All BigNet requests have a hard-coded **30-second timeout**. If a request takes longer, it will fail and raise the `any bug found` flag.

### GET Request
Fetches the content of a URL.
**Syntax:** `get web "[URL]" & set as {[Variable]}`

```bigc
get web "https://example.com" & set as {Html}
```

### POST Request
Sends data to a URL.
**Syntax:** `get post "[URL]" with "[Data]" & set as {[Variable]}`

*   **Default Content-Type:** `application/x-www-form-urlencoded`.
*   **JSON Support:** Use the `header` command before `get post` to set `Content-Type` to `application/json`.

```bigc
# Sending JSON to an API
header "Content-Type" "application/json"
Payload = "{\"id\": 123}"
get post "https://api.example.com/update" with Payload & set as {Response}
```

## 2. Global Client Settings

Settings configured in the script persist for all subsequent networking calls.

| Command | Description |
| :--- | :--- |
| `user-agent "[UA]"` | Sets the User-Agent header for identification. |
| `proxy "[URL]"` | Routes traffic through an HTTP/SOCKS5 proxy. |
| `header "[K]" "[V]"` | Adds a custom HTTP header. |

```bigc
user-agent "BigC Scraper v1.0"
header "Authorization" "Bearer TOKEN123"
```

## 3. Scraping (`look for`)

The `look for` command extracts specific data from strings (usually HTML or JSON).

### CSS Selectors (HTML)
Extract text or attributes from HTML using standard CSS selectors.
**Syntax:** `look for "[Selector]" @[Source] & set as {[Variable]}`

```bigc
get web "https://news.ycombinator.com" & set as {Html}
# Extract the first matching element's text
look for ".titleline a" @Html & set as {TopHeadline}
```

### JSON Lookup
Retrieve a value from a JSON string by its key.
**Syntax:** `look for json "[Key]" @[Source] & set as {[Variable]}`

**Important:** Chained lookups are required for nested JSON as dot notation is not supported.

```bigc
# Example of nested extraction: { "user": { "name": "John" } }
look for json "user" @ApiResponse & set as {UserObj}
look for json "name" @UserObj & set as {Name}
```

## 4. Data Validation

Verify the integrity of strings using `get ... as`.

| Type | Description |
| :--- | :--- |
| `email` | Checks for valid email format. |
| `number` | Checks if string is a numeric value. |
| `url` | Checks if string starts with http:// or https://. |
| `alphanumeric` | Checks if string contains only letters and numbers. |

```bigc
get MyIP as alphanumeric & set as {IsOk}
```

## 5. Complete Example (`manual_examples/08_bignet.big`)

```bigc
# Manual Example: 08 BigNet
# Tests HTTP GET, POST, Scraping, and JSON Parsing

# 1. Setup Identity
user-agent "BigC Manual Test/1.0"
header "Accept" "application/json"

# 2. Test GET Request
print "Fetching httpbin.org/get..."
get web "https://httpbin.org/get" & set as {Response}

if any bug found
    print "GET Failed: $BugType"
    stop run

# 3. Test JSON Extraction (Chained)
look for json "headers" @Response & set as {Headers}
look for json "User-Agent" @Headers & set as {MyUA}
print "My User-Agent is: $MyUA"

# 4. Test POST Request
print "\nSending POST to httpbin.org/post..."
header "Content-Type" "application/json"
Payload = "{\"message\": \"Hello from BigC\"}"
get post "https://httpbin.org/post" with Payload & set as {PostResponse}

# Chained lookup for nested "json" -> "message"
look for json "json" @PostResponse & set as {JsonPart}
look for json "message" @JsonPart & set as {ReturnedMsg}
print "Server returned: $ReturnedMsg"

# 5. Test Data Validation
get ReturnedMsg as alphanumeric & set as {IsAlpha}
print "Is message alphanumeric? $IsAlpha"
```
