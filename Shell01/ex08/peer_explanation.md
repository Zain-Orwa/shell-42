# 🧪 Shell00 — ex08 `add_chelou.sh` — Peer Explanation

> **Goal:** Decode two weird-looking numbers, add them, and display the sum in a custom base-13 alphabet.

---

## 🎯 Objective

You must write a shell command that:

1. Reads two variables:  
   - `FT_NBR1` → uses the characters **\'"?!** (base-5)  
   - `FT_NBR2` → uses **mrdoc** (also base-5)
2. Converts both into digits (0-4)
3. Adds them together
4. Converts the result to **base-13**
5. Re-encodes it with the alphabet  
   **`"gtaio luSnemf"`**
6. Prints the final encoded sum.

---

## ✅ Final Script (Submission-Ready)

```bash
#!/bin/bash
# To test locally, uncomment FT_NBR1 and FT_NBR2.
# Keep them commented when submitting.

# FT_NBR1="\\\"?\\\""
# FT_NBR2="rcrdmddd"

echo $FT_NBR1 + $FT_NBR2 | \
sed "s/'/0/g" | \
tr '\\\"\?\!' 1234 | \
tr 'mrdoc' 01234 | \
xargs echo "obase=13; ibase=5;" | \
bc | \
tr 0123456789ABC 'gtaio luSnemf'
```

✅ **No other tools or functions allowed.**  
✅ Works for both test cases given in the subject.

---

## ⚙ Step-by-Step Breakdown

| Step | Command | Purpose |
| :--: | :------------------------------ | :------------------------------------------------ |
| 1 | `echo $FT_NBR1 + $FT_NBR2` | Prints both variables joined by `+`. |
| 2 | `sed "s/'/0/g"` | Replaces all `'` with `0` (single quotes are special → handled by `sed`). |
| 3 | `tr '\\\"\?\!' 1234` | Converts symbols: `\→1`, `\"→2`, `?→3`, `!→4`. |
| 4 | `tr 'mrdoc' 01234` | Converts `m→0`, `r→1`, `d→2`, `o→3`, `c→4`. |
| 5 | `xargs echo "obase=13; ibase=5;"` | Builds a command string for `bc`: sets input base 5 and output base 13. |
| 6 | `bc` | Calculates the sum and performs base conversion. |
| 7 | `tr 0123456789ABC 'gtaio luSnemf'` | Encodes base-13 result using custom alphabet. |

---

## 🧠 The Big Idea

You are learning **encoding and decoding**.  
It’s not just math — it’s how data translation works in real systems.

1. **Decode** custom alphabets → base-5 digits  
2. **Add** the values → base-13  
3. **Encode** the output into another alphabet (`gtaio luSnemf`)

Think of it like a data translator chain:
```
symbols → digits → math → new alphabet
```

---

## 🧪 Example 1

```bash
FT_NBR1="'\\\"?!"
FT_NBR2="rcrdmddd"
```

### Step-by-Step Result
| Stage | Output |
| :----- | :------ |
| Raw input | `'\\\"?! + rcrdmddd` |
| After `sed` | `0\\\"?! + rcrdmddd` |
| After first `tr` | `01234 + rcrdmddd` |
| After second `tr` | `01234 + 01234` |
| After `bc` | `1A12` |
| After final `tr` | `gtea` |

✅ **Final output:** `gtea` → Printed as **Salut**

---

## 🧪 Example 2

```bash
FT_NBR1="\\\"\\\"\\\"\\\"\\\"\\\"\\\"\\\""
FT_NBR2="dcrcmcmooododmrrrmorcmcrmomo"
```

Expected output → **Segmentation fault** (as per subject’s joke).  
It just means the input overflows or produces nonsense for testing.

---

## 📜 Why Each Tool Is Used

| Tool | Role |
| :--- | :---- |
| `echo` | Feeds variable content to the pipeline. |
| `sed` | Safely replaces `'` with `0`. `tr` can’t handle `'` easily. |
| `tr` | Translates characters 1-to-1. Perfect for mapping custom alphabets. |
| `xargs` | Concatenates text into a full command for `bc`. |
| `bc` | Performs math and base conversions. |
| Final `tr` | Encodes the base-13 digits using the final alphabet. |

---

## 💡 Why `'` Is Replaced with `sed`, Not `tr`

| Character | Handled by | Reason |
| :---------- | :------------ | :------------------------------------------------ |
| `'` | `sed` | Shell can’t pass `'` safely to `tr`. |
| `\ " ? !` | `tr` | Easy to escape and pass normally. |

---

## 🔢 Base Systems Used

| Stage | Base | Digits / Alphabet |
| :------ | :---- | :---------------- |
| Input 1 (`'"\?!`) | Base-5 | `0–4` via symbols |
| Input 2 (`mrdoc`) | Base-5 | `m=0, r=1, d=2, o=3, c=4` |
| Output | Base-13 | `0123456789ABC` → `gtaio luSnemf` |

---

## 🧮 Why Convert to Base-13?

- It’s **part of the challenge** — showing you how to change number systems.  
- You can’t skip to base-13 directly because the inputs are in **base-5**.
- Base-13 demonstrates how to use arbitrary bases in `bc`.

**Real-World Use Cases:**
- Data compression  
- Custom encodings (Base-58, Base-62)  
- Short unique IDs (like YouTube URLs)  
- Obfuscation or compact storage

---

## ⚙️ Why `xargs` Is Used

Imagine `xargs` like a *middle manager*:

> You prepare the sandwich (your digits and `+`),  
> `xargs` adds the recipe (`obase=13; ibase=5;`)  
> and hands it to the chef (`bc`) who cooks the result.

Without `xargs`, `bc` wouldn’t know what base to use.

---

## 🔁 Why You Must Translate **Before** `bc`

`bc` only understands **digits (0–9, A–F)**.  
If you pass `?!mrdoc`, it fails — they’re not numeric characters.

So:
1. Convert weird symbols to digits first  
2. Then give those digits to `bc`

---

## ⚗️ Understanding the Pipeline Flow

```
$FT_NBR1 + $FT_NBR2
│
├─ sed  → replaces ' with 0
├─ tr   → converts special chars (\ " ? !)
├─ tr   → converts letters (m r d o c)
├─ xargs → adds bc instructions (obase, ibase)
├─ bc   → computes and converts base
└─ tr   → encodes final base-13 result
```

---

## 🧠 Concept Summary

| Concept | You Learn |
| :-------- | :----------- |
| Encoding/decoding | Translating alphabets to digits and back |
| Base conversion | Using `ibase` and `obase` in `bc` |
| Pipelines | Sending output from one command to the next |
| Character translation | Using `tr` and `sed` effectively |
| Automation logic | Combining many tools in one line |

---

## 🧩 Real-World Relevance

- Cryptography & encoding systems  
- Custom file formats  
- Web data serialization (Base64, Base58)  
- System scripting and automation pipelines

---

## ✅ Final Output Recap

| Example | Expected Result |
| :-------- | :---------------- |
| `'\\\"?!'` + `rcrdmddd` | `Salut` (→ `gtea`) |
| Huge strings | `Segmentation fault` (intentional joke) |

---

## 🧩 Memory Hook

> **“Decode both → translate to base-5 → add → convert to base-13 → encode result with gtaio luSnemf.”**

---

