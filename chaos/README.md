# Chaos Engineering 
This is important...

# K8s Chaos engineering example
One of the tools that are cool to use are gremlin or chaos mesh ...
# Chaos mesh
Since chaos mesh is free 

Installation of chaos mesh (default container engine is docker)
```sh
# https://artifacthub.io/packages/helm/chaos-mesh/chaos-mesh?modal=install
helm repo add chaos-mesh https://charts.chaos-mesh.org
helm upgrade --install --create-namespace -n chaos-mesh-system chaos-mesh chaos-mesh/chaos-mesh --version 2.6.3

helm upgrade --install --create-namespace -n chaos-mesh-system chaos-mesh chaos-mesh/chaos-mesh --set chaosDaemon.runtime=containerd --set chaosDaemon.socketPath=/run/containerd/containerd.sock

# Make sure to grant the right roles to chaos mesh service account

# Execute example workflow (https://chaos-mesh.org/docs/create-chaos-mesh-workflow/)
kubectl create -f https://raw.githubusercontent.com/chaos-mesh/chaos-mesh/master/examples/workflow/serial.yaml
```