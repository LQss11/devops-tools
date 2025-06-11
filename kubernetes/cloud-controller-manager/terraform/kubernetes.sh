#!/bin/bash

set -e
# Avoid interactive prompts
export DEBIAN_FRONTEND=noninteractive

# Update APT packages
apt update
apt upgrade -y

# Disable SWAP (Kubeadm requirement)
swapoff -a
sed -i '/\sswap\s\+sw\s\+/ s/^/# /' /etc/fstab


# Create an empty file for the Containerd module
touch /etc/modules-load.d/containerd.conf
# Configure modules for Containerd
echo -e "overlay\nbr_netfilter" > /etc/modules-load.d/containerd.conf

# Create an empty file for Kubernetes sysctl params
touch /etc/sysctl.d/99-kubernetes-cri.conf

# Configure sysctl params for Kubernetes
echo -e "net.bridge.bridge-nf-call-iptables=1\nnet.ipv4.ip_forward=1\nnet.bridge.bridge-nf-call-ip6tables=1" > /etc/sysctl.d/99-kubernetes-cri.conf


# Load br_netfilter kernel module
modprobe br_netfilter

# Set bridge-nf-call-iptables and ip_forward sysctl params
sysctl -w net.bridge.bridge-nf-call-iptables=1
sysctl -w net.ipv4.ip_forward=1

# Apply sysctl params without reboot
sysctl --system


# Install APT Transport HTTPS
apt install -y apt-transport-https

# Add Docker apt-key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | tee /etc/apt/keyrings/docker-apt-keyring.asc

# Add Docker's APT repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker-apt-keyring.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Add Kubernetes apt-key
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | tee /etc/apt/keyrings/kubernetes-apt-keyring.asc

# Add Kubernetes' APT repository
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.asc] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list

# Update APT packages
apt update

# Install Containerd
apt install -y containerd.io

# Create Containerd directory
mkdir -p /etc/containerd

# Add Containerd configuration
containerd config default > /etc/containerd/config.toml

# Configure the systemd cgroup driver for Containerd
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

# Enable and start the Containerd service
systemctl restart containerd
systemctl enable containerd

# Install Kubelet and Kubeadm
apt install -y kubelet=1.29.* kubeadm=1.29.* kubectl=1.29.*

# Enable the Kubelet service
systemctl enable kubelet

# systemctl restart containerd


# Initialize Kubernetes cluster on master
kubeadm init --pod-network-cidr=10.244.0.0/16



sleep 10

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install flannel cni
kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml

kubectl taint nodes $(hostname) node-role.kubernetes.io/control-plane:NoSchedule-

# Install helm
sudo curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash


kubectl create secret generic azure-cloud-provider --from-file=cloud-config=./cloud.json -n kube-system
helm repo add cloud-provider-azure https://raw.githubusercontent.com/kubernetes-sigs/cloud-provider-azure/master/helm/repo
helm install azure-ccm cloud-provider-azure/cloud-provider-azure \
--set cloud-provider-azure.infra.clusterName="mycluster-tf" \
--set cloud-provider-azure.cloudControllerManager.cloudConfig='' \
--set cloud-provider-azure.cloudControllerManager.cloudConfigSecretName="azure-cloud-provider" \
--set cloud-provider-azure.cloudControllerManager.enableDynamicReloading="true" \
--set cloud-provider-azure.cloudControllerManager.configureCloudRoutes="true" \
--set cloud-provider-azure.cloudControllerManager.allocateNodeCidrs="true" \
--set cloud-provider-azure.cloudControllerManager.imageRepository="mcr.microsoft.com/oss/kubernetes"
# kubectl -n kube-system get pods


# kubectl edit -n kube-system deploy/cloud-controller-manager 

# # - --cloud-config-secret-name=azure-cloud-provider
# # - --cloud-config-key=cloud-config
# # - --cloud-config-secret-namespace=kube-system
# # - --enable-dynamic-reloading

# kubectl logs -f -n kube-system deploy/cloud-controller-manager 


# kubectl create deploy nginx --image nginx:alpine
# kubectl expose deploy/nginx --port 80
# kubectl patch service nginx -p '{"spec": {"type": "LoadBalancer"}}'
