# AKS with fargate
```sh
terraform apply -auto-approve
```
Once finished everything should work fine but before deploying we will need to do few things:
```sh
# Get info about cluster
aws eks describe-cluster --region us-east-1 --name eks-demo-cluster-01 --output json
# Create namespace and deploy nginx
kubectl --kubeconfig kubeconfig.yaml apply -f deployment.yaml
## Redeploy coredns (in case no nodes available to schedule pods with taint fargate)
kubectl --kubeconfig kubeconfig.yaml rollout restart -n kube-system deployment/coredns

```
Check nodes `kubectl --kubeconfig .\kubeconfig.yaml get nodes` you will realise you have the same number of nodes as the number of pods

# Fargate namespaces
when creating a deployment like this:
```sh
# Create example ns
kubectl --kubeconfig kubeconfig.yaml create namespace example
# Create nginx deployment in the example ns
kubectl --kubeconfig kubeconfig.yaml -n example create deployment nginx --image nginx:alpine
# Check status of deployment
kubectl --kubeconfig kubeconfig.yaml -n example get all
# pod/nginx-b4ccb96c6-974mh   0/1     Pending   0          53s
# Describe deployment
kubectl --kubeconfig kubeconfig.yaml -n example describe pod/nginx-b4ccb96c6-974mh
#   Warning  FailedScheduling  2m6s  default-scheduler  0/5 nodes are available: 5 node(s) had untolerated taint {eks.amazonaws.com/compute-type: fargate}. preemption: 0/5 nodes are available: 5 Preemption is not helpful for scheduling..
```
>>In order to prevent this you will need to add a new namespace in the fargat profile resource/
# Reference
- [Youtube](https://www.youtube.com/watch?v=oKD0sOsWI6M&ab_channel=Lian)
- [Git](https://gitlab.com/LianDuanTrainingGroup/awseks/-/tree/main/1-11%20EKS%20%2B%20Fargate%20%2B%20Terraform/Code?ref_type=heads)