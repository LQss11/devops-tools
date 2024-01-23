# Kubernetes user
In order to create a kubernetes user we first need the following:

# Cluster certificates:
- ca.crt
- ca.key
Those could be found at **/etc/kubernetes/pki** on the master node of the cluster.

# Create a user
## Using openssl ca cert and key
In this example I am using a docker container containing openssl and kubectl all you need is to put the **ca.cert** and **ca.key** under certs directory:
```sh
docker build -t k8s-user .
# Create new user certs kubeconfig
docker run -it --rm -v ${pwd}:/app -w /app --name k8s-user k8s-user bash -c "./advanced.sh"
# Assign roles
kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods,pods/log,pods/status
# Whole cluster access pod-reader for user john
kubectl create clusterrolebinding john-pod-reader --clusterrole=pod-reader --user="john"
# Role binding per namespace for group dev
kubectl create rolebinding -n default john-pod-reader --clusterrole=pod-reader --group=dev
```
## Using csr k8s resource
The following files are required before running this script:
- **configs/config**: containing authorized user to authentication to the cluster and create and approve certs and create roles
- **certs/ca.crt**: ca certificate of the cluster
```sh
docker build -t k8s-user .
# Create new user certs kubeconfig
docker run -it --rm -v ${pwd}:/app -w /app --name k8s-user k8s-user bash -c "./script.sh"
```


# More
- [Cluster PKIs](https://kubernetes.io/docs/setup/best-practices/certificates/)
- [User CSR requests](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/) 