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