# Chapter 4: Data Structures

BigC organizes information into three primary structures: **Backpacks** (Lists), **Maps** (Dictionaries), and **Blueprints** (Objects). Internally, these are all lightweight wrappers around JSON, ensuring they are portable and easy to save.

---

## 4.1 Backpacks (Lists)

A **Backpack** stands for a **Bundle of All Collected Knowledge**. It is an ordered collection of items.

### Creating a Backpack
You can create a backpack by splitting a string or initializing an empty array.
```bigc
# Method 1: Splitting
split "Red,Green,Blue" by "," & set as list {Colors}

# Method 2: Empty
Inventory = "[]"
```

### Accessing Items (`@` Index)
BigC uses **1-based indexing** (Human Style).
*   **Syntax:** `get from {List} @[Index] & set as {Var}`
*   **Safety:** Requesting an index that doesn't exist returns the word `"nothing"`.

```bigc
get from {Colors} @1 & set as {First}  # "Red"
get from {Colors} @9 & set as {Oops}   # "nothing"
```

### Counting Items
To get the number of items in a backpack:
*   `get Colors as count & set as {Size}`

---

## 4.2 Maps (Dictionaries)

Maps store data in **Key-Value** pairs. Internally, they are JSON objects (`{}`).

### Map Commands
*   **Set:** `map set "Key" as "Value" @{MapName}`
*   **Get:** `map get "Key" of {MapName} & set as {Var}`
*   **Check:** `map check "Key" of {MapName} & set as {Exists}` (Returns "true"/"false")
*   **Remove:** `map remove "Key" @{MapName}`
*   **Merge:** `map merge {Source} @{Target}` (Copies all keys from Source to Target)

---

## 4.3 Blueprints (Objects)

Blueprints are templates. They allow you to define a "Model" once and create many copies (Instances) of it. This is the professional way to handle complex state like Players or NPCs.

### 1. Defining a Blueprint
Use the `[Blueprint: Name]` block. Properties are listed with a `+` symbol.

```text
[Blueprint: Hero]
+ hp : 100
+ gold : 50
+ status : "alive"
```

### 2. Creating an Instance (`pin`)
The `pin` command creates a "live" variable from a Blueprint template. Blueprint names are case-insensitive.

**Syntax:** `pin [BlueprintName] to "[VariableName]"`

```bigc
pin Hero to "player"
pin Hero to "enemy"
```

### 3. Dot Notation (`.`)
You can read and write to an object's properties directly using a dot.

```bigc
# Read
print "Hero HP: $player.hp"

# Write
player.hp = 150
player.gold = player.gold + 10
```

---

## 4.4 Mutation Reference

| Command | Action | Example |
| :--- | :--- | :--- |
| `list add` | Append to end. | `list add "Gold" @{Backpack}` |
| `list remove` | Remove all matches. | `list remove "Apple" @{Backpack}` |
| `list cut` | Remove at index. | `list cut @1 @{Backpack}` |
| `list sort` | Alphabetize. | `list sort @{Backpack}` |
| `list insert` | Put at position. | `list insert "Gem" at @2 @{Backpack}` |

---

## 4.5 Packing & Unpacking (JSON)

To save a Map/Object to a file, you must "Pack" it into a string. To load it back, you "Unpack" it.

*   **Pack:** `pack {User} as json & set as {RawText}`
*   **Unpack:** `unpack $RawText as map & set as {User}`

---

### ✅ Verified Example: 04_data_structures.big
**File Path:** `manual_examples/04_data_structures.big`
```bigc
# 04_data_structures.big
# Verification of Lists, Maps, and Blueprints

# 1. Lists (Backpacks)
split "Sword,Shield,Potion" by "," & set as list {Backpack}
list add "Map" @{Backpack}
list sort @{Backpack}
get from {Backpack} @1 & set as {FirstItem}
print "First Item: $FirstItem"

# 2. Maps
User = "{}"
map set "name" as "Ester" @{User}
map set "role" as "Admin" @{User}
map get "name" of {User} & set as {Name}
print "User Name: $Name"

# 3. Blueprints
[Blueprint: Npc]
+ hp : 50
+ name : "Guard"

pin Npc to "guard1"
guard1.hp = 75
print "Guard HP: $guard1.hp"

# 4. Serialization
pack {guard1} as json & set as {JsonData}
print "Serialized: $JsonData"

unpack $JsonData as map & set as {Clone}
print "Unpacked Name: $Clone.name"
```
