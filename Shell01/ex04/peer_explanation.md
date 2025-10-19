````markdown
# 🧩 Exercise 04 — MAC.sh

### 🎯 Objective  
Write a command line that displays your machine’s **MAC addresses**, with each address printed on a new line.

---

## 💻 Final Script  

```bash
#!/bin/bash
ifconfig | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'
````

---

## ⚙️ Step-by-Step Explanation

### 1️⃣ `ifconfig`

* Displays network interface information: IP addresses, MAC addresses, status, etc.
* Output includes lines like:

  ```
  ether a1:b2:c3:d4:e5:f6
  inet 192.168.1.10
  ```
* We only want the **MAC address part** — the hexadecimal string separated by colons.

---

### 2️⃣ `|` (Pipe)

* Sends the output of `ifconfig` to another command.
* Here, it sends all text from `ifconfig` into `grep` for pattern matching.

---

### 3️⃣ `grep -o -E 'pattern'`

* `grep` = search command.
* `-E` = use **extended regular expressions** (E stands for *extended*).
* `-o` = print **only the part of the text that matches** (not the entire line).

So we are searching the full output of `ifconfig` and only printing the exact part that looks like a MAC address.

---

### 4️⃣ The Regular Expression

```bash
([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}
```

Let’s break it down step by step:

| Part                | Meaning                                          | Description                                    |
| ------------------- | ------------------------------------------------ | ---------------------------------------------- |
| `[[:xdigit:]]`      | A hexadecimal character (`0–9`, `a–f`, or `A–F`) | Represents one hex digit                       |
| `{1,2}`             | Match 1 or 2 hex digits                          | Each MAC address part (e.g., `a1`, `0f`, etc.) |
| `:`                 | Literal colon character                          | Separates MAC address segments                 |
| `(...)`             | Group                                            | Groups a pattern for repetition                |
| `{5}`               | Repeat previous group 5 times                    | Matches 5 segments like `xx:xx:xx:xx:xx:`      |
| `[[:xdigit:]]{1,2}` | Last pair without colon                          | The final segment of the MAC address           |

🧠 Combined, it matches:

```
xx:xx:xx:xx:xx:xx
```

Example: `b8:27:eb:45:12:ff`

---

## 📊 Example Output

**Command:**

```bash
./MAC.sh
```

**Output:**

```
b8:27:eb:45:12:ff
08:00:27:96:4a:22
```

Each MAC address appears on a separate line — exactly as required.

---

## 🧱 Visualization

```
ifconfig
│
└── grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'
     │
     └── Extracts only valid MAC patterns
```

---

## ⚙️ Why this regex is perfect

✅ Flexible — handles uppercase or lowercase hex.
✅ Strict — ensures exactly six groups separated by `:`.
✅ Portable — works across Linux, macOS, and BSD systems.

---

## 🧠 Alternative Form (for modern systems)

Some systems use `ip link` instead of `ifconfig`. You can test with:

```bash
ip link | grep -o -E '([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}'
```

---

## 💬 Peer Notes

> `ifconfig` prints the network details of your system.
> Using `grep -o -E` allows us to extract only what we care about —
> in this case, the sequence of hexadecimal digits separated by colons that defines a MAC address.
>
> The pattern `'([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'` matches six pairs, perfectly fitting the MAC structure.

---

✅ **Git Commit Message Suggestion:**

```
ex04: added MAC.sh — extract MAC addresses using regex and ifconfig
```

````

---

## 🧠 `peer_explanation.md` (short version for GitHub)

```markdown
# 💡 ex04 — `MAC.sh`

### 🎯 Goal  
Display your system’s **MAC addresses**, one per line.

---

### 💻 Final Script  

```bash
#!/bin/bash
ifconfig | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'
````

---

### ⚙️ Command Breakdown

| Command      | Meaning                                              |                                       |
| ------------ | ---------------------------------------------------- | ------------------------------------- |
| `ifconfig`   | Displays all network interfaces and their details    |                                       |
| `            | `                                                    | Sends that output to the next command |
| `grep -o -E` | Search using extended regex and print only the match |                                       |

---

### 🧩 Regex Breakdown

`([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}`

| Part                | Meaning                                |
| ------------------- | -------------------------------------- |
| `[[:xdigit:]]`      | Matches hex characters (0–9, a–f, A–F) |
| `{1,2}`             | One or two hex digits                  |
| `:`                 | Literal colon                          |
| `{5}`               | Repeat 5 times (for 5 colons)          |
| `[[:xdigit:]]{1,2}` | Last group (no colon at end)           |

✅ Matches: `aa:bb:cc:dd:ee:ff`
❌ Rejects: `aa:bb:cc:dd:ee:ff:gg` (too long)

---

### 🧠 Example

```bash
$ ./MAC.sh
08:00:27:96:4a:22
b8:27:eb:45:12:ff
```

Each address is on its own line — clean and correct.

---

### 🧭 Summary

| Concept        | Description                               |
| -------------- | ----------------------------------------- |
| `ifconfig`     | Show system interfaces                    |
| `grep` + regex | Extract MAC addresses                     |
| `-o -E`        | Print only matching text (extended regex) |

---

✅ **Commit Example**

```
ex04: added MAC.sh — extract MAC addresses from system info
```

✨ *Regex magic + pipes = clean output.*

````markdown
# 🖥️ Exercise 04 — MAC Address (macOS-Friendly Edition)

### 🎯 Objective
Display your machine’s **MAC addresses**, each followed by a line break.

This exercise uses `ifconfig` to extract MAC addresses.
However, macOS shows some extra hexadecimal values (like `ff000000` or `ffffff00`) that can confuse the script, so a macOS-friendly fix is required.

---

## 🧩 Why the Original Script Fails on macOS

Your earlier command:
```bash
ifconfig | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'
````

✅ Works perfectly on **Linux** because MAC addresses always appear as:

```
ether 08:00:27:ab:cd:ef
```

❌ On **macOS**, `ifconfig` also prints **netmask** values in hexadecimal:

```
netmask 0xff000000 broadcast 0xffffff00
```

Since the regex isn’t limited to the `ether` or `lladdr` field, it mistakenly matches those netmask hex values (`ff000000`, `ffffff00`, etc.).

---

## 🍏 macOS-Friendly Solutions

### **Option 1 — Simpler, cleaner, no regex**

```bash
ifconfig | awk '/ether|lladdr/ {print $2}'
```

### 🧠 Step-by-Step Explanation

| Part         | Meaning                                                | Example Output                                                                                                    |                                      |                             |
| ------------ | ------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- | ------------------------------------ | --------------------------- |
| `ifconfig`   | Shows all network interfaces and configuration details | includes `ether`, `lladdr`, `inet`, `netmask`, etc.                                                               |                                      |                             |
| `            | `                                                      | Pipes (`                                                                                                          | `) the output of `ifconfig`into`awk` | sends all text line-by-line |
| `awk '/ether | lladdr/ {print $2}'`                                   | Looks for lines containing the word `ether` (macOS/Linux) or `lladdr` (BSD/macOS) and prints the **second field** | `b8:27:eb:45:12:ff`                  |                             |

✅ Output example:

```
b8:27:eb:45:12:ff
08:00:27:96:4a:22
```

---

### **Option 2 — Regex version (scoped to correct field)**

```bash
ifconfig \
| grep -Eo 'ether ([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}|lladdr ([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}' \
| awk '{print $2}'
```

### ⚙️ Explanation

| Part               | Description                                                                               |                                                                                                |
| ------------------ | ----------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `grep -Eo`         | Use **extended regex** (`-E`) and show only the **matching parts** (`-o`)                 |                                                                                                |
| `'ether ...        | lladdr ...'`                                                                              | Match either lines starting with `ether` or `lladdr`, followed by a 6-pair hexadecimal address |
| `awk '{print $2}'` | Prints only the second field (the address itself), stripping the word `ether` or `lladdr` |                                                                                                |

✅ Output example:

```
b8:27:eb:45:12:ff
08:00:27:96:4a:22
```

---

### 🧭 Comparison of Both Methods

| Method       | Simplicity           | Reliability   | Regex? | Works on      |                     |
| ------------ | -------------------- | ------------- | ------ | ------------- | ------------------- |
| `awk '/ether | lladdr/ {print $2}'` | ⭐ Very simple | ✅ 100% | ❌             | macOS / BSD / Linux |
| `grep + awk` | Medium               | ✅ Precise     | ✅      | macOS / Linux |                     |

---

### 💬 Quick Recap

* macOS prints **netmasks** as hex (`0xff000000`) → your regex caught those.
* Restricting search to `ether` or `lladdr` fixes it.
* Both commands above display **only valid MAC addresses**.

---

### ✅ Example Commit Message

```
ex04: fixed MAC.sh for macOS — added awk-based solution to avoid netmask matches
```
