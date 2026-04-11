---
title: "obscure"
date: 2024-09-29T00:00:00+02:00
draft: false
difficulty: "Easy"
platform: "HTB"
category: "Challenges"
tags: ["forensics", "pcap", "php"]
---

# Introduction

We are provided with two files:

- A **PCAP file**
- A **PHP file**

---

# PCAP Analysis

Start by analyzing the PCAP before fully deobfuscating `support.php`.

Filter for **HTTP POST** requests:

![POST](./assets/2024-09-28T23:17:53,862253486+02:00.png)

Only **4 POST requests** are present.

Follow the HTTP streams to inspect the payloads. You will observe obfuscated strings such as:

> `0UlYyJHG87EJqEz66f8af44abea0QKxO/n6DAwXuGEoc5X9/H3HkMXv1Ih75Fx1NdSPRNDPUmHTy351039f4a7b5`

![STREAM](./assets/2024-09-28T23:22:19,040121186+02:00.png)

These strings will be used as input for the PHP deobfuscation.

---

# PHP Analysis

The provided PHP script performs multiple layers of obfuscation:

1. **Pattern extraction** using `$kh` and `$kf`
2. **Base64 decoding**
3. **XOR decryption** using key `80e32263`
4. **Gzip decompression**

To analyze it:

- Execute the script locally or via an online PHP interpreter
- Replace `$input_string` with values extracted from the PCAP

You can:

- Manually replicate each decoding step
- Or automate the process using scripts / tools

---

# Deobfuscation Process

Using the extracted POST data as input:

1. Run it through the PHP function
2. Recover the decoded payload

![Decoded](./assets/2024-09-26T16:53:58,355254103+02:00.png)

3. The output is still encoded — decode it again (e.g., with **CyberChef**):

![Base64](./assets/2024-09-26T16:54:07,295914068+02:00.png)

4. This results in a downloadable file:

![Download](./assets/2024-09-26T16:54:11,809199160+02:00.png)

---

# KeePassXC Analysis

The extracted file is a **KeePass database**.

To recover credentials:

- Use **keepass4brute**
- Use a common wordlist such as **rockyou.txt**

![Bruteforce](./assets/2024-09-26T20:42:23,017970501+02:00.png)

After **21444 attempts**, the correct password is found.

You can now open the database:

![Database](./assets/2024-09-26T20:44:16,536587309+02:00.png)
