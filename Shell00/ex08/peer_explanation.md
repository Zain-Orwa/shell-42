```markdown
# 🧹 Exercise 08 — clean

> **Objective:**  
> Write a single command that finds and deletes all unwanted backup or temporary files in the current directory and its subdirectories.

---

## 📂 Turn-in File

```

ex08/
└── clean

````

---

## 💡 Subject Summary

In this exercise, you must write **one single `find` command** (no semicolons `;`, `&&`, or multiple commands).  
The command must:
- Search **recursively** in the current directory and all its subdirectories.
- Find files that:
  - **End with `~`** (like `main.c~` — editor backup files)
  - **Start and end with `#`** (like `#notes#` — editor auto-save files)
- **Print** the paths of the found files.
- **Delete** those files immediately after printing.

---

## 🧠 The Final Command

```bash
find . -type f \( -name '*~' -o -name '#*#' \) -print -delete
````

This line must be the only content inside the file **`clean`**.

---

## 🧩 Explanation of Each Part

| Part          | Meaning                                           | Why it’s Needed                                                                     |
| ------------- | ------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `find`        | The Unix tool to search and process files.        | It’s the only allowed and needed command.                                           |
| `.`           | Start search **in the current directory**.        | The task requires searching recursively from here.                                  |
| `-type f`     | Limit results to **regular files**.               | Prevents deleting directories by mistake.                                           |
| `\(` `\)`     | Group conditions inside parentheses.              | Needed for logical operations like OR. Escaped so the shell doesn’t interpret them. |
| `-name '*~'`  | Match filenames ending with `~`.                  | Finds editor **backup** files like `main.c~`.                                       |
| `-o`          | Logical **OR** between tests.                     | Means “match this OR that.”                                                         |
| `-name '#*#'` | Match filenames starting **and** ending with `#`. | Finds **auto-save** files like `#draft#`, created by editors like Emacs.            |
| `-print`      | Print the path of each file found.                | The subject says it must “show” files before deleting.                              |
| `-delete`     | Delete each file found.                           | Removes them immediately after printing.                                            |

---

## ⚙️ How It Works (Step-by-Step)

1. `find` begins scanning the current directory (`.`) and all subdirectories.
2. It checks every **file** (`-type f`) it encounters.
3. For each file, it tests:

   * Does the name end with `~`?
   * OR does the name start and end with `#`?
4. If either test matches:

   * The file path is **printed** to the terminal.
   * Then the file is **deleted** immediately (`-delete`).
5. Once all matches are processed, the search finishes.

---

## 🧪 Example Test

Create some dummy files:

```bash
mkdir test_folder
touch test_folder/file.c~ test_folder/#draft# test_folder/normal.c
```

Run your command:

```bash
sh clean
```

Output:

```
./test_folder/file.c~
./test_folder/#draft#
```

Check again:

```bash
find test_folder -type f
```

Output:

```
./test_folder/normal.c
```

✅ Only the backup/temporary files were deleted.

---

## ⚠️ Common Mistakes

* ❌ Forgetting to **escape parentheses** → use `\(` and `\)`
* ❌ Not quoting patterns (`*~`, `#*#`) → shell expands them before `find` sees them
* ❌ Missing `-type f` → may accidentally delete directories
* ❌ Swapping `-print` and `-delete` → then you won’t see output (order matters)
* ❌ Using multiple commands or `;` → forbidden in the subject

---

## 🧠 Why These Files Exist

* Files ending in `~` → created automatically by editors (like **vim**, **nano**) as backups.
* Files starting and ending with `#` → created by **Emacs** or similar editors as **auto-save** files.
* If an editor crashes, these remain behind.
* So the purpose of this exercise is to learn to **automate cleanup safely** with `find`.

---

## ✅ Final Notes

* Your file **must contain only one line**:

  ```bash
  find . -type f \( -name '*~' -o -name '#*#' \) -print -delete
  ```
* Do **not** include comments or multiple commands in the submitted file.
* The checker runs your file with `sh clean`, so make sure it works exactly as expected.

---

