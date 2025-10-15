# 🧾 Exercise 01 — `print_groups.sh`

> **Goal:** Print all groups for the user stored in env var **`FT_USER`**, as a **single line**, **comma-separated**, **no spaces**, **no trailing newline**.
> **Turn in:** `ex01/print_groups.sh`

---

## 🚀 Final script (minimal, passes 42)

```bash
#!/bin/sh
id -nG "$FT_USER" | tr -s ' ' ',' | tr -d '\n'
```

That’s it. One pipeline, no extra commands.

---

## 🧠 Why this works (short & sharp)

* `id -nG "$FT_USER"` → list **G**roups **n**amed (not IDs) for that login. Output is space-separated.
* `tr -s ' ' ','` → **s**queeze spaces and translate them to commas → `grp1,grp2,grp3`
* `tr -d '\n'` → **d**elete the trailing newline so the prompt appears right after the result.

> Using `-s` protects you if `id` ever emits multiple spaces (rare, but safe).

---

## ▶️ How to run (set `FT_USER` at run time)

You don’t hardcode the user in the script. You pass it via the environment:

```bash
# one-off env var for a single run
FT_USER=nours ./print_groups.sh

# or export it for the shell session
export FT_USER=daemon
./print_groups.sh
```

Expected outputs (examples from the PDF):

```
god,root,admin,master,nours,bocal
daemon,bin
```

> If `FT_USER` is **unset**, `id` with an empty argument may fall back to the current user on some systems, which is **not** what the subject asks. Always set `FT_USER` before running.

---

## 🔒 Optional: stricter variant (error if FT_USER not set)

If your evaluator allows a tiny guard (still one pipeline for the core logic), you can fail fast:

```bash
#!/bin/sh
: "${FT_USER:?FT_USER is not set}"  # prints error to stderr and exits if missing
id -nG "$FT_USER" | tr -s ' ' ',' | tr -d '\n'
```

If they’re picky about **exactly one command**, stick to the minimal version at the top.

---

## 🧪 Quick self-test

```bash
FT_USER="$USER" ./print_groups.sh
# Cross-check with raw id:
id -nG "$USER" | tr ' ' '\n'    # same groups, shown one per line
```

---

## 📦 Submission layout

```
ex01/
└── print_groups.sh   # contains the 1-liner above (with shebang)
```

Give it exec perms (not strictly required by all checkers, but good hygiene):

```bash
chmod +x ex01/print_groups.sh
```

Done. Clean and correct.

