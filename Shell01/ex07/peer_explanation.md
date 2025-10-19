
````markdown
# 🧪 Shell00 — ex07 `r_dwssap.sh` — Peer Explanation

> **Goal:** Generate a single formatted line of reversed login names from `/etc/passwd`.

---

## 🎯 Objective

You must:

1. Read from `/etc/passwd`
2. Remove comment lines (`#`)
3. Keep every **even-numbered line** (2, 4, 6, …)
4. Extract only the **login name** (first field before `:`)
5. Reverse each name
6. Sort them in **reverse alphabetical** order
7. Keep only lines between **FT_LINE1** and **FT_LINE2**
8. Join all names with **`, `**
9. End the line with a **`.`**

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
````

✅ **Keep FT_LINE1 and FT_LINE2 commented.**
They’re defined by the tester when running:

```bash
FT_LINE1=7 FT_LINE2=15 ./r_dwssap.sh
```

---

## ⚙ Step-by-Step Breakdown

| Step | Command                             | Purpose                                                              |
| :--: | :---------------------------------- | :------------------------------------------------------------------- |
|   1  | `cat /etc/passwd`                   | Reads the system’s user list.                                        |
|   2  | `sed '/^#/d'`                       | Deletes lines that start with `#` (comments).                        |
|   3  | `awk 'NR % 2 == 0'`                 | Keeps only **even-numbered** lines.                                  |
|   4  | `cut -d: -f1`                       | Extracts the **first field** (username).                             |
|   5  | `rev`                               | Reverses each username (e.g., `alex` → `xela`).                      |
|   6  | `sort -r`                           | Sorts the names in **reverse alphabetical** order.                   |
|   7  | `sed -n "${FT_LINE1},${FT_LINE2}p"` | Prints only lines between **FT_LINE1** and **FT_LINE2** (inclusive). |
|   8  | `tr '\n' ' '`                       | Puts all names on one line separated by spaces.                      |
|   9  | `sed 's+ +, +g'`                    | Replaces each space with `, `.                                       |
|  10  | `sed 's+, $+.+g'`                   | Replaces the final comma with a **period**.                          |
|  11  | `tr -d '\n'`                        | Removes the final newline.                                           |

---

## 🧠 Key Concepts Explained

### 🗂 `/etc` and `/etc/passwd`

| Path          | Description                                                       |
| :------------ | :---------------------------------------------------------------- |
| `/etc`        | Main configuration directory (“editable text configuration”).     |
| `/etc/passwd` | Stores user account info: `login:passwd:uid:gid:info:home:shell`. |

---

### 💻 `hostname` Command vs `/etc/hostname` File

| Path                | Type    | Purpose                                       |
| :------------------ | :------ | :-------------------------------------------- |
| `/usr/bin/hostname` | Command | Displays or sets the hostname temporarily.    |
| `/etc/hostname`     | File    | Stores the permanent hostname (read at boot). |

---

### ⚙️ `FT_LINE1` and `FT_LINE2`

| Variable   | Description                           |
| :--------- | :------------------------------------ |
| `FT_LINE1` | Start line number for range (e.g. 7). |
| `FT_LINE2` | End line number for range (e.g. 15).  |

They are **environment variables**, not system variables.
You define them when testing:

```bash
export FT_LINE1=7 FT_LINE2=15
./r_dwssap.sh
```

✅ In short: **Yes — this selects the range of lines 7–15 (inclusive).**

---

### 🧩 Regex in `sed '/^#/d'`

| Symbol | Meaning                                      |
| :----- | :------------------------------------------- |
| `^`    | Start of line                                |
| `#`    | Literal hash character                       |
| `/^#/` | Pattern that matches lines starting with `#` |
| `d`    | Delete matched lines                         |

💡 Slashes `/.../` act like **quotes** for regex in `sed`.

---

### 🧮 When `sed` Needs `/` or Not

| Usage                | Needs `/`? | Example            |
| :------------------- | :--------: | :----------------- |
| Pattern deletion     |      ✅     | `sed '/error/d'`   |
| Substitution         |      ✅     | `sed 's/old/new/'` |
| Line number deletion |      ❌     | `sed '5,10d'`      |

🟡 You can change delimiters to avoid `/` conflicts:

```bash
sed 's|/usr/bin|/opt/bin|g'
```

---

### 📘 About `awk`

| Symbol | Meaning          |
| :----- | :--------------- |
| `$1`   | First field      |
| `$0`   | Whole line       |
| `NR`   | Line number      |
| `NF`   | Number of fields |

Here → `awk 'NR % 2 == 0'` keeps **even-numbered** lines.
`NR` = “Number of Record” (line count).

---

### 🧩 About the Underscore `_`

* The `_` is **part of the original username** in `/etc/passwd`.
* `rev` just reverses the string; it doesn’t add underscores.

Example:
`adam_smith` → `htims_mada`

---

### 🧱 Why Use Backslashes (`\`)

| Symbol | Meaning                                 |
| :----- | :-------------------------------------- |
| `\`    | Continues the command to the next line. |

✅ It’s for readability. Without it, Bash treats each line as a new command.

---

### 🔄 Command Order — Critical to Correct Output

| Wrong Order         | Problem                                            |
| :------------------ | :------------------------------------------------- |
| `cut` before `awk`  | Breaks even-line logic (awk counts differently).   |
| `rev` before `cut`  | Reverses `:` delimiters; cut can’t split properly. |
| `sort` before `rev` | Sorts unreversed names — wrong order.              |

✅ Always keep the sequence as shown in the official pipeline.

---

### 🧰 `sed` Formatting Commands

| Command           | Effect                                       |
| :---------------- | :------------------------------------------- |
| `sed 's+ +, +g'`  | Replaces spaces with `, ` globally.          |
| `sed 's+, $+.+g'` | Replaces the last comma with a `.` (period). |

💡 The `+` is a **custom delimiter**, identical to `/`.
These two are the same:

```bash
sed 's/ /, /g'
sed 's+ +, +g'
```

---

## ⚡ Common Misunderstandings

| Question                                               | Answer                                            |
| :----------------------------------------------------- | :------------------------------------------------ |
| Does `sed '/^#/d'` remove `#FT_LINE1` from the script? | ❌ No, it only processes `/etc/passwd`.            |
| Do underscores `_` come from `sed`?                    | ❌ No, they’re part of the usernames.              |
| Is `/etc/hostname` a directory?                        | ❌ No, it’s a text file.                           |
| Are `FT_LINE1/2` predefined by system?                 | ❌ No, they’re user-defined environment variables. |
| Why are `FT_LINE1/2` commented?                        | ✅ To let the 42 tester set them automatically.    |
| Does command order matter?                             | ✅ Yes — every stage depends on the previous.      |

---

## 💡 Why This Exercise Matters

You learn:

* **Regex mastery**
* **Pipeline logic (`|`)**
* **System file reading (`/etc/passwd`)**
* **Environment variables**
* **Real-world shell scripting structure**

Used in:

* Log parsing
* DevOps scripts
* Automation pipelines

## 🧪 Verify Your Work

```bash
chmod +x r_dwssap.sh
export FT_LINE1=7 FT_LINE2=15
./r_dwssap.sh
```

Then test output:

```bash
./r_dwssap.sh | grep -E '\.$'   # ✅ Must end with a single dot
```

---

## 🧩 Memory Hook

> **“Remove comments → take even → extract → reverse → sort ↓ → slice FT range → join with commas → end with period.”**

