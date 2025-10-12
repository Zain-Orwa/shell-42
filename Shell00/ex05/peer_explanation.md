````markdown
# 🧩 Exercise 05 — GiT commit

### 🎯 Target  
Create a shell script named `git_commit.sh` that displays the **IDs (hashes)** of the last **5 commits** in the current Git repository.

---

## 🧠 Understanding the Purpose

This exercise tests your ability to:
- Use **Git commands** from a shell script.  
- Extract only specific commit information (not full logs).  
- Limit and format output properly.

You’re expected to **read the manual** (`man git-log`) and understand what each flag does — *not just copy the command*.

---

## 🔍 What the Script Should Do

When you run:
```bash
bash git_commit.sh
````

It should print something like this:

```
e94d0b48c03ec633f16d84d6b3beaef9ae7e7be8
5ddc8474ff15b3fcb720d8cb333e19c3a2707888
905f5ad98566771334f535b9b94cf29774701f1f
2f58274b13887a80eea844969e8dc4583b531ac1
baa23b54f0adb7bf42623d6d0a6ed4587e11412a
```

Each line is one commit ID (SHA-1 hash) — newest first.

---

## ⚙️ Step-by-Step Solution

### 1️⃣ Create your file

```bash
mkdir -p ex05
cd ex05
touch git_commit.sh
```

### 2️⃣ Add this command

```bash
git log --format='%H' -n5
# git log: Shows the history of commits.
# --format='%H': Displays only the full hash of each commit.
# -n5: Limits the output to the last 5 commits.
```

### 3️⃣ Make it executable

```bash
chmod +x git_commit.sh
```

### 4️⃣ Test it

Inside any Git repository:

```bash
bash git_commit.sh
```

---

## 🧩 Command Breakdown

| Command         | Explanation                                             |
| --------------- | ------------------------------------------------------- |
| `git log`       | Displays the commit history (newest first).             |
| `--format='%H'` | Formats output to show only the commit’s **full hash**. |
| `-n5`           | Limits the output to the **last 5 commits**.            |

So the combined command:

```bash
git log --format='%H' -n5
```

means:

> “Show me the **last 5** commits, printing only their **full IDs**, one per line.”

---

## 🧾 Example Output

```
905f5ad98566771334f535b9b94cf29774701f1f
5ddc8474ff15b3fcb720d8cb333e19c3a2707888
e94d0b48c03ec633f16d84d6b3beaef9ae7e7be8
```

---

## ⚠️ Important Rules

* Don’t add extra `echo` or `cat` commands.
* Don’t include `#!/bin/bash` (not required by subject).
* The output **must exactly** match what’s shown — plain hashes, no text or spaces.
* The script must work when run directly in a valid Git repository.

---

## ✅ Final File: `git_commit.sh`

```bash
git log --format='%H' -n5
# git log: Shows the history of commits.
# --format='%H': Displays only the hash of each commit.
# -n5: Limits the output to the last 5 commits.
```

---

## 🏁 Summary

| Goal                       | Command                     | Output                         |
| -------------------------- | --------------------------- | ------------------------------ |
| Show the last 5 commit IDs | `git log --format='%H' -n5` | 5 lines of SHA-1 commit hashes |

---

✨ **RTFM Tip:**
Check `man git-log` — every flag you use in this exercise is documented there.

```

