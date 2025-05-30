# 🔐 Security: Cryptography & System Security Framework (KENDRAH-RA1018 Module)

[![Suggestions Welcome](https://img.shields.io/badge/suggestions-welcome-brightgreen)](https://github.com/bcicdis/security/issues)
![Proprietary](https://img.shields.io/badge/license-proprietary-red)
![Owner](https://img.shields.io/badge/owned%20by-Black%20Corp%3A%20Intelligence-black)

**Security** is a cryptographic and system security framework written in **Ada** and **Python**, built as a submodule of the [KENDRAH-RA1018](https://github.com/bcicdis/KENDRAH-RA1018) toolsuite. It is currently in development and intended for **military-grade encryption** and secure data operations.

---

## 🛡️ Overview

The current capabilities include:

- 🟦 **Ada Monitoring Daemon**  
  A background service written in Ada, designed to generate and manage system logs. Will evolve into a real-time event-monitoring tool.

- 🟩 **Python CLI for Encryption/Decryption**  
  Uses **AES-256** to encrypt and decrypt `.txt` files via command-line tools, with utilities abstracted in a modular encryptor library.

- 🟨 **Layered Data Stores**  
  - Plaintext logs (`.txt`)
  - Encrypted files (`.enc`)
  These are strictly separated for clarity and security.

---

## 🔐 Current Capabilities

- AES-256 based symmetric file encryption & decryption
- Ada daemon for generating logs and future monitoring extensions
- Modular structure with encryption logic and utility tools
- Command-line based interface for operator control
- Initial integration with KENDRAH-RA1018 system tools

## Diagram (Current)

```mermaid
flowchart TB
    %% Ada Monitoring Layer
    subgraph "Ada Monitoring" 
        direction TB
        MD_src["Monitor Daemon Source"]:::ada
        MD_build["Daemon Build Config"]:::ada
        MD_artifact["Compiled Daemon & Logs"]:::ada
        MD_src -->|"configured by"| MD_build
        MD_build -->|"builds"| MD_artifact
    end

    %% Data Store for Plain Logs
    DataStore_plain["Plain Logs & Data Store"]:::datastore

    %% Python Encryption CLI Layer
    subgraph "Python Encryption CLI" 
        direction TB
        CLI_encrypt["encrypt.py"]:::python
        CLI_decrypt["decrypt.py"]:::python

        subgraph "Encryptor Library"
            direction TB
            AES["aes_encryptor.py"]:::python
            Utils["utils.py"]:::python
        end

        CLI_encrypt -->|"uses"| AES
        CLI_encrypt -->|"uses"| Utils
        CLI_decrypt -->|"uses"| AES
        CLI_decrypt -->|"uses"| Utils
    end

    %% Encrypted Data Store
    DataStore_enc["Encrypted Files Store"]:::datastore

    %% Operator/Admin
    Admin["Operator/Admin"]:::external

    %% Data Flows
    MD_artifact -->|".txt"| DataStore_plain
    Admin -->|"runs"| CLI_encrypt
    Admin -->|"runs"| CLI_decrypt
    CLI_encrypt -->|".enc"| DataStore_enc
    DataStore_enc -->|".enc"| CLI_decrypt
    DataStore_plain -->|".txt"| CLI_encrypt
    DataStore_plain -->|".txt"| CLI_decrypt

    %% Click Events
    click MD_src "https://github.com/bcicdis/security/blob/main/src/monitor_daemon.adb"
    click MD_build "https://github.com/bcicdis/security/blob/main/default.gpr"
    click MD_artifact "https://github.com/bcicdis/security/tree/main/obj/"
    click CLI_encrypt "https://github.com/bcicdis/security/blob/main/cryptography/military_grade_encryption/encrypt.py"
    click CLI_decrypt "https://github.com/bcicdis/security/blob/main/cryptography/military_grade_encryption/decrypt.py"
    click AES "https://github.com/bcicdis/security/tree/main/cryptography/military_grade_encryption/encryptor/"
    click Utils "https://github.com/bcicdis/security/tree/main/cryptography/military_grade_encryption/encryptor/"
    click DataStore_plain "https://github.com/bcicdis/security/tree/main/cryptography/military_grade_encryption/data/"
    click DataStore_enc "https://github.com/bcicdis/security/tree/main/cryptography/military_grade_encryption/data/"

    %% Styles
    classDef ada fill:#cfe2f3,stroke:#0366d6,color:#000
    classDef python fill:#d9ead3,stroke:#6aa84f,color:#000
    classDef datastore fill:#f9cb9c,stroke:#b45f06,color:#000
    classDef external fill:#eeeeee,stroke:#aaaaaa,color:#000
```


---

## 🧪 How to Use

### 🔧 Encrypt a file:

```bash
python encrypt.py path/to/file.txt
```

### 🔓 Decrypt a file:

```bash
python decrypt.py path/to/file.txt.enc
```

### 🛠 Build the Monitoring Daemon (Ada):

```bash
gprbuild default.gpr
```

---

## 🚧 Roadmap

- [ ] Implement RSA key-pair encryption
- [ ] Add support for secure hashes (e.g., SHA-512, BLAKE3)
- [ ] Real-time system event monitoring
- [ ] Secure and automated key management
- [ ] Web-based management interface
- [ ] Enhanced daemon log analysis module

---

## 🤝 Suggestions & Feedback

Got ideas? Visit the [Issues](https://github.com/bcicdis/security/issues) page or join discussions. Your feedback is welcomed and valued as we iterate on a stronger, more capable system.

---

## 📜 Licensing

> **Note:** This framework is **not open-source**.  
> Licensed under a **proprietary license**.  
> All rights reserved by **Black Corp: Intelligence**.

Unauthorized distribution or reproduction is prohibited.

---

*Part of the [KENDRAH-RA1018](https://github.com/bcicdis/KENDRAH-RA1018) Security Framework Suite.*
