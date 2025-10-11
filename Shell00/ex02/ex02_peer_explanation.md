# 💠 Shell00 — Exercise 02 : `exo2.tar`

> **Title:** *Oh yeah, moooore…*  
> **Goal:** Create the exact file and directory structure shown in the subject — with matching permissions, timestamps, sizes, and links — then compress it into `exo2.tar`.

---

## 🎯 Objective

This exercise expands your control over the shell.  
You’ll manipulate **permissions, timestamps, file sizes, directories, and links** — every attribute that `ls -l` shows.

It’s about precision. One wrong bit, and your archive won’t pass.

---

## 🧠 What You’ll Learn

- How to create directories and files with exact attributes  
- The difference between **hard** and **symbolic** links  
- How to set **permissions** using numeric mode  
- How to control **timestamps** using `touch -t`  
- How to package everything correctly with `tar`  

---

## 🔧 Commands You’ll Use (and Why)

### 🗂️ `mkdir`
Creates directories.
```bash
mkdir test0 test2
````

---

### 🕒 `touch`

Creates files and sets timestamps.
The format for `-t` is:

```
[[CC]YY]MMDDhhmm[.ss]
```

Example:

```bash
touch -t 202006012047 test0
```

→ Sets modification time to **June 1, 23:47, 2020**.
If your date is old, `ls` may show the **year** instead of the time — that’s **fine**.

---

### 📏 `truncate`

Sets file size in **bytes** — no editing needed.

```bash
truncate -s 4 test1
truncate -s 1 test3
truncate -s 2 test4
```

---

### 🔐 `chmod`

Changes permissions numerically (`r=4`, `w=2`, `x=1`).

🎥 [Watch file permission explanation](https://www.youtube.com/channel/UCYjjQTGH4AIYQZg1qWb5r1g)
📘 [Read detailed permission guide](https://www.infowester.com/linuxpermissoes.php)

Examples:

```bash
chmod 751 test0   # drwx--xr-x
chmod 644 test1   # -rw-r--r--
chmod 555 test2   # dr-xr-xr-x  (or 444 if checker expects read-only dir)
chmod 444 test3   # -r--r--r--
chmod 444 test4   # -r--r--r--
```

> ⚠️ Note: `test5` is a **hard link** to `test3`, so it automatically inherits the same permissions.

---

### 🔗 `ln`

Used to create **links**.

**Hard link** (shares the same inode and size):

```bash
ln test3 test5
```

**Symbolic link** (points to another path):

```bash
ln -s test0 test6
```

The symbolic link `test6` will show:

```
test6 -> test0
```

---

### 📦 `tar`

Archives files for submission.

```bash
tar -cf exo2.tar *
```

Verify archive contents:

```bash
tar -tvf exo2.tar
```

---

## 🪜 Step-by-Step Solution (inside `ex02/`)

Follow these in order **exactly**:

```bash
# 1. Create directories
mkdir test0 test2

# 2. Create empty files
touch test1 test3 test4

# 3. Adjust sizes
truncate -s 4 test1
truncate -s 1 test3
truncate -s 2 test4

# 4. Create links
ln test3 test5       # hard link
ln -s test0 test6    # symbolic link

# 5. Set permissions
chmod 715 test0      
chmod 714 test1     
chmod 504 test2
chmod 404 test3 
chmod 641 test4
# test5 inherits from test3

# 6. Set timestamps
touch -t 202006012047 test0
touch -t 202006012146 test1
touch -t 202006012245 test2
touch -t 202006012344 test3
touch -t 202006012343 test4
touch -t 202006012344 test5
touch -t 202006012220 test6

# 7. Verify
ls -l
stat -c '%A %h %U %G %s %y %n' *

# 8. Create the archive
tar -cf exo2.tar *
```
---

## 📋 Expected `ls -l` Output

It should look like this (except user/group names):

```
drwx--xr-x 2 XX XX XX Jun 1 20:47 test0
-rwx--xr-- 1 XX XX 4 Jun 1 21:46 test1
dr-x---r-- 2 XX XX XX Jun 1 22:45 test2
-r-----r-- 2 XX XX 1 Jun 1 23:44 test3
-rw-r----x 1 XX XX 2 Jun 1 23:43 test4
-r-----r-- 2 XX XX 1 Jun 1 23:44 test5
lrwxr-xr-x 1 XX XX 5 Jun 1 22:20 test6 -> test0

✔️ All link counts, sizes, and times must match
✔️ The year display instead of time is accepted

---

## ✅ Verification Checklist

| Requirement  | File  | Command to Check     | Expected           |
| ------------ | ----- | -------------------- | ------------------ |
| Directory    | test0 | `ls -ld test0`       | drwx--xr-x         |
| Regular file | test1 | `ls -l test1`        | -rwx--xr-- size 4  |
| Directory    | test2 | `ls -ld test2`       | dr-x---r--         |
| Regular file | test3 | `ls -l test3`        | -r-----r-- size 1  |
| Regular file | test4 | `ls -l test4`        | -rw-r----x size 2  |
| Hard link    | test5 | `ls -li test3 test5` | Same inode number  |
| Symlink      | test6 | `ls -l test6`        | lrwxr-xr-x → test0 |

---

## ⚠️ Common Mistakes

🚫 Editing files after setting timestamps
🚫 Using `cp` instead of `ln` for test5
🚫 Wrong permissions (double-check octal!)
🚫 Forgetting to archive from inside `ex02`
🚫 Adding `printf` or `echo` that modifies timestamps

---

## 📦 Final Turn-in Command

From inside `ex02/`:

```bash
tar -cf exo2.tar *
```


########################################################################.
