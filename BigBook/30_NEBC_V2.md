# Chapter 30: NEBC V2 (The Shadow Cipher)

NEBC (**Native Encryption of BigC**) is the standard, lightweight encryption module built into the core engine. In V.1.0 Mandate, NEBC has been upgraded to a robust **Stream Cipher** that supports all characters and provides reversible security.

---

## 1. Features of NEBC V2

*   **Universal Support:** Encrypts and Decrypts strings containing numbers, symbols, spaces, and even newlines.
*   **Reversible:** Unlike a Hash (like MD5), NEBC can be fully reversed to get the original text back—provided you have the correct key.
*   **Hex Encoding:** Encrypted data is returned as a clean Hexadecimal string, making it easy to save in `.dbig` or `.db` databases.

---

## 2. Using NEBC

### Encrypting (`bit code`)
*   **Syntax:** `bit code "[Text]" with "[Key]" nebc & set as {Result}`

```bigc
# Encrypt a secret
bit code "MyPassword123!" with "MySecretKey" nebc & set as {Secret}
# Result will be a long string of letters and numbers (Hex)
```

### Decrypting (`bit decode`)
*   **Syntax:** `bit decode "$Variable" with "[Key]" nebc & set as {Result}`

```bigc
# Decrypt the secret
bit decode "$Secret" with "MySecretKey" nebc & set as {Original}
print "Found: $Original"
```

---

## 3. Important Rules

1.  **The Key is King:** If you lose the key used to encrypt the data, it is **impossible** to recover the original text.
2.  **Case Sensitivity:** Keys are case-sensitive. "Key1" is different from "key1".
3.  **Variable Usage:** When decrypting, always ensure your variable is interpolated (e.g., `"$Secret"`) so the engine passes the hex code correctly.

---

## 4. Master Example: Secure Save System

```bigc
# Securely saving a user score
UserScore = "9999"
AppKey = "BigC_V1_Verified"

# 1. Encrypt
bit code UserScore with AppKey nebc & set as {EncryptedScore}

# 2. Save to Vault
dbig set "High" as "$EncryptedScore" @"save.dbig"

# 3. Load and Decrypt
dbig get "High" @"save.dbig" & set as {LoadedHex}
bit decode "$LoadedScore" with AppKey nebc & set as {FinalScore}

print "Restored Score: $FinalScore"
```
