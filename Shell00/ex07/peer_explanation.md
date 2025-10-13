# ⚙️ Shell00 — Exercise 07 : `diff` & `patch`

> **Turn-in directory:** `ex07/`
> **File to submit:** `b`
> **You do *not* submit:** `a`, `sw.diff`, screenshots, or notes

---

## 🎯 Goal

Understand how to:

* **Record differences** between two files with `diff`.
* **Apply those differences** with `patch`.
* Produce the required file **`b`** from the given **`a`** and **`sw.diff`**.

---

## 🧠 Core Idea (in one line)

* `diff a b > sw.diff` → **write the recipe of changes** that turns **`a` → `b`**
* `patch a sw.diff -o b` → **apply that recipe** to `a` to **rebuild `b`**

---

## 🧭 Visual Map

```
┌──────────────┐        ┌──────────────┐
│   File a     │        │   File b     │
│ (original)   │        │ (modified)   │
└──────┬───────┘        └──────┬───────┘
       │        differences    │
       └──────────┬────────────┘
                  │
            diff a b  > sw.diff
                  │
                  ▼
          ┌──────────────┐
          │   sw.diff    │
          │ (change log) │
          └──────┬───────┘
                 │ apply
                 ▼
         patch a sw.diff -o b
```

---

## 🧩 Why this matters (real-world)

* **Smaller updates:** ship only the *changes*, not whole files (faster downloads, easier reviews).
* **Version control DNA:** Git is built on diff/patch concepts (commits are changes, not full copies).
* **Code review & collaboration:** patches are the standard way to propose and apply edits safely.

---

## 🪜 Step-by-Step (clean, reproducible tutorial)

> You can **start from scratch** or skip to Step 4 if you already have the school-provided `a` and `sw.diff`.

### 1) Create **`a`** (original text — Episode IV / Leia)

```bash
cat > a <<'EOF'
STARWARS
Episode IV, A NEW HOPE It is a period of civil war.

Rebel spaceships, striking from a hidden base, have won their first victory against the evil
Galactic Empire.
During the battle, Rebel spies managed to steal secret plans to the Empire's ultimate weapon, the
DEATH STAR,
an armored space station with enough power to destroy an entire planet.

Pursued by the Empire's sinister agents, Princess Leia races home aboard her starship, custodian of
the stolen plans that can save her people and restore freedom to the galaxy...
EOF
```

### 2) Create **`b`** (modified text — Episode V / Mehdi) *(for learning/testing)*

```bash
cat > b <<'EOF'
STARWARS
Episode V, A NEW H0PE It is a period of civil war.

Rebel spaceships, striking from a hidden base, have won their first victory against the evil Galactic Empire. 
During the battle, Rebel spies managed to steal secret plans to the Empire's ultimate weapon, the STAR DEATH, an armored space station with enough power to destroy an entire planet.


Pursued by the Empire's sinister agents,
Princess Mehdi races home aboard her starship, custodian of the stolen plans that can save her people and restore the dictatorship to the galaxie..
EOF
```

### 3) Generate a diff file (the “recipe of changes”)

```bash
diff a b > sw.diff
```

* Exit code **1** from `diff` just means “files differ” → **expected**.
* Open it to see the instructions:

  ```bash
  cat sw.diff
  ```

### 4) Rebuild **`b`** using only **`a` + `sw.diff`**

> This step mirrors the *actual* evaluation: you get `a` and `sw.diff`, you must produce `b`.

```bash
patch a sw.diff -o b
```

* `-o b` → write the patched result to **`b`** (don’t overwrite `a`).

### 5) Verify

```bash
# Compare the rebuilt b to an existing b (if you created it in step 2):
diff b b && echo "Identical ✅" || echo "Differences ❗"

# Or simply inspect the file:
sed -n '1,200p' b
```

---

## 🧪 Mini demo of `diff` output (how to read it)

Example snippet:

```
2c2
< Episode IV, A NEW HOPE ...
---
> Episode V, A NEW H0PE ...
```

* `2c2` → line 2 **changed**
* `<` old line from `a`
* `>` new line from `b`

Other symbols you might see:

* `a` = add, `d` = delete, `c` = change

---

## 🧾 Commands Cheat Sheet

```bash
# Show differences on screen
diff a b

# Save difference instructions to a file
diff a b > sw.diff

# Apply differences (build b from a + sw.diff)
patch a sw.diff -o b

# See file with ‘$’ line-ends (to debug blank lines/newlines)
cat -A a
cat -A b
```

---

## ✅ What to Submit (strict 42 rules)

* **Submit only:** `ex07/b`
* **Do not submit:** `a`, `sw.diff`, patch files, or explanations

The grader will recreate your `b` by running something like:

```bash
patch a sw.diff -o b_check
diff b b_check   # must show no output
```

---

## ⚠️ Common Pitfalls (and fixes)

* **Reversed direction:** remember, the diff must be **from `a` to `b`**.
* **Forgot `-o b`:** patch might overwrite `a` if you omit it.
* **Whitespace/blank lines:** use `cat -A` to confirm exact newlines.
* **Non-zero `diff` exit (1):** not an error; it just means “files differ.”

---

## 📦 Optional: Git commit example

```bash
git add b
git commit -m "Shell00 - ex07: created file b by applying sw.diff to a"
git push
```

---

### 🧩 Summary

* **`a`** = original text
* **`b`** = modified/corrected text
* **`sw.diff`** = compact **instructions** to transform `a` → `b`
* **`patch`** applies those instructions to rebuild `b`
* **Submit only `b`** for the exercise ✅


