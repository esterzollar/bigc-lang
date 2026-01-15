# Chapter 6: Databases (The Vault)

The Vault module provides persistent storage for your applications. BigC supports two formats: the native **DBIG** (Key-Value) and the standard **DBR** (SQLite).

---

## 6.1 Native DBIG (Key-Value)

The **DBIG** format is a simple, human-readable text database. It is designed for high concurrency using **Atomic Spin-Locks**, meaning multiple scripts can write to it safely at the same time.

> **Rule:** File extension MUST be `.dbig`.

### Basic Operations

#### Set (Save)
Writes a value to a specific key.
*   **Syntax:** `dbig set "[Key]" as "[Value]" @"[File]"`
*   **List Support:** To save a list, use `as list {ListVar}`.

```bigc
dbig set "User" as "Ester" @"data.dbig"
```

#### Get (Load)
Retrieves the values for a key. Always returns a List (even for single values).
*   **Syntax:** `dbig get "[Key]" @"[File]" & set as {Result}`

```bigc
dbig get "User" @"data.dbig" & set as {UserList}
```

#### Remove (Delete)
Deletes a key and all its values.
*   **Syntax:** `dbig remove "[Key]" @"[File]"`

---

## 6.2 Advanced DBIG Features

### Checking Existence
Verify if a key exists in the database.
*   **Syntax:** `dbig check "[Key]" @"[File]" & set as {Exists}`

### Checking List Membership
Check if a specific value exists *inside* a key's list.
*   **Syntax:** `dbig check "[Item]" of "[Key]" @"[File]" & set as {Found}`

```bigc
dbig set "Colors" as "Red" @"data.dbig"
dbig check "Red" of "Colors" @"data.dbig" & set as {IsRedThere}
```

### The Scanner (Data Mining)
You can scan the entire database for keys that match a specific numeric condition.
*   **Syntax:** `dbig check keys value [Operator] [Number] @"[File]" & set as list {Matches}`
*   **Operators:** `>`, `<`, `=`

```bigc
# Find all players with score > 100
dbig check keys value > 100 @"scores.dbig" & set as list {HighScorers}
```

---

## 6.3 Universal DBR (SQLite)

For relational data, BigC includes a full SQLite engine. You must unlock it first.

**Unlock:** `use sql`

### Running Commands (Action)
Executes a SQL command that modifies the database (INSERT, UPDATE, DELETE).
*   **Syntax:** `run sql "[Query]" on "[DbFile]"`

```bigc
use sql
run sql "CREATE TABLE IF NOT EXISTS users (id INT, name TEXT)" on "app.db"
run sql "INSERT INTO users VALUES (1, 'Ester')" on "app.db"
```

### Fetching Data (Query)
Executes a `SELECT` query and returns the results.
*   **Syntax:** `get sql "[Query]" on "[DbFile]" & set as list {Results}`
*   **Returns:** A flat list of strings.

```bigc
get sql "SELECT name FROM users WHERE id=1" on "app.db" & set as list {Names}
get from {Names} @1 & set as {UserName}
print "Found User: $UserName"
```

---

### ✅ Verified Example: 06_databases.big
**File Path:** `manual_examples/06_databases.big`
```bigc
# 06_databases.big
# Verification of DBIG and SQL

# --- PART 1: DBIG ---
DB = "test_vault.dbig"
create file "test_vault.dbig" @"."

# 1. Set & Get
dbig set "Player" as "Ester" @"$DB"
dbig get "Player" @"$DB" & set as {Res}
print "DBIG Read: $Res"

# 2. List Support
dbig set "Inventory" as list "[\"Sword\", \"Shield\"]" @"$DB"
dbig check "Sword" of "Inventory" @"$DB" & set as {HasSword}
print "Has Sword: $HasSword"

# 3. Scanner
dbig set "Score_P1" as "50" @"$DB"
dbig set "Score_P2" as "150" @"$DB"
dbig check keys value > 100 @"$DB" & set as list {Winners}
get from {Winners} @1 & set as {Winner}
print "High Scorer: $Winner"

# --- PART 2: SQL ---
use sql
SQL_DB = "test_sql.db"

# 4. Run & Fetch
run sql "CREATE TABLE IF NOT EXISTS logs (msg TEXT)" on "$SQL_DB"
run sql "INSERT INTO logs VALUES ('Hello SQL')" on "$SQL_DB"
get sql "SELECT msg FROM logs" on "$SQL_DB" & set as list {Logs}
get from {Logs} @1 & set as {LogMsg}
print "SQL Read: $LogMsg"

# Cleanup
delete file @"test_vault.dbig"
delete file @"test_vault.dbig.lock"
delete file @"test_sql.db"
```