## Pods
once you have created your first pod file you can simply run:
```sh 
kubectl apply -f first-pod.yaml # Run pod file
```
to get more information about the running pod
```sh
kubectl describe pod app-name # Get info about pod
```
To get all running pods in cluster:
```sh
kubectl get pods # Get all running pods in cluster
kubectl get po # Same as kubectl get pods
```
in case we want to execute a command inside a running pod
```sh
kubectl exec -it pod-name -- sh # Execute ommand inside pod
```
To know labels from pods
```sh
kubectl get po --show-labels # Will show all running pods that has labels
kubectl get po --show-labels -l key=value # Will show all pods with 'key value' pairs
```
To delete Pods:
```sh
kubectl delete po pod-name # Delete Specific pod
kubectl delete po --all # Delete all running pods
```