---
title: "reveal"
date: 2024-09-28T00:00:00+02:00
draft: false
difficulty: "Easy"
platform: "CyberDefenders"
tags: ["DFIR", "volatility3"]
---

# Q1: What action did Alex take to integrate the purported time-saving package into the deployment process? (provide the full command)

Review the PowerShell history file:

> `ConsoleHost_history.txt`

Look for commands related to NuGet package installation.

![History](./2024-09-22T22:56:27,889083437+02:00.png)

Identify the full command used to install the package.

---

# Q2: Identify the URL from which the package was downloaded ?

Examine the **web browsing history** on the system.

![Url](./2024-10-13T18_19_20,030404275+02_00.png)

Locate the URL used to download the NuGet package.

---

# Q3: Who is the threat actor responsible for publishing the malicious package? (the name of the package publisher)

Visit the NuGet package page and review its metadata.

![Author](./2024-09-22T22:50:36,269150422+02:00.png)

Identify the **package author/publisher**.

---

# Q4: When did the attacker initiate the download of the package? Provide the timestamp in UTC format (YYYY-MM-DD HH:MM)

Analyze **Shellbags artifacts** to determine folder access activity.

![Shellbags](./2024-09-22T23:31:12,279787801+02:00.png)

Extract the timestamp and convert it to **UTC**.

---

# Q5: Despite restrictions, the attacker successfully uploaded the malicious file to the official site by altering one key detail. What is the modified package ID of the malicious package?

Inspect the package contents and locate the **`.nuspec`** file.

![Nuspec](./2024-09-23T11:24:44,751570569+02:00.png)

Identify the **modified package ID** defined within.

---

# Q6: Which deceptive technique did the attacker employ during the initial access phase to manipulate user perception? (technique name)

Analyze the package naming convention.

A slight modification (e.g., removing a single character) was used to mimic a legitimate package.

> **Technique:** Typosquatting

---

# Q7: Determine the full path of the file within the package containing the malicious code ?

Navigate to the default NuGet package installation directory.

![Path](./assets/2024-09-22T23:04:04,348522189+02:00.png)

Locate the file (e.g., `init.ps1`) containing the malicious code and record its **full path**.

---

# Q8: When tampering with the system's security settings, what command did the attacker employ?

Inspect the contents of the malicious script (e.g., `init.ps1`).

![Tampering](./2024-10-13T18_27_20,217521588+02_00.png)

Identify the command(s) used to modify or disable security settings.

---

# Q9: Following the security settings alteration, the attacker downloaded a malicious file to ensure continued access to the system. Provide the SHA1 hash of this file

Analyze the script to identify the downloaded file (e.g., `uninstall.exe`).

Search for this file in forensic tools such as **Autopsy** or security logs.

Check **Windows Defender MP logs** for the SHA1 hash.

![MPLog](./2024-09-23T23:34:33,655079928+02:00.png)

---

# Q10: Identify the framework utilised by the malicious file for command and control communication.

Analyze the malicious binary using:

- Static analysis tools
- Threat intelligence platforms (e.g., VirusTotal)

Identify the **C2 framework** used by the malware.

---

# Q11: At what precise moment was the malicious file executed?

Analyze **Prefetch files** using tools such as:

- **PECmd**
- **Timeline Explorer**

Export the timeline and search for the execution of the malicious binary (e.g., `uninstall.exe`).

![PECmd](./2024-09-23T16:18:53,985898322+02:00.png)

![Timeline](./2024-09-23T16:18:58,652206989+02:00.png)

---

# Q12: The attacker made a mistake and didn’t stop all the features of the security measures on the machine. When was the malicious file detected? Provide the timestamp in UTC.

Check **Windows Defender Operational logs** for:

> **Event ID 1117**

Search for references to the malicious file.

![Evtx](./2024-09-23T16:40:54,982953179+02:00.png)

Extract and convert the timestamp to **UTC**.

---

# Q13: After establishing a connection with the C2 server, what was the first action taken by the attacker to enumerate the environment? Provide the name of the process.

Review the **Prefetch timeline**.

Identify processes executed shortly after the malicious binary.

![Whoami](./2024-10-16T21_20_15,299323062+02_00.png)

The enumeration command can be identified from this sequence.

---

# Q14: To ensure continued access to the compromised machine, the attacker created a scheduled task. What is the name of the created task?

Navigate to:

> `C:\Windows\System32\Tasks`

Look for unusual or suspicious scheduled tasks.

Identify the malicious task name.

---

# Q15: When was the scheduled task created? Provide the timestamp in UTC.

Open the corresponding task **XML file**.

![Task](./2024-09-23T17:59:10,444476816+02:00.png)

Locate the creation timestamp and convert it to **UTC**.

---

# Q16: Upon concluding the intrusion, the attacker left behind a specific file on the compromised host. What is the name of this file?

Search for unusual executables on disk (e.g., in `C:\ProgramData`).

Analyze suspicious files using threat intelligence platforms.

![VT](./2024-10-16T21_46_09,571966584+02_00.png)

---

# Q17: As an anti-forensics measure. The threat actor changed the file name after executing it. What is the new file name?

Investigate file renaming activity using:

- Timeline analysis
- File system artifacts (e.g., MFT)

Identify the renamed file.

---

# Q18: Identify the malware family associated with the file mentioned in the previous question (17).

Use threat intelligence sources (e.g., VirusTotal).

Check:

- Detection names
- Community analysis

Identify the most consistent **malware family classification**.

---

# Q19: When was the file dropped onto the system? Provide the timestamp in UTC.

Parse the **Master File Table (MFT)** using tools such as **MFTECmd**.

Load the timeline into **Timeline Explorer** and search for the file (e.g., `Updater.exe`).

![MFT](./2024-10-16T22_15_07,052799708+02_00.png)

Extract the **file creation timestamp** and convert it to **UTC**.

---
