
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
4. [Windows 11 Security Technical Implementation Guide(STIG) V2R4 Database](https://stigaview.com/products/win11/v2r4/)

### Steps Taken

 1. Intentional Windows 11 VM Misconfiguration for Vulnerability Creation & Detection.
    
     - Built a Windows 11 VM and introduced deliberate misconfigurations (firewall disabled, blank passwords, admin/guest privilege misuse, open NSG).
       
     - Validated exposure by pinging the VM and preparing it for vulnerability scanning.

