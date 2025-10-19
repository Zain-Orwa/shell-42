Beautiful 😎 — here’s your **final visual version** of
`ex04_peer_explanation.md` 💥
Perfectly formatted for **GitHub dark mode**, styled just like your previous ones (clear dividers, emojis, and color-friendly structure).
Everything is fully updated — Linux, macOS, regex logic, and bonus IP section all in one clean visual file.

---

````markdown
<div align="center">

# ⚙️ **ex04 — `MAC.sh` (Universal Edition)**  
### 🌍 Works on both Linux 🐧 and macOS 🍏  
</div>

---

## 🎯 **Objective**
Display all **MAC addresses** on your machine — one per line.  
You’ll learn how to extract text patterns using:
- `ifconfig` → to show network info  
- `grep` or `awk` → to filter specific values  
- Regex (regular expressions) → to define what a valid MAC looks like  

---

## 💻 **Final Scripts**

### 🐧 Linux Version
```bash
#!/bin/bash
ifconfig | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'
````

### 🍏 macOS Version

```bash
#!/bin/bash
ifconfig | awk '/ether|lladdr/ {print $2}'
```

---

## 🧩 **Command Breakdown**

| Command      | Description                                           |                                                                               |
| ------------ | ----------------------------------------------------- | ----------------------------------------------------------------------------- |
| `ifconfig`   | Prints all interfaces (MACs, IPs, and settings).      |                                                                               |
| `            | `                                                     | Pipe → sends the output to the next command.                                  |
| `grep -o -E` | Extracts only matching text using **extended regex**. |                                                                               |
| `awk '/ether | lladdr/ {print $2}'`                                  | Prints the 2nd field (MAC address) from lines containing “ether” or “lladdr”. |

---

## 🔍 **Regex Explained (Linux Version)**

**Pattern:**

```
([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}
```

| Part                | Meaning                               | Example                   |
| ------------------- | ------------------------------------- | ------------------------- |
| `[[:xdigit:]]`      | Any hexadecimal digit (0–9, a–f, A–F) | `b`, `E`, `9`             |
| `{1,2}`             | Match 1 or 2 characters               | `b8`, `0a`                |
| `:`                 | Literal colon                         | `:`                       |
| `(...)`             | Group pattern                         | Groups one hex pair + `:` |
| `{5}`               | Repeat 5 times                        | For first 5 octets        |
| `[[:xdigit:]]{1,2}` | Last pair (no colon)                  | `ff`                      |

✅ Matches → `b8:27:eb:45:12:ff`
✅ Matches → `08:00:27:96:4a:22`

---

## ⚠️ **Why macOS Needs a Fix**

macOS adds **netmask** and **broadcast** values in hex:

```
netmask 0xff000000 broadcast 0xffffff00
```

These confuse the regex, resulting in false outputs like:

```
ff000000
ffffff00
```

✅ **Fixed Command:**

```bash
ifconfig | awk '/ether|lladdr/ {print $2}'
```

This filters only lines that *start with real MAC identifiers* → `ether` (Linux/macOS) or `lladdr` (BSD).

**Output:**

```
b8:27:eb:45:12:ff
08:00:27:96:4a:22
```

---

## 🧭 **Linux vs macOS Comparison**

| 🖥️ System                         | ✅ Recommended Command | 💬 Notes                                               |                                    |                                   |
| ---------------------------------- | --------------------- | ------------------------------------------------------ | ---------------------------------- | --------------------------------- |
| **Linux (Ubuntu, Debian, Fedora)** | `ifconfig             | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'` | Uses `grep` with regex.            |                                   |
| **macOS (BSD)**                    | `ifconfig             | awk '/ether                                            | lladdr/ {print $2}'`               | Filters safely, no false matches. |
| **FreeBSD / OpenBSD**              | `ifconfig             | awk '/lladdr/ {print $2}'`                             | BSD’s keyword for MAC is `lladdr`. |                                   |

---

## 🧠 **Why `[[:xdigit:]]` instead of `[0-9]`**

| Expression     | Matches                    | Used For                            |
| -------------- | -------------------------- | ----------------------------------- |
| `[0-9]`        | Only digits (0–9)          | IP addresses (`192.168.1.42`)       |
| `[[:xdigit:]]` | Hex digits (0–9, a–f, A–F) | MAC addresses (`b8:27:eb:45:12:ff`) |

### 💡 Why double brackets?

* Outer `[ ]` define a *character class*.
* Inner `[:xdigit:]` is a **POSIX character class name**.
* Writing `[xdigit]` (no colons) would literally match the letters *x, d, i, g, i, t* ❌

✅ Correct → `[[:xdigit:]]`
❌ Wrong → `[xdigit]`

---

## 🌐 **Bonus — Extract IP Addresses**

We can apply the same idea to extract **IPv4 addresses**.

### 🐧 Linux Version

```bash
ifconfig | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'
```

### 🍏 macOS Version

```bash
ifconfig | awk '/inet / {print $2}'
```

| Pattern      | Description              |
| ------------ | ------------------------ |
| `[0-9]{1,3}` | Match 1–3 digits (0–255) |
| `\.`         | Match literal dot        |
| `{3}`        | Repeat pattern 3 times   |
| `[0-9]{1,3}` | Last octet (final group) |

✅ Output Example:

```
127.0.0.1
192.168.1.42
10.0.0.5
```

---

## 📘 **Summary**

| 🧩 Task             | 🐧 Linux                                              | 🍏 macOS                   |                      |
| ------------------- | ----------------------------------------------------- | -------------------------- | -------------------- |
| Show MAC addresses  | `grep -Eo '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'` | `awk '/ether               | lladdr/ {print $2}'` |
| Show IPv4 addresses | `grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'`              | `awk '/inet / {print $2}'` |                      |

---

## 💬 **Peer Insight**

> This exercise teaches the power of text parsing in Shell:
> how to filter, match, and extract only what matters using regex and pipes.
> You learn to adapt between systems (Linux vs macOS) and understand how **regex patterns change depending on numeric base** — decimal (IP) vs hexadecimal (MAC).

---


```
