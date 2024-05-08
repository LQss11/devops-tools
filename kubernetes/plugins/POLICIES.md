# Plugin List
| plugin              | utility                                        |
| ------------------- | ---------------------------------------------- |
| [kyverno](#kyverno) | Setup policies for cluster for best pracitices |

## Commands
### kyverno
- Install helm for crds
- helm repo add kyverno https://kyverno.github.io/kyverno/
- helm upgrade --install --create-namespace -n kyverno  kyverno kyverno/kyverno --set grafana.enabled=true
- **expose cleanup metrics server port** kubectl -n kyverno port-forward svc/kyverno-cleanup-controller-metrics 9999:8000
- **expose reports metrics server port** kubectl -n kyverno port-forward svc/kyverno-reports-controller-metrics 8888:8000
