# PBI project

## Help
### Service principal
```ps1
Install-Module -Name MicrosoftPowerBIMgmt -Scope CurrentUser
Import-Module MicrosoftPowerBIMgmt
# Now you can run this command user is app id and password is client secret
Connect-PowerBIServiceAccount -Tenant XXXXXXXXXXXXXXXX -ServicePrincipal -Credential (Get-Credential)
Get-PowerBIWorkspace
```
### Service principal
```ps1
# Now you can run this command user is app id and password is client secret
Connect-PowerBIServiceAccount

Get-PowerBIWorkspace
```
Once installed make sure to visit this [website](https://learn.microsoft.com/en-us/powershell/module/microsoftpowerbimgmt.profile/connect-powerbiserviceaccount?view=powerbi-ps) this module will allow us to test our newly created sp