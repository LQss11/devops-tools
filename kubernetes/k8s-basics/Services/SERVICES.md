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
