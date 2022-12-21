## Setup minikube
Once the containers starts all you need to do is:

Login as the newly created user (user:minikube | pass:minikube):
```sh
su - minikube
```

then to give it permissions so it wouldn't download minikube image each time:
```sh
sudo chown -R minikube /home/minikube/.minikube; chmod -R u+wrx /home/minikube/.minikube
```
then run:
```sh
minikube start
```

in case there s an error while starting run `minikube delete` then `minikube start`

Now to setup let's say for example minikube dashboard and map it at port 80 (make sure port enabled in the dockerfile mapping):
```sh
nohup kubectl proxy --address='0.0.0.0' --port=80 --disable-filter=true &
minikube dashboard --port='80'
```
once everything is done you can visit this url on your host machine to see that container's minikube dashboard through browser:
```
http://127.0.0.1:30080/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/workloads?namespace=default
```
>As you can see we are going to visit port 30080 which we have already mapped to port 80 as you can refer to through our **docker-compose.yaml** file

## FULL COMMAND
```sh
su - minikube
minikube start
```
```sh
nohup kubectl proxy --address='0.0.0.0' --port=81 --disable-filter=true &
```
```sh
nohup minikube dashboard --port='81' &
```
### Additional info
In case you don't want to download the **preloaded-images-k8s** you will need to:
- add this `'minikube-preload:/home/lqss/.minikube/cache/preloaded-tarball'` in the container volumes definition section in docker-compose and don't forget to initialize the **minikubue-preload** volume.
-  run the following command after logging with the minikube user to give him access to that directory:
```sh
sudo chown -R minikube /home/minikube/.minikube; chmod -R u+wrx /home/minikube/.minikube
```
then start minikube again
```sh
minikube delete &&\
minikube start
```
### Port forwarding
In case you want to see the output in your browser (outside the kubernetes container), you will need to follow these steps:
1. Run your service with a specific **port** (eg. 82)
2. Once the service running and pod created run this command:
```sh
kubectl port-forward svc/service-name <localhost_port>:<specified_port> 
```
>Again make sure to check the port mapping specified for host docker container.