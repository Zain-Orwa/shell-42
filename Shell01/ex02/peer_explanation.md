````markdown
# 🔍 ex02 — `find_sh.sh`

### 🎯 Objective  
Find every file ending with `.sh` in the current directory and subdirectories,  
then display their names **without** the `.sh` extension.

---

## 💻 Final Script  

```bash
#!/bin/bash
find . -type f -name "*.sh" -execdir basename -s '.sh' {} +
````

---

## 🧩 Step-by-Step Explanation

### 1️⃣ `find .`

Search recursively starting from the **current directory (`.`)**.
It explores all subdirectories automatically.

🧠 Example:

```bash
find .
```

→ Lists every file and directory under the current path.

---

### 2️⃣ `-type f`

Restricts the results to **files only** (not folders, devices, or symlinks).

🧠 Example:

```bash
find . -type f
```

→ Lists only actual files.

---

### 3️⃣ `-name "*.sh"`

Search for files that end with `.sh`.
The `*` wildcard matches anything before `.sh`.

🧠 Example:

```bash
find . -type f -name "*.sh"
```

→ Output:

```
./script.sh
./folder/test.sh
./demo.sh
```

---

### 4️⃣ `-execdir`

Runs a command **inside the directory where each file is found**
instead of the directory where `find` was launched.

| Option     | Command Location                           |
| ---------- | ------------------------------------------ |
| `-exec`    | Runs from the directory you started `find` |
| `-execdir` | Runs from the file’s actual directory      |

🧩 Example:

```bash
find . -type f -name "*.sh" -exec echo {} \;
```

Output:

```
./scripts/run.sh
./scripts/utils/clean.sh
```

Now try:

```bash
find . -type f -name "*.sh" -execdir echo {} \;
```

Output:

```
run.sh
clean.sh
```

Cleaner — no full paths!

---

### ⚙️ How It Actually Works

Let’s decode this:

```bash
find . -type f -name "*.sh" -execdir basename -s '.sh' {} +
```

* **`find`** = manages the search
* **`basename -s '.sh' {}`** = the *command* run on each file
* **`-execdir`** = tells `find` to “run this command from the file’s folder”
* **`{}`** = replaced by each file’s name
* **`+`** = run the command on multiple files at once (efficient)

🧠 `find` doesn’t move around — it just *tells* each command where to execute.

---

### 💡 Why `-execdir` is better

✅ Cleaner output → only the filename
✅ Safer → each action happens inside the correct folder
✅ Portable → behaves consistently even in nested paths

🧱 Example directory:

```
project/
├── find_sh.sh
├── scripts/
│   ├── run.sh
│   ├── stop.sh
│   └── utils/
│       └── clean.sh
```

Run the script:

```bash
./find_sh.sh
```

Output:

```
find_sh
run
stop
clean
```

---

### 5️⃣ `basename -s '.sh' {}`

Removes the `.sh` extension and shows only the file name.

🧠 Example:

```bash
basename -s '.sh' hello.sh
```

→ `hello`

---

### 6️⃣ `+`

Processes multiple files together (faster).
If you use `\;`, it runs once per file (slower).

---

## ⚙️ Comparison: `-exec` vs `-execdir`

| Behavior   | Example                                                       | Output             |
| ---------- | ------------------------------------------------------------- | ------------------ |
| `-exec`    | `find . -type f -name "*.sh" -exec basename -s '.sh' {} \;`   | `./folder/file.sh` |
| `-execdir` | `find . -type f -name "*.sh" -execdir basename -s '.sh' {} +` | `file`             |

✅ The exercise expects clean names only → use **`-execdir`**.

---

## 🧪 Quick Test

### Create test files:

```bash
mkdir test && cd test
touch one.sh two.sh notes.txt
mkdir inner && touch inner/run.sh inner/edit.sh
```

### Run your script:

```bash
../find_sh.sh
```

✅ Output:

```
one
two
run
edit
```

---

## 🧱 Folder Structure

```
Shell01/
└── ex02/
    ├── find_sh.sh
    └── ex02_peer_explanation.md
```

Give it execute permission:

```bash
chmod +x find_sh.sh
```

---

## 🧭 Summary

| Step | Command                | Purpose                                  |
| ---- | ---------------------- | ---------------------------------------- |
| 1️⃣  | `find .`               | Search recursively                       |
| 2️⃣  | `-type f`              | Limit to files                           |
| 3️⃣  | `-name "*.sh"`         | Match `.sh` files                        |
| 4️⃣  | `-execdir`             | Run command inside each file’s directory |
| 5️⃣  | `basename -s '.sh' {}` | Remove `.sh` extension                   |
| 6️⃣  | `+`                    | Execute efficiently                      |

---

### 📘 Common Mistakes

| Mistake                             | Effect                                        |
| ----------------------------------- | --------------------------------------------- |
| Forgetting quotes around `*.sh`     | Shell expands it before `find` runs           |
| Using `-exec` instead of `-execdir` | Shows long file paths                         |
| Missing `+`                         | Slower execution (runs command for each file) |
| Forgetting shebang `#!/bin/bash`    | Script won’t execute directly                 |

---

### 💬 Peer Tip

> `find` is the manager — it discovers all files.
> The part after `-execdir` (like `basename`) is the worker — it acts on each file.
> The difference is **where** that worker runs:
> `-execdir` makes it work *inside* each file’s folder, which keeps your output clean and safe.

---


✨ *Now you understand not just how to solve it — but how `find` truly works under the hood.*

```
