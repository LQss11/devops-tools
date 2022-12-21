## Namespace
Namespaces Are simply a set of multiple pods that serves something specific which would relate to eachother.

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
You can also set the “namespace” flag when creating the resource:
```sh
kubectl apply -f pod.yaml --namespace=nginx
```
So as you can see the `-n` flag is always valid whenever we want to describe create or get information about any other ressource.