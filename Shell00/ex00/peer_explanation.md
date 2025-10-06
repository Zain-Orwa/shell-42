### 🎯 Objective
This very first Shell exercise might look trivial, but it’s designed to make you comfortable with **basic file creation** directly from the shell — no editors, no functions, no shortcuts.

It’s all about **understanding how input and output redirection work** in Linux.  
By the end, you’ll know how to create and fill a file without ever opening a text editor.

---

### 🧠 What You’ll Learn
- How to **create a new file** directly through the terminal  
- How to use **redirection (`>`)** to write content into a file  
- How to use **`cat`** both to read and to create files  
- How to verify exact file contents including newline characters  

---

## 🧩 Exercise Description

> Create a file called **`z`** that contains the character:
> ```
> Z
> ```
> followed by a newline.  
> When you execute `cat z`, it must display:
> ```
> Z
> ```

**Turn-in directory:** `ex00/`  
**Files to submit:** `z`  
**Allowed functions:** None  

---

## 🛠️ Solutions (Three Valid Shell Methods)

### ✅ Method 1: Using `echo`
This is the simplest and most direct method.  
`echo` prints text to standard output, and the redirection `>` writes it into a file.

```bash
echo "Z" > z
````

Then verify:

```bash
cat z
```

Output:

```
Z
```

---

### ✅ Method 2: Using `cat` with manual input (42 classic method)

This is the one shown in your GitHub screenshot — and it’s **fully valid** for the Piscine.

1. Start `cat` in write mode:

   ```bash
   cat > z
   ```
2. Type:

   ```
   Z
   ```
3. Then press `Ctrl + D` (to end input and save)

Now check your file:

```bash
cat z
```

Output:

```
Z
```

---

### ✅ Method 3: Using `echo` with newline verification

Sometimes you want to make sure your file ends **with** a newline — since `echo` by default adds one, this is a safe method.

```bash
echo "Z" > z
```

Then check with:

```bash
cat -e z
```

Output:

```
Z$
```

The `$` symbol means there’s a newline — exactly what the evaluator expects.

---

## 🔍 Verification

You can run this to confirm everything’s perfect:

```bash
cat -e z
```

Expected output:

```
Z$
```

---

## ⚙️ Summary

| Method | Command                         | Allowed | Notes                       |
| :----- | :------------------------------ | :------ | :-------------------------- |
| 1      | `echo "Z" > z`                    |    ✅   | Fastest and clean           |
| 2      | `cat > z` → type `Z` → `Ctrl+D`       |    ✅   | Official 42-friendly way    |
| 3      | `echo` + verify with `cat -e`       |    ✅   | Ensures newline correctness |

---

### 💬 Key Takeaway

This exercise proves you don’t need any code or functions —
just pure shell redirection and a solid understanding of how **standard output** works.

