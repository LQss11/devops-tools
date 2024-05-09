# Plugin List
| plugin                        | utility                                                                   |
| ----------------------------- | ------------------------------------------------------------------------- |
| [datree](#datree)             | Get information about all deployed resources in cluster + recommendations |
| [deprecations](#deprecations) | Scan deprecated resources/apis                                            |
| [doctor](#doctor)             | Scan kubernetes anomalies                                                 |
| [flame](#flame)               | run troubleshooting executions to profiling a specific pod with graph     |
| [marvin](#marvin)             | scan cluster  Common Expression Language rules                            |

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
### flame
- profile languages **java** **go** **python** **ruby** **node**
- example: kubectl flame mypod -f /tmp/flame.svg -cpu.requests 100m -cpu.limits 200m -mem.requests 100Mi -mem.limits 200Mi --lang java
**perf_event_open failed: Permission denied** error with happen and profiling won't work if profiling disabled in node first run kubectl get pods -o wide locate where pod exist then run follow this
- WARNING: Kernel symbols are unavailable due to restrictions. Try  echo 0 > /proc/sys/kernel/kptr_restrict  echo 1 > /proc/sys/kernel/perf_event_paranoid
- try following this [link](https://github.com/async-profiler/async-profiler?tab=readme-ov-file#troubleshooting) for more
### marvin
- simple scan plugin with already defined scan definitions
- for advanced use cases you can use zora-plugin with marvin like this [example](https://zora-docs.undistro.io/latest/getting-started/installation/)  