# Plugin List
| plugin  | utility                          |
| ------- | -------------------------------- |
| [karmada](#karmada) | work on multi cluster kubernetes |

## Commands
### karmada
- **initialize cluster** kubectl karmada init
- join member1
```sh
kubectl karmada --kubeconfig /etc/karmada/karmada-apiserver.config  join member1 --cluster-kubeconfig=$HOME/.kube/config
```
- join member2
```sh
kubectl karmada --kubeconfig /etc/karmada/karmada-apiserver.config  join member2 --cluster-kubeconfig=$HOME/.kube/config2
```
- get clusters `kubectl --kubeconfig /etc/karmada/karmada-apiserver.config get clusters`
- Install CRD `kubectl --kubeconfig /etc/karmada/karmada-apiserver.config apply -f https://raw.githubusercontent.com/karmada-io/karmada/master/samples/guestbook/guestbooks-crd.yaml`
- Apply propagation policy (cluster affinity rule): `kubectl --kubeconfig /etc/karmada/karmada-apiserver.config apply -f https://raw.githubusercontent.com/karmada-io/karmada/master/samples/nginx/propagationpolicy.yaml` 
- Anything you deploy on karmada for example nginx with 7 replica 3 will be deployed on member with less resources and 4 one the one with more resources
- Make sure that the cluster where karmada control plane is always up to date so your clusters will work properly. 