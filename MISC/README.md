# Misc
Random stuf, might help.

[Install chocolatey (windows package manager)](https://chocolatey.org/install):
```sh
# Run as admin
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
# Install helm
choco install go
```
