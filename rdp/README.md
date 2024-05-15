# RDP
## Common issues
### CredSSP encryption oracle remediation
In case you get this issue when trying to connect via rdp:
> An authentication error has occured this could be due to CredSSP encryption oracle remediation. 

You can follow these steps:
1. go to windows edit group policy 
2. Local Computer Policy > Computer Configuration > Administrative Templates > System > Credentials Delegation
3. Select Encryption Oracle Remediation and edit
4. Make Enabled
5. Set Protection Level to vulnerable