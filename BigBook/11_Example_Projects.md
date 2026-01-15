# Example Projects

This chapter showcases how to combine BigC's modules into real-world tools. Each project demonstrates a different strength of the V.1.0 Mandate engine.

## 1. The Scraper & Vault
This script fetches a website and saves extracted data into an SQLite database.

```bigc
# news_saver.big
use web
use sql

# 1. Prepare Database
run sql "CREATE TABLE IF NOT EXISTS headlines (text TEXT)" on "news.db"

# 2. Fetch Website
user-agent "BigC Scraper"
get web "https://example.com" & set as {Html}

if any bug found
    print "Error: Site unreachable."
    stop run

# 3. Extract & Save
# Get the first H1 tag
look for "h1" @Html & set as {Title}
run sql "INSERT INTO headlines VALUES ('$Title')" on "news.db"

print "Saved headline: $Title"
```

## 2. API Server with Rate Limiting
A functional web server that replies with JSON and limits traffic to 60 requests per minute.

```bigc
# api_server.big
use web

# 1. Configuration
control limit 60 per mins
control record @"traffic.log"

# 2. Routes
on get "/status" run GetStatus
on post "/echo" run PostEcho

# 3. Logic
start doing GetStatus()
    reply note "Content-Type" as "application/json"
    reply with "{\"status\": \"active\", \"version\": \"1.0\"}"
end doing

start doing PostEcho()
    # Body is automatically populated for POST
    reply with "You sent: $RequestBody"
end doing

# 4. Launch
print "API Server starting on 8080..."
start server @8080
```

## 3. The "Luck" Database Seeder
Generates 10 random user profiles and saves them to a DBIG (JSON) file.

```bigc
# seeder.big
print "Seeding 10 users..."

# Smart Loop with limit
start loop.r.10
    # Generate fake identity
    get luck name & set as {F} {L}
    get luck email & set as {Email}
    
    # Save to JSON Database
    # Use Warp for the key name
    Key = w(user_$Count)
    Val = w($F $L <$Email>)
    dbig set Key as Val @"users.dbig"
    
    Count = Count + 1
keep Count < 10

print "Seeding complete."
```

## 4. File Management & Regex
A tool that searches for a specific pattern in a file and replaces it.

```bigc
# pattern_fixer.big

# 1. Check if file exists
Target = "config.txt"
check if Target here & set as {Exists}

if Exists = "false"
    write "Mode=Debug\nKey=123-ABC" @Target
or
    print "File found. Checking patterns..."

# 2. Read and Validate
open Target & set as {Data}
bmath Data @"\\d{3}-[A-Z]{3}" & set as {HasKey}

if HasOk = "true"
    print "Key format is valid."
or
    print "Key invalid! Repairing..."
    replace "Key=..." with "Key=999-REPAIRED" @Target
```

## 5. Python System Bridge
Demonstrates how to pass complex data from BigC to Python for advanced processing.

```bigc
# py_bridge.big
use pyBig

# Prepare data in BigC
BigC_Val = "The quick brown fox"

python3 start
# Python reads the data from the interpreter state (future)
# For now, we can use standard output
import sys
msg = "BigC Data Processor"
print(f"--- {msg} ---")
print("Python is processing...")
python3 end
```

```