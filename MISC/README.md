# Misc
Random stuf, might help.

[Install chocolatey (windows package manager)](https://chocolatey.org/install):
```sh
# Run as admin
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
# Install helm
choco install go
```
# Enable disable adming
```sh
Add-LocalGroupMember -Group Administrator -Member org/user
Get-LocalGroup
Get-LocalGroupMember -Name Administrator
Remove-LocalGroupMember -Group Administrator -Member org/user
```
# Add dns address
```sh
Get-DnsClientServerAddress -InterfaceAlias "Ethernet" | Select-Object -ExpandProperty ServerAddresses
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "8.8.8.8 1.1.1.1"
```

# Connect rdp UI with command
```sh
cmdkey /generic:'10.10.10.10' /user:'windows' /pass:'mypassword123'
mstsc /v:10.10.10.10
```