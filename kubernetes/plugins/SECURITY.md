# Plugin List
| plugin                  | utility                                            |
| ----------------------- | -------------------------------------------------- |
| [dds](#dds)             | Detect if workloads are mounting the docker socket |
| kubesec-scan            | scan and propose remidiations                      |
| [kubescape](#kubescape) | Scan cluster from vulnerabilities                  |


## Commands
### dds
- datree must also be installed along with the plugin run this `curl https://raw.githubusercontent.com/datreeio/datree/main/install.sh | /bin/bash`
- Disable online checks since datree is deprecated/retired `datree config set offline local`
- Scan whole cluster with this `kubectl datree test` or scan manifest with `datree test deployment.yaml`
### kubescape
- install requirements `kubectl kubescape download artifacts`
- do an overall scan `kubectl kubescape scan`
- collect scan to fix `kubectl kubescape scan --kubeconfig myconfig.yaml --format json --output output.json`
- `kubectl kubescape --kubeconfig myconfig.yaml fix output.json`