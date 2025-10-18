````markdown
# 📂 ex03 — `count_files.sh`

### 🎯 Goal  
Count and display **all files and directories** in the current directory and its subdirectories — including the current folder `"."`.

---

## 💻 Final Script  

```bash
#!/bin/bash
find . | wc -l
````

---

## ⚙️ Breakdown

| Command  | Function | Description                                                        |                                         |
| -------- | -------- | ------------------------------------------------------------------ | --------------------------------------- |
| `find .` | Search   | Lists everything (files + dirs) from current directory recursively |                                         |
| `      \| `        | Pipe                                                               | Sends `find` output to the next command |
| `wc -l`  | Count    | Counts how many lines were output (each = one file or directory)   |                                         |

---

### 🧠 Logic Flow

```bash
find .          → prints every path
|               → send to next command
wc -l           → count all lines (paths)
```

✅ Each line = 1 item
✅ Includes current directory `.`
✅ Counts files + folders

---

### 🧪 Example

**Folder structure:**

```
project/
├── file1.txt
├── file2.sh
└── folder/
    └── inner.txt
```

**Run:**

```bash
./count_files.sh
```

**Output:**

```
5
```

Explanation:

1. `.`
2. `file1.txt`
3. `file2.sh`
4. `folder`
5. `folder/inner.txt`

---

### 🧩 Want to count only files or folders?

| Command         | What It Counts |                  |
| --------------- | -------------- | ---------------- |
| `find . -type f | wc -l`         | Files only       |
| `find . -type d | wc -l`         | Directories only |

---

### 💬 Peer Insight

> `find` lists all items one per line.
> `wc -l` simply counts those lines.
> The beauty is in the simplicity — recursion + line counting = total items.

---

✅ **Git Commit Message**

```
ex03: added count_files.sh — count all files and directories recursively
```

---

### 🧭 Quick Recap

| Concept            | Command  | Meaning                      |                             |
| ------------------ | -------- | ---------------------------- | --------------------------- |
| Search recursively | `find .` | start from current directory |                             |
| Combine processes  |    \|    |                             | send output to next command |
| Count results      | `wc -l`  | number of lines (items)      |                             |

---

✨ *A single pipe + two commands = powerful directory summary.*

```

