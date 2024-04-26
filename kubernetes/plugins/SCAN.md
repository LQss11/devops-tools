# Plugin List
| plugin                        | utility                                                                   |
| ----------------------------- | ------------------------------------------------------------------------- |
| [datree](#datree)             | Get information about all deployed resources in cluster + recommendations |
| [deprecations](#deprecations) | Scan deprecated resources/apis                                            |
| [doctor](#doctor)             | Scan kubernetes anomalies                                                 |

## Commands
### datree
- datree must also be installed along with the plugin run this `curl https://raw.githubusercontent.com/datreeio/datree/main/install.sh | /bin/bash`
- Disable online checks since datree is deprecated/retired `datree config set offline local`
- Scan whole cluster with this `kubectl datree test` or scan manifest with `datree test deployment.yaml`
### deprecations
- kubectl deprecations --k8s-version=v1.23.13
### doctor
- detect anomalies for example unclaimed pvs or orphaned endpoints! or unhealthy endpoints
- this plugin not stable enough but ok you might need to run from release not from krew install