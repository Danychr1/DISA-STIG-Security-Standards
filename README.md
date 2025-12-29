
<img width="685" height="385" alt="Screenshot 2025-12-28 at 11 21 17 AM" src="https://github.com/user-attachments/assets/d55eeb10-4e33-4d86-b7d5-60b298e06a69" />

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

<img width="1618" height="892" alt="Screenshot 2025-12-28 at 11 54 06 AM" src="https://github.com/user-attachments/assets/5db4ca2c-76eb-4892-800e-31e7481915c9" />

3. Searched the STIG-ID using Tenable Audits.

    - Searched for STIG-ID within the Tenable Audits database (https://www.tenable.com/audits).
      
<img width="1608" height="893" alt="Screenshot 2025-12-28 at 12 03 43 PM" src="https://github.com/user-attachments/assets/0f0b18a7-73d5-4695-bd2b-3467a0d78b9c" />


4. Researched the solution.
After searching for the specified STIG ID within the Tenable Audit database, the solution to remediate the vulnerability was provided in steps.


Example solution: 
      
  <img width="1544" height="724" alt="Screenshot 2025-12-28 at 12 40 35 PM" src="https://github.com/user-attachments/assets/68dcca58-15e6-4d78-a7ca-4f8c684b0d3b" />

5. Developed a PowerShell remediation script using the STIG Remediation Template.
   - Used the DISA STIGs PowerShell [STIG Remediation Template](https://github.com/Danychr1/DISA-STIG-Security-Standards/blob/main/STIG_Remediation_Template.ps1)

   

https://github.com/behan101/DISA-STIGs

https://medium.com/@stevenrim/powershell-automation-for-disa-stig-compliance-and-hardening-6515d055d9ef
