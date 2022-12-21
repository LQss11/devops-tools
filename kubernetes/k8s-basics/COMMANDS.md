# Kubernetes
This will help us anderstand how to play around with a kubernetes cluster without having to worry much about setting up the env.

To get everything we have in our cluster you could run:
```sh
kubectl get all # Get current info about all services and pods...
```
To run multiple `.yaml` files you can run:
```sh
kubectl apply -f . # Will run all yaml files in current dir
kubectl apply -f file1.yaml -f file2.yaml # We can specify multiple yaml files as well
```
To delete resources created from a file run:
```sh
kubectl delete -f file1.yaml # Will remove all resources specified in file
```
to get the minikube ip address:
```sh
minikube ip # Get minikube address
``` 
>The minikube IP address is the address we are going to need to run the service later from an external machine.
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
kubectl exec -it pod-name -- sh # Execute  command inside pod
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
## Namespaces
Are just simply a set of multiple pods that serves something specific which would relate to eachother.

this will actually allow us to manage the workload more easily.

>If we don't specify a namespace for the ressource we are creating it will be associated with the default namespace.

We can see these namespaces by running:
```sh
kubectl get namespaces # Get all namespaces
kubectl get ns
```
To get all but in different namespaces we can simply specify the name space and then the ressource type or all:
```sh
kubectl get po -n namespace # Get all pods in that namespace
```
you can also get all kubernetes resources by running
```sh
kubectl get pods --all-namespaces # Get all res in all namespaces
```
So as you can see the `-n` flag is always valid whenever we want to describe create or get information about any other ressource.
## Services
We need services to allow us access pods from other machine and make sre pods are always runnning.

The service will need a selector which points at a pods label will in fact connect that service to the pod with same label as selector

Same as running pod files we can run service files by running:
```sh
kubectl apply -f service.yaml # Run service file
```
To get more information about the service:
```sh
kubectl describe service service-name # Get service info
```

>Notice! `type: LoadBalancer` might not be available and only supported by some cloud services

>Notice! `type: ClusterIP` means that service can only be accissible by the clusteer (will not work on external webrowser).
>>good to be used as a microservice or private service (eg. mongodb).

>Notice! `type: NodePort` will make the service accessible from outside.

>Notice! `type: ExternalName`  This service does traffic redirect to services outside of the cluster. As such the service is thus mapped to a DNS name that could be hosted out of your cluster. It is important to note that this does not use proxying.

## Ports
when specifying to map a `nodePort` to the external devices keep in mind that it has to be `greater than 30000`

In case we need a specific port we will need to use ingress service

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
## Deployements
The deployement file configuration, looks the same as replicaset file, just there are few different configurations that we could change in deployements.

Also creating it would be pretty much the same as others with `kubectl apply -f file.yaml`.
>Once we run a deployement it will automatically create a replicaset and within the replicaset it will also generate the specified pods.

>In most cases it would be a better choice to use Deployement instead of just replicasets.
>>Deployements would just make it so simple to update pods with 0 downtime.

as you can see one of the great features of deployements is that it allows you to control versions let's say docker images with different versions:

This could be an example scenario where you could get an idea about what deployements does
1. Create and run first deployement.
1. a replicaset will be created
1. update something on that deployement (eg release of the image used)
1. the old replicaset will still exist but have replicase=0
1. a new replicaset will be created with same number of replicas specified in file.
1. rollback to old replicaset

As you can see this will allow us to have 0 downtime and make it convenient to use deployement rather than just simply replicasets, especially when it comes to updating a running application...

### Deployment Management
Once you run the apply command to update to a newer version, in case there were some errors you can roll back running:
```sh
kubectl rollout status deployement deploy-name # Rollback deployement
kubectl rollout status deploy deploy-name # same as the first one
```
to know the recent rollouts run:
```sh
kubectl rollout history deploy deploy-name # print history of rollouts revisions
```
to rollout to revision:
```sh
kubectl rollout undo deploy deploy-name # Rollout last revision
kubectl rollout undo deploy deploy-name --to-revision=4 # Rollout to a specific revision where 4 is example number of revision.
```