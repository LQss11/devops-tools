# Installations
[Install chocolatey](https://chocolatey.org/install)
```sh
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
A set of tools to install on a new PC:
```sh
choco install grep awk jq yq git flux kubernetes-helm argocd-cli go terraform vault ngrok redis-64 azure-cli awscli python --version 3.12.1 -y
```