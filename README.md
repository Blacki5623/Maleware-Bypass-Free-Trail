# Malwarebytes Trial Reset Tool

> **Unlimited 7-Day Trial** – clean, safe, automatic.

This Python script resets the Malwarebytes trial by spoofing the system identity and clearing all trial data. After a reboot, Malwarebytes sees you as a new user and grants you another 7-day trial – over and over, without restrictions.

---

## 🔧 How It Works

* **Backup:** Your current Malwarebytes state is backed up to `%TEMP%\MBResetBackup` (Registry + AppData).  
* **Spoofing:** The Windows MachineGUID is replaced with a random new GUID, preventing Malwarebytes from recognizing the PC.  
* **Cleanup:** All Malwarebytes processes are terminated, and the corresponding registry keys and folders (`%APPDATA%`, `%LOCALAPPDATA%`, `%PROGRAMDATA%`) are deleted.  
* **Reboot:** The PC reboots automatically. After restarting, Malwarebytes opens fresh and offers the 7-day trial.

---

## 🛡️ 100% Clean – Promised

The code is completely transparent. You can verify every single line yourself. It only performs:
* Registry modifications and deletions  
* AppData file removals  
* Process termination  
* A system reboot  

No network activity, no hidden downloads, and no persistent backdoors. If you find everything clean, please leave a star ⭐!

---

## 🚀 How to Use

1. Install Python 3 (if not already installed).  
2. Save the script as `resettrial.py`.  
3. Right-click and select **"Run as Administrator"** (Admin privileges are strictly required).  
4. After the reboot: Open Malwarebytes → Activate the 7-day trial.

---

## 📦 How to Restore

If you want to revert to your old state, execute the `restorebackup()` function included in the code. The backup is stored in `%TEMP%\MBResetBackup`.

---

## ⚠️ Notes

* Only tested on Windows 10/11.  
* Antivirus software might trigger a false positive due to the registry modifications, not because of malicious code. ( Its Safe <3 )  
* Use this strictly for educational purposes or on your own system.
