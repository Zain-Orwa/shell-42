# 🧩 id_rsa_pub — README

### 🎯 Target  
Understand what SSH is and how to generate and use SSH keys securely.

---

## 🔐 What is SSH?

**SSH (Secure Shell)** is a cryptographic network protocol used to connect securely to remote computers.  
It replaces insecure login methods like Telnet by encrypting all communication between your computer and the remote machine.

SSH uses **asymmetric encryption** — a pair of keys:
- **Private key** → stored safely on your computer.
- **Public key** → shared with servers you want to access.

Only the private key can unlock what’s encrypted by the public key — this ensures identity verification without ever sending your password.

---

## ⚙️ How to Generate an SSH Key Pair

Run the following command in your terminal:

```bash
ssh-keygen -t rsa -b 4096 -C "your.email@example.com"
````

**Explanation:**

* `ssh-keygen` → generates the SSH key pair.
* `-t rsa` → sets the algorithm to RSA.
* `-b 4096` → key length (4096 bits = strong encryption).
* `-C` → adds a comment (usually your email).

Then follow the prompts:

1. Press **Enter** to accept the default path (`~/.ssh/id_rsa`).
2. Choose a **passphrase** for extra security (optional but recommended).

---

## 📁 Where to Find Your Keys

After generation, your keys are stored in:

```
~/.ssh/id_rsa        ← your private key (KEEP SECRET)
~/.ssh/id_rsa.pub    ← your public key (SAFE TO SHARE)
```

You can verify this by running:

```bash
cd ~/.ssh
ls
```

---

## 🧾 Viewing Your Public Key

To display your public key content:

```bash
cat ~/.ssh/id_rsa.pub
```

Copy this line and paste it wherever a public key is required (for example GitHub, remote servers, or your 42 account).

---

## ⚠️ Important Notes

* **Never share** your private key (`id_rsa`).
* The **public key (`id_rsa.pub`)** is meant to be shared.
* If you get a *“Permission denied”* error during SSH connection, fix permissions:

  ```bash
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/id_rsa
  chmod 644 ~/.ssh/id_rsa.pub
  ```
* Always use SSH instead of plain passwords for security.

---

## 🧠 Quick Recap

| Step | Command                                                 | Description                    |
| ---- | ------------------------------------------------------- | ------------------------------ |
| 1    | `ssh-keygen -t rsa -b 4096 -C "your.email@example.com"` | Generate key pair              |
| 2    | `cd ~/.ssh && ls`                                       | Verify files                   |
| 3    | `cat id_rsa.pub`                                        | Show public key                |
| 4    | *(optional)* `ssh-copy-id user@server`                  | Install public key to a server |

---

## 📜 Example Output

```
$ ssh-keygen -t rsa -b 4096 -C "student@42vienna.at"
Generating public/private rsa key pair.
Enter file in which to save the key (/home/student/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Your identification has been saved in /home/student/.ssh/id_rsa
Your public key has been saved in /home/student/.ssh/id_rsa.pub
```

---

## 🏁 Done!

You’ve successfully created your SSH key pair.
Use the public key (`id_rsa.pub`) to connect to remote servers or link your GitHub/42 account securely.

````

################################################################################################
