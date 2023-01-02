# Docker
## Docker desktop
You can use docker desktop to implement docker or even a kubernetes cluster on your machines
| HOST       | DNS                        | PORT |
| ---------- | -------------------------- | ---- |
| kubernetes | kubernetes.docker.internal | 6443 |
| Docker     | host.docker.intenral       | 2375 |

## Issue with WSL2
Make sure Hyper-V is enabled, (works only on windows-pro) by going to **Turn windows features on or off** -> check **Hyper-V** box

If you chose to enable WSL in the installation you can disable it by updating 
```json
// C:\Users\<username>\AppData\Roaming\Docker\settings.json
{
  "wslEngineEnabled": false // false instead of true
}
```