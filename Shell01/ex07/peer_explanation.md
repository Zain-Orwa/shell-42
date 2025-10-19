
````markdown
# 🧪 Shell00 — ex07 `r_dwssap.sh` — Peer Explanation (Full Version)

> **Goal:** Generate a single formatted line of reversed login names from `/etc/passwd`.

---

## 🎯 Objective

You must:
1. Read from `/etc/passwd`
2. Remove comment lines (starting with `#`)
3. Keep every **even-numbered line** (starting from line 2)
4. Extract only the **login name** (first field before `:`)
5. Reverse each name
6. Sort them in **reverse alphabetical order**
7. Keep only lines between **`FT_LINE1`** and **`FT_LINE2`**
8. Join all names with **`, `** and end with a **`.`**

---

## ✅ Final Script (Submission-Ready)

```bash
#!/bin/sh

# FT_LINE1=7
# FT_LINE2=15

cat /etc/passwd | \
sed '/^#/d' | \
awk 'NR % 2 == 0' | \
cut -d: -f1 | \
rev | \
sort -r | \
sed -n "${FT_LINE1},${FT_LINE2}p" | \
tr '\n' ' ' | \
sed 's+ +, +g' | \
sed 's+, $+.+g' | \
tr -d '\n'
```

✅ **Leave `FT_LINE1` and `FT_LINE2` commented.**  
They’re set by the tester via environment variables:

```bash
FT_LINE1=7 FT_LINE2=15 ./r_dwssap.sh
```

---

## ⚙ Step-by-Step Breakdown

| Step | Command | Purpose |
|------|----------|----------|
| 1 | `cat /etc/passwd` | Reads the system’s user list. |
| 2 | `sed '/^#/d'` | Deletes lines **starting with `#`** (regex `^#`). |
| 3 | `awk 'NR % 2 == 0'` | Keeps only **even-numbered** lines. |
| 4 | `cut -d: -f1` | Extracts the **first field** (username). |
| 5 | `rev` | Reverses each username (e.g. `alex → xela`). |
| 6 | `sort -r` | Sorts in **reverse alphabetical** order. |
| 7 | `sed -n "${FT_LINE1},${FT_LINE2}p"` | Prints only the range of lines defined by the environment vars. |
| 8 | `tr '\n' ' '` | Puts all names on **one line** separated by spaces. |
| 9 | `sed 's+ +, +g'` | Replaces every space with `, `. |
|10 | `sed 's+, $+.+g'` | Replaces the last comma with a **period**. |
|11 | `tr -d '\n'` | Removes the trailing newline for a clean one-liner output. |

---

## 🧠 Key Concepts Explained

### 1. `/etc` and `/etc/passwd`
- `/etc` = system configuration directory (“editable text configuration”).
- `/etc/passwd` = list of user accounts (`login:passwd:uid:gid:info:home:shell`).

### 2. `hostname`
- Command (`/usr/bin/hostname`) → shows/sets the computer name.
- File (`/etc/hostname`) → stores the **permanent hostname** read at boot.
- They share the same name but serve different roles: command = tool, file = config.

### 3. `FT_LINE1` & `FT_LINE2`
- Not predefined anywhere.
- Are **environment variables** defined by you or the tester.
- Commented out in the script so Moulinette can inject its own values.

```bash
export FT_LINE1=7 FT_LINE2=15
./r_dwssap.sh
```

---

## 🔍 Regex Deep Dive

- **Regex = Regular Expression**, pattern language for text.
- In `sed '/^#/d'`:
  - `^` → start of line  
  - `#` → literal hash  
  - `/^#/` → pattern between slashes
- **Meaning:** delete lines that start with `#`.

✅ Slashes `/.../` are delimiters for regex patterns.  
They act like quotes telling `sed`: *“apply command X to everything matching this pattern.”*

---

## 🧩 When `sed` Needs `/` and When Not

| Case | Slash needed? | Example |
|------|----------------|---------|
| Pattern match | ✅ | `sed '/error/d'` |
| Substitution | ✅ | `sed 's/old/new/'` |
| Line numbers only | ❌ | `sed '5,10d'` |

💡 You can change the delimiter (e.g. `+` or `|`) if `/` appears in your text:
```bash
sed 's|/usr/bin|/opt/bin|g'
```

---

## 🪶 About `awk`
- Reads line by line and splits each line into fields (`$1`, `$2`, …).
- `$1` = first field, `$0` = whole line, `NR` = current line number.
- Used here: `awk 'NR % 2 == 0'` → keeps **even lines** only.

---

## 🔤 About Underscores in Output

You may see reversed names like:
```
sorebrek_brk_
```
That underscore `_` comes from the original username in `/etc/passwd` —  
not from your script.  
Example:  
`adam_smith` → reversed = `htims_mada`.  
`_` is treated as part of the string, not as a separator.

---

## 🔁 Why Backslashes (`\`) End Lines

The `\` means “continue this command on the next line.”  
Without it, Bash would treat the next line as a new, separate command.  
It’s purely for readability when chaining long pipelines.

---

## 🔄 Command Order — Why It Matters

Every command depends on the previous output.  
Change the order → change (or break) the logic.

Example failures:
- Running `cut` before `awk` → even-line logic applied on usernames only.
- Running `rev` before `cut` → reverses `:` separators → breaks fields.
- Sorting before `rev` → wrong lexicographic order.

So always follow the pipeline order exactly.

---

## 💡 `sed` Formatting Commands Explained

### `sed 's+ +, +g'`
- `s` = substitute
- `+ +` = pattern (space)
- `, +` = replacement
- `g` = apply globally  
→ Replaces every space with `, `.

### `sed 's+, $+.+g'`
- Finds a comma + space at **end of line** (`$, ` = regex for end)
- Replaces it with a `.`  
→ Makes the final output end cleanly with a period.

💡 The `+` here is just a **custom delimiter** instead of `/`.  
`sed 's/ /, /g'` and `sed 's+ +, +g'` are identical.

---

## 🧱 Common Misunderstandings Cleared

| Question | Answer |
|-----------|---------|
| Does `sed '/^#/d'` remove the `#FT_LINE1` lines in my script? | ❌ No. It only affects `/etc/passwd`, not the script itself. |
| Do underscores `_` come from `sed`? | ❌ No, they’re part of usernames. |
| Is `/etc/hostname` a directory? | ❌ No, it’s a **file**. The command `hostname` lives in `/usr/bin/hostname`. |
| Are `FT_LINE1/2` predefined? | ❌ No, you define them during tests. |
| Does order of commands matter? | ✅ Absolutely — each depends on the previous. |
| Why keep `FT_LINE1/2` commented? | ✅ Moulinette defines them automatically; don’t override. |

---

## 🧠 Real-World Usefulness

This exercise teaches:
- Piping and data flow between commands
- Regex and field processing
- Text transformation using pure shell tools
- System file structure (/etc, users, hostname)
- Professional Bash formatting habits

These same tools are used in:
- Log parsing
- User management scripts
- Automation pipelines
- DevOps tasks

---

## 🧪 Quick Tests

```bash
chmod +x r_dwssap.sh
export FT_LINE1=7 FT_LINE2=15
./r_dwssap.sh
```

Validation:
```bash
# Should produce ~9 names separated by ", " and ending with "."
./r_dwssap.sh | grep -E '\.$'
```

---

## 🧩 Memory Hook

> **“Remove comments → take even lines → extract → reverse → sort ↓ → slice → join with commas → end with period.”**

---
````

