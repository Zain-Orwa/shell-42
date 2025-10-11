## 🎯 **Purpose of the Exercise**

The goal is simple but tricky:
You must show you **understand how `ls` options work** — not just run commands blindly.

They want a command that:

1. Lists files **and directories** in the current directory.
2. **Excludes hidden files** (those starting with `.`).
3. **Orders them by creation/modification time** (newest first).
4. Adds a **slash `/`** at the end of each directory.
5. Separates everything with **commas**, not new lines.
6. And finally — all of this must fit in **one clean command** inside a file named `midLS`.

This exercise teaches:

* Reading **man pages** (`man ls`)
* Understanding **flags**
* Writing a **minimal command** that does exactly what’s asked — nothing more.

---

## 🧩 **Command Used**

```bash
ls -ptm
```

This is the version seen in your screenshot — and it’s correct for macOS (the 42 machines).
Let’s unpack it:

### 🔹 `ls`

> Lists directory contents — files, folders, etc.

### 🔹 `-p`

> Appends a `/` to directories.
> Example:

```
Documents/  notes.txt
```

### 🔹 `-t`

> Sorts the output **by modification time**, newest first.
> So if you created or edited a file recently, it appears first.

### 🔹 `-m`

> Lists entries **separated by commas** instead of newlines.

---

## 🧱 **How It Works Together**

When you combine them:

```bash
ls -ptm
```

It does all of this in one go:

* Ignores hidden files (default behavior of `ls`).
* Shows both files and directories.
* Sorts them by date (latest first).
* Adds `/` to directories.
* Outputs them as a comma-separated list on one line.

Example output:

```
readme.md, test.c, src/, includes/, main.cpp,
```

---

## 🧠 **Step-by-Step Breakdown**


### 1. Create the `midLS` file

```bash
touch midLS
```

### 2. Edit it (use Vim or Nano)

```bash
vim midLS
```

Then write this content:

```bash
ls -ptm
# ls: lists the content of the directory
# -p: adds a slash (/) at the end of directory names
# -t: sorts by modification date, newest first
# -m: separates entries by commas
```

### 3. Save and make sure it’s correct

```bash
cat midLS
```

### 4. Test the command

Just run:

```bash
bash midLS
```

or

```bash
sh midLS
```

You should get a one-line comma-separated list.

---

## ⚠️ **What You Must NOT Do**

* ❌ Don’t use `grep`, `awk`, `sed`, or `tr`.
* ❌ Don’t add flags that weren’t requested (like `-A` or `-l`).
* ❌ Don’t try to “beautify” the output — it must match the exercise rules exactly.

---

## 🏁 **Conclusion**

**Purpose:** test your command understanding and precision.
**Why:** because every flag changes behavior — they want you to *think before typing*.
**Answer:** `ls -ptm`
**Result:** lists visible files & directories, sorted by time, comma-separated, directories marked with `/`.

---

