# 🧪 Shell00 — ex06 `skip.sh` — Peer Explanation

> **Task:** *Display every other line of `ls -l`, starting from the first line.*  
> **One-liner we’ll use:**  
> ```bash
> ls -l | sed -n 'p;n'
> ```

---

## 1) What the subject wants (in plain words)
- Run `ls -l` (long listing)
- Show **line 1, 3, 5, …** of that output (i.e., *odd-numbered* lines)
- Implement it in a script called **`skip.sh`**
- No extra noise, no hacks — just do exactly that

---

## 2) Final `skip.sh` (correct and minimal)

```bash
#!/bin/bash
# Print every other line from `ls -l`, starting with the first.
ls -l | sed -n 'p;n'
```

Make it executable and test:
```bash
chmod +x skip.sh
./skip.sh
```

---

## 3) Why this works — short & sharp

### `sed -n 'p;n'` explained
- `-n` → **quiet mode** (don’t print lines unless told to)
- `p`   → **print** the current line
- `n`   → **read next line** and **don’t print** it (because `-n`), then continue

So the cycle is: **print 1**, skip 2, **print 3**, skip 4, …

### The pipe
- `|` passes the output of `ls -l` to `sed` **line-by-line**.

---

## 4) Visual mental model

Think of a metronome ticking pairs of beats.  
On beat 1 → speak (print). On beat 2 → stay silent (skip). Repeat.

---

## 5) Common mistakes to avoid
- ❌ Forgetting `-n` (you’ll print everything plus duplicates)
- ❌ Using `ls -1` instead of `ls -l` (subject explicitly says `-l`)
- ❌ Filtering out the `total …` line — it **counts as line 1**
- ❌ Adding extra `echo` output (the checker compares lines exactly)

---

## 6) Quick verification

```bash
# Total lines from ls -l
N=$(ls -l | wc -l)

# Lines from our script (should be ceil(N/2))
M=$(./skip.sh | wc -l)

printf "ls -l lines: %s | skip.sh lines: %s\n" "$N" "$M"
```

Spot-check the first few lines:
```bash
ls -l | nl | head -6
./skip.sh | nl | head -6
```

---

## 7) Useful variants (for curiosity / peer Q&A)

> Print **even** lines instead of odd:  
```bash
ls -l | sed -n 'n;p'
```

> Print **every 3rd** line (3, 6, 9, …):  
```bash
ls -l | sed -n 'n;n;p'
```

> Print **only** line 5:  
```bash
ls -l | sed -n '5p'
```

> Print a **range** (lines 3..6):  
```bash
ls -l | sed -n '3,6p'
```

> Show odd lines **with numbers** (purely visual):  
```bash
ls -l | nl | sed -n 'p;n'
```

---

## 8) Mini-FAQ (fast answers)

- **Does `sed` modify files here?** No. It just filters **output** (no files touched).
- **Why count starts at the “total …” line?** That’s line 1 in `ls -l`. Good — we want that.
- **GNU vs BSD/macOS differences?** `sed -n 'p;n'` works on both; it’s POSIX‑friendly.

---

## 9) Peer-eval checklist

- [ ] `skip.sh` exists and is executable
- [ ] Uses `ls -l | sed -n 'p;n'` (or an equivalent that prints 1,3,5,…)
- [ ] No extra prints/side effects
- [ ] Behavior: **ceil( (lines of ls -l)/2 )** lines printed
- [ ] Clean code, no trailing spaces, newline at EOF

---

## 10) One-liner recap (for memory)

> **“Print one, skip one.”** That’s all `p;n` does under `-n`.

```bash
ls -l | sed -n 'p;n'
```

---

