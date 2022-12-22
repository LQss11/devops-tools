## Replica Sets
Replicasets use key value pairs selectors to link with pods just like services. 
>Its yaml file is a combination of a replicaset and a pod definition.
>>The specification of the pod is now in under parameter called spec inside the replica definition. 

Same as others you can get info about replicasets:
```sh
kubectl describe rs replicaset-name # Get information about the replicaset
```
to delete a replicaset:
```sh
kubectl delete rs replicaset-name # Delete replicaset
```
also we can run a replicaset definition just like running pods and services files with `kubectl apply -f file.yaml`

>Once the replicaset is linked to a pod and everything is running properly, If a pod gets deleted or inturrupted in any way the **replicaset** will try to replace the pod with another one without affecting the user experience.
>>It would be better to specify a number of replicas higher than 1 to make sure service always up and running but make sure you know what you are doing because that might be unnecessary in some cases.