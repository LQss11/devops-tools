# Docker
## Docker desktop
You can use docker desktop to implement docker or even a kubernetes cluster on your machines
| HOST       | DNS                        | PORT |
| ---------- | -------------------------- | ---- |
| kubernetes | kubernetes.docker.internal | 6443 |
| Docker     | host.docker.intenral       | 2375 |

## WSL
In order to install docker with wsl follow these commands:
```sh
wsl --set-default-version 2
# Get list of available online distributions
wsl -l -o 
# install a distribution
wsl --install -d Ubuntu-20

# Get info about installed distributions
wsl --list --verbose
# Select one of the distributions
wsl --set-version Ubuntu-18.04 2

# This will shut them all down
wsl --shutdown

```
If it's requiring an update you can run `wsl --update` or visit this [link](https://www.catalog.update.microsoft.com/Search.aspx?q=wsl) download the msi install it then run `wsl`
## Hyper-V
### Issue with WSL2
Make sure Hyper-V is enabled, (works only on windows-pro) by going to **Turn windows features on or off** -> check **Hyper-V** box

If you chose to enable WSL in the installation you can disable it by updating 
```json
// C:\Users\<username>\AppData\Roaming\Docker\settings.json
{
  "wslEngineEnabled": false // false instead of true
}
```
