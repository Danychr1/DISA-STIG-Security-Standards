
<img width="1536" height="1024" alt="ChatGPT Image Jan 5, 2026, 08_50_45 PM" src="https://github.com/user-attachments/assets/5a492a55-6f89-4646-b855-75341d59845c" />


## Defense Information Systems Agency (DISA) – Security Technical Implementation Guides (STIGs)





### Platforms and Languages Leveraged
- Azure-hosted Windows 11 Virtual Machines for environment deployment

- Tenable for vulnerability scanning & compliance reporting

- PowerShell scripting for remediation and configuration management.
  
### Scenario
An internal audit identified multiple compliance failures across Windows 11 systems related to Windows Security Baseline and DISA STIG requirements. I was assigned to remediate the vulnerabilities using automation and validate that the STIG configurations were successfully implemented.

### Discovery
Conducted vulnerability scans on affected Windows 11 virtual machines using Tenable.

Reviewed audit findings to identify failed controls and their associated STIG IDs.

Researched required remediations for each STIG ID to determine corrective actions.

### Tools 

1. Azure & Bastion
2. Windows 11 VM
3. Tenable Nessus: Advanced Network Scan
4. [Windows 11 Security Technical Implementation Guide(STIG) V2R4 Database](https://stigaview.com/products/win11/v2r4/) or use https://www.tenable.com/audits

### Steps Taken

 1. Intentional Windows 11 VM Misconfiguration for Vulnerability Creation & Detection.
    
     - Built a Windows 11 VM and introduced deliberate misconfigurations (firewall disabled, blank passwords, admin/guest privilege misuse, open NSG).
       
     - Validated exposure by pinging the VM and preparing it for vulnerability scanning.

<img width="1617" height="884" alt="Screenshot 2025-12-28 at 11 48 09 AM" src="https://github.com/user-attachments/assets/3e352c9f-1e9f-4a0f-8eac-b708f53cf1b4" />


2. Perform a vulnerability scan in Tenable using the Windows Compliance Checks policy.

   
<img width="1611" height="886" alt="Screenshot 2026-01-05 at 9 14 36 PM" src="https://github.com/user-attachments/assets/170b2e56-5173-410c-a450-3122959c5b1f" />


4. Searched the STIG-ID using Tenable Audits.

    - Searched for STIG-ID within the Tenable Audits database (https://www.tenable.com/audits).
      
<img width="1608" height="893" alt="Screenshot 2025-12-28 at 12 03 43 PM" src="https://github.com/user-attachments/assets/0f0b18a7-73d5-4695-bd2b-3467a0d78b9c" />


4. Researched the solution.
After searching for the specified STIG ID within the Tenable Audit database, the solution to remediate the vulnerability was provided in steps.


Example solution: 
      
  <img width="1544" height="724" alt="Screenshot 2025-12-28 at 12 40 35 PM" src="https://github.com/user-attachments/assets/68dcca58-15e6-4d78-a7ca-4f8c684b0d3b" />


5. Developed a PowerShell remediation script using the STIG Remediation Template.
   - Used the DISA STIGs PowerShell [STIG Remediation Template](https://github.com/Danychr1/DISA-STIG-Security-Standards/blob/main/STIG_Remediation_Template.ps1)


6. Initiated script development by testing and running the code in PowerShell ISE.

   <img width="1275" height="760" alt="Screenshot 2026-01-05 at 10 09 00 PM" src="https://github.com/user-attachments/assets/703a8a73-e815-4285-b1db-37771601c0be" />

7. After validation, I restarted the machine to ensure all changes were fully applied. I then reran the Tenable scan to perform a follow-up compliance audit, confirming that the remediation was successfully implemented.


### Summary

I identified a vulnerability tied to a specific STIG-ID using Tenable, targeting a Windows 11 virtual machine. The scan was run on Local-Scan-Engine-01 using the VM’s private IP and administrative credentials to ensure a thorough assessment. I configured the scan for the appropriate operating system and STIG version (DISA Microsoft Windows 11 STIG v2r4), disabling all plugins except the Windows Compliance Checks (Plugin ID: 24760) to speed up the scan and optimize resources.

Once the compliance failure was identified, I remediated it using a PowerShell script built from the STIG Remediation Template. After execution, I validated the remediation by reviewing the relevant Registry Editor settings, restarting the machine, and rerunning the Tenable scan with the same parameters. The follow-up scan confirmed that the STIG-ID compliance issue was fully resolved.



   
https://github.com/behan101/DISA-STIGs

https://medium.com/@stevenrim/powershell-automation-for-disa-stig-compliance-and-hardening-6515d055d9ef
