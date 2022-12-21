# Persistance 
In this section, you will find the simple requirements to know about the data persistence in Kubernetes.

So if you are already familiar with docker and docker volumes, you will notice that this follows almost the same approach but with additional configuration.

In order to persist data we first need to create a persistent volume or PV.
```
kubectl get pv # To check all PVs in the cluster
```
Once the PV is created we now have to create a persistent volume claim or PVC.
```
kubectl get pvc # To check all PVCs in the cluster
```

>You will notice that after running `kubectl get pv` the claim field will have a value  

Now that you have created your PV and PVC successfully make sure they share the same `StorageClassName` and are bound.

>A PV of a particular class can only be bound to PVCs requesting that class

Now create some pod and try to associate the created volume to a container, then run to check the volumes added to that container:
```sh
kubectl describe po <pod-name> # Describe pod to get info about volumes
```

>NOTICE: using **hostPath** The mounted data will be mounted on the cluster for example if you are using minikube on docker it will be mapped inside that minikube container or if it's a minikube machine it will be inside that machine...