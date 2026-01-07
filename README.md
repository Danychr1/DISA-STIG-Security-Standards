
<img width="1536" height="1024" alt="ChatGPT Image Jan 5, 2026, 08_50_45 PM" src="https://github.com/user-attachments/assets/5a492a55-6f89-4646-b855-75341d59845c" />


## DISA STIG Security Standards – Windows 11 Compliance Automation

### Summary

This project automates Windows 11 STIG compliance remediation using Tenable scans and PowerShell scripts. I targeted a lab VM with administrative access, ran a focused STIG audit (DISA Windows 11 STIG v2r4), and remediated any compliance failures using scripts built from the STIG Remediation Template.

After applying each fix, I validated the changes in the Registry, restarted the VM, and reran Tenable scans to confirm compliance. This workflow ensures security baseline enforcement without disrupting system functionality.

### ⚠️ Important Note – Lesson Learned

Not all DISA STIG findings should be applied blindly. Some controls—especially those affecting network access, authentication, virtualization, or smart card enforcement—can lock users out or disrupt operations if applied without testing.

This project follows a risk-based remediation approach, where some findings are marked as Not Applicable (NA), Risk Accepted, or handled with compensating controls to maintain system availability and operational continuity.

### Platforms & Tools

Azure-hosted Windows 11 VMs for lab environments

Tenable Nessus for vulnerability scanning & compliance reporting

PowerShell for remediation scripting & automation

Windows 11 STIG v2r4 Database

### Scenario

An internal audit identified multiple Windows 11 compliance failures related to Windows Security Baseline and DISA STIG requirements. I was tasked with remediating these vulnerabilities safely using automation and validating STIG compliance end-to-end.




    💻 Lab VM Setup
      Deploy Windows 11 VM & test misconfigs
          |
          v
    🔍 Tenable Scan
      Identify compliance failures
          |
          v
    📖 Research STIG-ID
      Find remediation steps
          |
          v
    🛠 PowerShell Scripts
      Build & test remediation
          |
          v
    ✅ Apply Remediation
      Run scripts on VM
          |
          v
    🔎 Validate
      Check registry & policies
          |
          v
    🔄 Rerun Scan
      Confirm STIG compliance
          |
          v
    🏁 Document Results


### Step-by-Step Process

1️⃣ Lab Environment Preparation

Deployed a Windows 11 VM in Azure.

Configured controlled misconfigurations for testing (e.g., disabled firewall, blank passwords, admin/guest privilege misuse).

Validated connectivity to ensure the VM was ready for scanning.

<img width="1617" height="884" alt="Screenshot Lab VM Misconfiguration" src="https://github.com/user-attachments/assets/3e352c9f-1e9f-4a0f-8eac-b708f53cf1b4" /> *Lab VM prepared with controlled misconfigurations for vulnerability testing.*

2️⃣ Vulnerability Scanning

Ran Tenable scans using the Windows Compliance Checks policy to detect STIG compliance failures.

<img width="1610" height="889" alt="Tenable Scan" src="https://github.com/user-attachments/assets/5f3d35a8-4f5b-4e1c-89e5-1371a007e286" /> *Scanning for STIG compliance with Tenable.*

3️⃣ STIG Research & Solution Identification

Searched each STIG-ID in Tenable Audits database.

Reviewed the recommended remediation steps for each failed control.

<img width="1608" height="893" alt="STIG-ID Research" src="https://github.com/user-attachments/assets/0f0b18a7-73d5-4695-bd2b-3467a0d78b9c" /> *Identifying the correct remediation steps for each STIG failure.*

4️⃣ PowerShell Remediation

Developed PowerShell scripts using the STIG Remediation Template
.

Scripts were tested in PowerShell ISE to ensure safe application.

<img width="1219" height="663" alt="Screenshot 2026-01-07 at 10 14 07 AM" src="https://github.com/user-attachments/assets/880e5f70-2ff7-470e-84c0-ab7f6da77889" /> *Testing and validating STIG remediation scripts.*

5️⃣ Validation & Follow-Up

After applying scripts, I reviewed Registry settings to ensure policies were enforced.

Restarted the VM to apply changes fully.

Reran Tenable scans to confirm that all remediated STIGs passed compliance.

<img width="1544" height="724" alt="Remediation Validation" src="https://github.com/user-attachments/assets/68dcca58-15e6-4d78-a7ca-4f8c684b0d3b" /> *Validation confirms STIG compliance.*

<img width="1608" height="880" alt="Screenshot 2026-01-07 at 11 15 48 AM" src="https://github.com/user-attachments/assets/6bd695fa-46ab-4fcc-8ecc-278b578fe930" /> *Test Result.*

#### Key Takeaways

STIG remediation requires risk-based decision-making. Not all controls should be blindly applied.

Automation using PowerShell and templates can streamline compliance while maintaining system availability.

Hands-on experience with Azure, Tenable, and Windows 11 VMs strengthened my understanding of cloud security and vulnerability management.



