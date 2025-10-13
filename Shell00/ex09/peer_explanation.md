````markdown
# 🪄 Exercise 09 — ft_magic  
### *Illusions, not tricks, Michael…*

---

## 🎯 Target  
Create a **custom magic file** that identifies files containing the string `"42"` at the **42nd byte**.  
When the file detection command (`file`) runs, it should label matching files as a **“42 file.”**

---

## 📘 Concept  

Linux determines a file’s type by reading **magic numbers or text signatures** defined in special database files.  
You can extend this logic by creating your own **magic file** — like `ft_magic` — to teach Linux how to detect your custom file types.

So, in this exercise:  
> We build a `ft_magic` file that can be used to scan other files to find a specific pattern (`"42"` at byte 42).

---

## 🧩 The Magic Rule  

```bash
41  string  42  42 file
````

| Field     | Meaning                    | Description                                                                       |
| --------- | -------------------------- | --------------------------------------------------------------------------------- |
| `41`      | **Offset (byte position)** | The byte position where the search begins. Starts from 0, so byte 42 = offset 41. |
| `string`  | **Data type**              | Tells the system to look for a sequence of characters (a string).                 |
| `42`      | **Pattern to match**       | The content being searched for.                                                   |
| `42 file` | **Output label**           | What will be displayed when the pattern is found.                                 |

🧠 **Why 41, not 42?**
Because file bytes are indexed starting from 0 — the first byte is 0, the 42nd is 41.

---

## ⚙️ Step-by-Step Solution

### 1️⃣ Create the magic definition file

```bash
vim ft_magic
```

Inside, write:

```bash
41  string  42  42 file
```

Then save and exit.

---

### 2️⃣ Compile the magic file

```bash
file -C -m ft_magic
```

✅ This compiles your rule into:

```
ft_magic.mgc
```

#### 🧠 What’s happening here?

This command does **two jobs at once**:

1. **`-C` (Compile):**
   Tells `file` to *compile* your text-based magic file (`ft_magic`) into a **binary database** (`ft_magic.mgc`)
   — optimized for faster lookups.

2. **`-m ft_magic`:**
   Points `file` to the **source magic file** it should compile.

🧩 In other words:

> “Compile this custom magic definition (`ft_magic`) into a usable compiled magic database (`ft_magic.mgc`).”

After compiling, you can use your new magic rules with:

```bash
file -m ft_magic.mgc somefile
```

#### 💡 Summary of `-m` Flag

| Situation          | Command                        | Meaning                                                  |
| ------------------ | ------------------------------ | -------------------------------------------------------- |
| During compilation | `file -C -m ft_magic`          | “Compile this magic file into `.mgc`.”                   |
| During testing     | `file -m ft_magic.mgc test_42` | “Use this compiled magic database to detect file types.” |

So yes — at first, you’re creating and compiling your own custom magic file.
After that, you use the compiled version to **run tests on other files** and detect matches.

---

### 3️⃣ Create a test file

We need a test file with `"42"` exactly at byte 42.

```bash
printf '%041s42' "" > test_42
```

🧠 Explanation:

* `%041s` → prints 41 spaces (filling the first 41 bytes).
* `"42"` → gets added at the end (bytes 42 and 43).
  Result: `"42"` sits perfectly at byte 42.

---

### 4️⃣ Test your magic file

```bash
file -m ft_magic.mgc *
```

✅ Expected output:

```
test_42: 42 file
```

If no `"42"` is found at the 42nd byte, output will be the regular file type (like `ASCII text`).

---

## 🧠 How It Works

When you run:

```bash
file -m ft_magic.mgc test_42
```

Here’s what happens internally:

1. The `file` command loads your custom `ft_magic.mgc` rule.
2. It reads your file starting from offset **41 (the 42nd byte)**.
3. If it finds the pattern `"42"`, it prints **“42 file.”**
4. Otherwise, it falls back to the normal detection (e.g., “ASCII text”).

That’s the same mechanism Linux uses to recognize:

* PNGs (start with `\x89PNG`)
* ELF binaries (`0x7FELF`)
* PDFs (`%PDF-`)

---

## 🧩 Why We Create a Magic File

Because we want to **teach the `file` command how to detect our own custom file types**.
By defining specific rules in a `ft_magic` file, we can run:

```bash
file -m ft_magic.mgc otherfile
```

and it will tell us whether that file matches our condition.

So yes:

> We first create a `ft_magic` file — then we use it later to scan other files to find what we’re looking for.

It’s like building your own version detector or file-type identifier.

---

## ⚠️ Common Mistakes

| Mistake                      | What Happens                               |
| ---------------------------- | ------------------------------------------ |
| Offset written as `42`       | Checks byte 43, not 42 — detection fails.  |
| Extra spaces or tabs         | The `file` parser breaks.                  |
| Not recompiling after edit   | Old `.mgc` used — changes ignored.         |
| Forgetting `-m ft_magic.mgc` | Uses system database instead of your rule. |

---

## ✅ Final File Content

Your `ft_magic` must contain exactly:

```bash
41  string  42  42 file
```

No comments.
No extra lines.

---

## 🧰 Useful Commands Recap

| Command                         | Purpose                                  |
| ------------------------------- | ---------------------------------------- |
| `file -C -m ft_magic`           | Compile your custom rule into `.mgc`.    |
| `printf '%041s42' "" > test_42` | Create test file with “42” at byte 42.   |
| `file -m ft_magic.mgc *`        | Test using your compiled magic database. |

---

## 💡 Bonus Tip

If you want to explore real system magic files:

```bash
less /usr/share/misc/magic
```

You’ll find definitions for thousands of real file types like `.jpg`, `.mp3`, `.pdf`, `.png`, etc.

---

✨ *You’ve just created your own file-type detector — a “42 file.”*

```
