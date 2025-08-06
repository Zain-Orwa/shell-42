# 🧠 Challenge: Decode and Print a Secret Message using Base-5 and Base-11

## 📋 Objective

You are given 3 encoded strings that represent base-5 numbers using **custom character sets**.  
Your goal is to:

1. Decode each string into digits.
2. Convert each to decimal.
3. Add all three decimal values.
4. Convert the sum to **base-11**.
5. Use a custom alphabet (`HELLO WORLD`) to encode the result into a human-readable message.

---

## 🔣 Base-5 Custom Alphabets

### For `VAR1` and `VAR3`:
Characters are encoded using this mapping:

| Char | Digit |
|------|--------|
| m    | 0      |
| r    | 1      |
| d    | 2      |
| o    | 3      |
| c    | 4      |

### For `VAR2`:
Characters are encoded using this mapping:

| Char | Digit |
|------|--------|
| `'`  | 0      |
| `\`  | 1      |
| `"`  | 2      |
| `?`  | 3      |
| `!`  | 4      |

---

## 🔤 Base-11 Output Alphabet

Use the digits of base-11 and map them to:

0123456789A → HELLO WORLD

The Message is: LHH


| Digit | Letter   |
|-------|----------|
| 0     | H        |
| 1     | E        |
| 2     | L        |
| 3     | L        |
| 4     | O        |
| 5     | (space)  |
| 6     | W        |
| 7     | O        |
| 8     | R        |
| 9     | L        |
| A     | D        |

---

## 📥 Inputs

```bash
VAR1="rdcm"
VAR2="'?!\\"
VAR3="mroc"


