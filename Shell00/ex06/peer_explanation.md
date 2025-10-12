````markdown
# 🧩 Exercise 06 — gitignore

### 🎯 Target  
Create a shell script named `git_ignore.sh` that lists all **existing files ignored** by your Git repository.

---

## 🧠 Understanding the Purpose

In Git projects, not every file should be tracked.  
Some are **temporary**, **system-generated**, or **personal configuration files** that do not belong in version control.

This exercise teaches you how to:
- Understand which files Git ignores.
- Read `.gitignore` rules correctly.
- Use Git commands to inspect ignored files inside your project.

---

## ⚙️ Step-by-Step Solution

### 1️⃣ Create the folder and file
```bash
mkdir -p ex06
cd ex06
touch git_ignore.sh
````

### 2️⃣ Add this command

```bash
git ls-files --others --ignored --exclude-standard
# git ls-files: Lists files handled by Git.
# --others: Shows files not tracked in the Git index.
# --ignored: Includes files ignored by Git rules.
# --exclude-standard: Applies standard ignore patterns (.gitignore, global ignore, etc).
```

### 3️⃣ Make it executable

```bash
chmod +x git_ignore.sh
```

### 4️⃣ Test it

Inside any Git repository that has a `.gitignore` file, run:

```bash
bash git_ignore.sh
```

Expected output:

```
.DS_Store
mywork.c~
```

If you pipe through `cat -e` to show line endings:

```
.DS_Store$
mywork.c~$
```

---

## 🧩 Command Breakdown

| Flag                 | Description                                                                                  |
| -------------------- | -------------------------------------------------------------------------------------------- |
| `git ls-files`       | Lists all files tracked or known by Git.                                                     |
| `--others`           | Lists files that are **not tracked** in Git.                                                 |
| `--ignored`          | Includes files that are **ignored** based on `.gitignore`.                                   |
| `--exclude-standard` | Makes Git respect **default ignore rules** (.gitignore, `.git/info/exclude`, global ignore). |

Together, these flags tell Git:

> “List only the files that exist in my folder but are ignored by my repository.”

Good — that’s the part **most people skip over**, but it’s actually *important*.
Let’s break down `--exclude-standard` in simple, practical terms.

---

## 🧩 The flag: `--exclude-standard`

When you run:

```bash
git ls-files --others --ignored --exclude-standard
```

Git lists files that are **not tracked** and **ignored** —
but `--exclude-standard` tells Git *where to look for the ignore rules*.

---

## ⚙️ Without `--exclude-standard`

If you remove that flag:

```bash
git ls-files --others --ignored
```

Git would *not automatically know* which ignore rules to apply.
You’d only see ignored files if you gave Git a manual list (e.g., with `--exclude` options).

So basically, without it, you might see *too many files* — including ones that should’ve been ignored.

---

## ✅ Why we use `--exclude-standard` even though we already included --ignnored?

When you include this flag, Git automatically uses the **three standard ignore locations** that every repository has by default:

| Location                | Description                                                                      |
| ----------------------- | -------------------------------------------------------------------------------- |
| **`.gitignore`**        | The main ignore file in your repository root.                                    |
| **`.git/info/exclude`** | Local ignore file (specific to your machine, not shared).                        |
| **Global gitignore**    | A system-wide ignore file set in your Git config (e.g., `~/.config/git/ignore`). |

---

### 🧠 In plain English:

`--exclude-standard` means:

> “Use all the normal ignore rules that Git normally applies everywhere — including .gitignore and system-wide ignores.”

---

### 🔍 Example:

Let’s say your project looks like this:

```
project/
├── main.c
├── notes.txt
├── .gitignore
```

And inside `.gitignore` you have:

```
notes.txt
```

Now if you run:

```bash
git ls-files --others --ignored
```

You might get *nothing* — because Git doesn’t automatically apply `.gitignore`.

But if you run:

```bash
git ls-files --others --ignored --exclude-standard
```

You’ll see:

```
notes.txt
```

✅ Git now uses `.gitignore` and correctly lists `notes.txt` as ignored.

---

## 💡 Summary Table

| Flag                 | Purpose                                                                                |
| -------------------- | -------------------------------------------------------------------------------------- |
| `--others`           | Show untracked files (not in Git).                                                     |
| `--ignored`          | Include ignored files.                                                                 |
| `--exclude-standard` | Apply standard ignore rules from `.gitignore`, `.git/info/exclude`, and global config. |

---

### 🔧 Without `--exclude-standard`

→ Git shows everything, ignoring nothing.

### ✅ With `--exclude-standard`

→ Git filters output based on your `.gitignore` and global ignore rules.

---

So, in short:

> `--exclude-standard` makes sure Git actually respects your `.gitignore` rules when showing which files are ignored.

---
## ✅ Final Script (ready to submit)

```bash
git ls-files --others --ignored --exclude-standard
# git ls-files: Lists files handled by Git.
# --others: Shows files not tracked in the Git index.
# --ignored: Includes files ignored by Git rules.
# --exclude-standard: Applies standard ignore patterns (.gitignore, global ignore, etc).
```

---

## 🧾 Example Output

```
$ bash git_ignore.sh
.DS_Store
mywork.c~
```

---

## 💡 What Does This Output Mean?

### 🔸 `.DS_Store`

* A **macOS system file** automatically created inside folders.
* Stores Finder view settings (like icon positions, sorting, etc.).
* Useless for source code and should never be committed.

Typical `.gitignore` rule:

```
.DS_Store
```

---

### 🔸 `mywork.c~`

* A **backup file** automatically created by editors (like Vim or Nano).
* The tilde (`~`) means it’s a temporary safety copy of your file.
* It’s not your actual code, just an editor-generated backup.

Typical `.gitignore` rule:

```
*~
```

---

## 🧰 Why This Is Useful

This script helps you:

* Verify that your `.gitignore` rules are working correctly.
* See which **ignored files physically exist** in your project.
* Keep your repo clean by identifying junk or temporary files before committing.

Example use case:

```bash
$ bash git_ignore.sh
.DS_Store
temp.log
```

✅ means both `.DS_Store` and `temp.log` are being ignored — as they should.

---

## 🧠 Real Developer Insight

| File        | Source | Description                     | Should Be Tracked? |
| ----------- | ------ | ------------------------------- | ------------------ |
| `.DS_Store` | macOS  | Stores Finder view preferences  | ❌ No               |
| `mywork.c~` | Editor | Backup file from save operation | ❌ No               |

Keeping such files ignored prevents unnecessary clutter and ensures your Git history only contains meaningful source files.

---

## ✨ RTFM Reminder

You can always check the official Git documentation:

```bash
git help ls-files
```

or

```bash
man git-ls-files
```

---

