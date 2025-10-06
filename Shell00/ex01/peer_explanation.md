Ahh, I see what’s happening 👀 — great question, and it’s not your fault.
GitHub’s Markdown viewer **doesn’t render all HTML or CSS styles** — especially things like:

* `align="center"` (GitHub strips this out)
* `<h1> ... </h1>` when mixed with Markdown formatting
* custom font sizes, colors, and layout formatting

So, even though it looks perfect here, **GitHub sanitizes** the HTML to prevent layout-breaking code.
That’s why it shows as plain text instead of that nice “dark structured layout” like your screenshot.

But don’t worry — I can fix that for you **so it looks exactly like the dark GitHub style you liked**, using *pure Markdown* (no stripped HTML).
The trick is to use GitHub’s **native syntax** for headings, code blocks, and emojis, while keeping the alignment and hierarchy clear.

Here’s the same README rewritten for **100% correct rendering inside GitHub**, and it’ll look just like your working `ex00` one 👇

---

````markdown
# 💠 Shell00 — Exercise 01 : `testShell00.tar`

> **Target:** Make a file named `testShell00` whose **permissions, size, and timestamp** match the example in the subject, and then archive it as `testShell00.tar`.

---

## 🎯 Objective

You’ll practice three core UNIX skills:

1. **Create files** and set their **size** without editing.
2. Precisely control a file’s **permissions**.
3. Modify a file’s **timestamp** and **archive** it with `tar`.

---

## 🧠 What You’ll Learn

- How to create and modify files directly from the shell  
- How to use `chmod`, `truncate`, and `touch` properly  
- How to verify attributes with `ls -l`  
- How to package files for submission with `tar`

---

## 🧰 Command Toolbox (with flags & purpose)

### `touch`
📌 **Purpose:** Create an empty file or update its timestamp.

```bash
touch testShell00
````

⏱️ **Timestamp flag:**

```bash
touch -t [[CC]YY]MMDDhhmm[.ss] testShell00
```

Example:

```bash
touch -t 202006012342 testShell00
```

This sets the modification time to **Jun 1, 23:42 (2020)**.

> If it’s an older date, GitHub’s shell may show the **year** instead of the time — this is OK per the exercise instructions.

---

### `truncate`

📌 **Purpose:** Set the file size in bytes without editing it.

```bash
truncate -s 40 testShell00
```

`-s 40` → file size will be exactly **40 bytes**.

---

### `chmod`

📌 **Purpose:** Change file permissions (who can read, write, or execute).

Before diving deeper —
🎥 [Watch my video about file permissions and how they work](https://www.youtube.com/channel/UCYjjQTGH4AIYQZg1qWb5r1g)
📘 [Prefer reading? Here’s a detailed guide](https://www.infowester.com/linuxpermissoes.php)

Now the command:

```bash
chmod 455 testShell00
```

**Breakdown of 455:**

| Role   | Octal | Meaning        | Result |
| ------ | ----- | -------------- | ------ |
| Owner  | 4     | read only      | `r--`  |
| Group  | 5     | read + execute | `r-x`  |
| Others | 5     | read + execute | `r-x`  |

Final permission:

```
-r--r-xr-x
```

---

### `ls`, `cat`, and `stat` (for verification)

Check details:

```bash
ls -l testShell00
```

Expected output:

```
-r--r-xr-x 1 <user> <group> 40 Jun  1 23:42 testShell00
```

Inspect attributes in detail:

```bash
stat -c '%A %h %U %G %s %y %n' testShell00
```

---

### `tar`

📦 **Purpose:** Create the `.tar` archive to submit.

Create:

```bash
tar -cf testShell00.tar testShell00
```

List contents:

```bash
tar -tvf testShell00.tar
```

Extract (optional for testing):

```bash
tar -xvf testShell00.tar
```

---

## 🪜 Step-by-Step Solution (inside `ex01/`)

1️⃣ Create the file

```bash
touch testShell00
```

2️⃣ Set the file size

```bash
truncate -s 40 testShell00
```

3️⃣ Set the permissions

```bash
chmod 455 testShell00
```

4️⃣ Set the modification time

```bash
touch -t 202006012342 testShell00
```

5️⃣ Verify

```bash
ls -l testShell00
```

6️⃣ Create the archive

```bash
tar -cf testShell00.tar testShell00
```

7️⃣ (Optional) Verify archive

```bash
tar -tvf testShell00.tar
```

---

## ✅ Quick Recap (One-liner)

```bash
touch testShell00 && truncate -s 40 testShell00 && chmod 455 testShell00 && touch -t 202006012342 testShell00 && tar -cf testShell00.tar testShell00
```

---

## 🧾 Expected Output

```
-r--r-xr-x 1 <user> <group> 40 Jun  1 23:42 testShell00
```

✅ Correct permissions
✅ 40 bytes
✅ Right timestamp (or year)
✅ Archived in `testShell00.tar`

---

## ⚠️ Common Mistakes

🚫 Changing file after setting timestamp
🚫 Wrong permission order (chmod after last touch is safest)
🚫 Trying to fake `XX` values (those are placeholders)
🚫 Using the wrong octal permission (must be `455`)

---

## 🧩 GitHub Example Method

```bash
touch testShell00
truncate -s 40 testShell00
touch -t 202006012342 testShell00
chmod 455 testShell00
tar -cf testShell00.tar testShell00
```

Same result — just make sure the **timestamp** remains correct.

#########################################################.
