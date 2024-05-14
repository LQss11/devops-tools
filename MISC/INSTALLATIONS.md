# Installations
[Install chocolatey](https://chocolatey.org/install)
```sh
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
A set of tools to install on a new PC:
```sh
# Install windows tools
choco install -y --force firefox vlc winrar obs-studio screentogif notion messenger googlechrome  discord qbittorrent spotify microsoft-teams
# Install dev tools
choco install -y --force git go redis-64 javaruntime jdk8 postman vscode mobaxterm notepadplusplus make
choco install -y --force python --version 3.12.1
# Install devops tools
choco install -y --force terraform vault kubernetes-helm argocd-cli flux kubectx k9s krew
# Install cloud cli tools
choco install -y --force azure-cli awscli
# Intall linux and misc tools
choco install -y --force grep awk jq yq ngrok 
```