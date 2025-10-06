<h1 align="center">💠 Shell00 — Exercise 01 : <code>testShell00.tar</code></h1>

> **Target:** make a file named `testShell00` whose **permissions, size, and timestamp** produce an `ls -l` line like the subject’s example, then package it as `testShell00.tar`.

---

## 🎯 **Objective**

You’ll practice three core UNIX skills:

1. **Create files** and set their **size** without using an editor.  
2. Control a file’s **permissions** precisely (numeric/octal mode).  
3. Set a file’s **modification time** and **archive** it with `tar`.

These are day-one survival tools. If you can shape a file’s metadata directly from the shell, you’re already thinking like the OS.

---

## 🧠 **What You’ll Learn**

✅ How to create and modify files directly from the terminal  
✅ How to set file size, permissions, and timestamps  
✅ How to verify with `ls -l` and package using `tar`  
✅ How to interpret each part of a file’s attribute line  

---

## 🧰 **Command Toolbox (with flags & purpose)**

### 1) `touch`
- **Why:** create an empty file or update timestamps.  
- **Use:**  
  ```bash
  touch testShell00


Timestamp flag:

touch -t [[CC]YY]MMDDhhmm[.ss] testShell00


Example → touch -t 202006012342 testShell00 sets Jun 1 23:42, 2020.
If the date is more than ~6 months old, ls -l will show the year instead of the time — totally fine for this exercise.

2) truncate

Why: set the file to an exact byte size without editing.

Flag:

truncate -s 40 testShell00


-s 40 → the file becomes exactly 40 bytes long.

3) chmod

Before diving in — watch or read one of these if you need a full understanding of file permissions 🔑:

🎥 Video explanation: Go watch my video about file permissions

📘 Prefer reading? Read here about Linux permissions

Why: set permissions quickly with octal codes.

Use:

chmod 455 testShell00


Octal → 4 5 5 corresponds to -r--r-xr-x

Role	Bit	Meaning	Result
Owner	4	read only	r--
Group	5	read + execute	r-x
Others	5	read + execute	r-x

Reminder: r=4, w=2, x=1 → add them to get your permission numbers.

4) ls, cat, stat (for verification)

Long listing:

ls -l testShell00


Expected shape:

-r--r-xr-x 1 <user> <group> 40 Jun  1 23:42 testShell00


(Your <user> and <group> will be your real ones — don’t worry about XX.)

Check exact details:

stat -c '%A %h %U %G %s %y %n' testShell00


→ shows permissions, size, owner, and timestamp in one line.

5) tar

Why: package files for submission.

Command:

tar -cf testShell00.tar testShell00


c → create

f → specify filename
The resulting archive will contain your correctly configured file.

Optional:

tar -tvf testShell00.tar   # list contents
tar -xvf testShell00.tar   # extract contents (for testing)

🪜 Step-by-Step Solution (inside ex01/)

1️⃣ Create the file

touch testShell00


2️⃣ Set its size to 40 bytes

truncate -s 40 testShell00


3️⃣ Give it the right permissions

chmod 455 testShell00


4️⃣ Set its modification time to “Jun 1 23:42”

touch -t 202006012342 testShell00


If ls -l shows a year instead of the time, it’s still correct.

5️⃣ Verify your work

ls -l testShell00
# Expect: -r--r-xr-x 1 <user> <group> 40 Jun  1 23:42 testShell00


6️⃣ Create your submission archive

tar -cf testShell00.tar testShell00


7️⃣ (Optional) Check archive

tar -tvf testShell00.tar

⚡ One-liner Recap
touch testShell00
truncate -s 40 testShell00
chmod 455 testShell00
touch -t 202006012342 testShell00
tar -cf testShell00.tar testShell00

🧾 Expected ls -l Output
-r--r-xr-x 1 <user> <group> 40 Jun  1 23:42 testShell00


✅ 40 bytes
✅ Correct permissions
✅ Timestamp OK (or shows year)
✅ Archived in testShell00.tar

⚠️ Common Mistakes

🚫 Forgetting to set permissions after file creation
🚫 Wrong order (last touch -t ensures the correct mtime)
🚫 Editing the file manually (changes timestamp)
🚫 Trying to fake XX XX — they represent your real user/group

🧩 Alternative “GitHub Method”
touch testShell00
truncate -s 40 testShell00
touch -t 202006012342 testShell00
chmod 455 testShell00
tar -cf testShell00.tar testShell00
# Optional: tar -xvf testShell00.tar


Same result — just ensure your final timestamp is correct.
