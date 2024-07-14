#!/bin/bash
sudo apt-get update
sudo apt-get install containerd.io
# Configures IPv4 forwarding and let iptables see bridged traffic:
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

# Disable swap
sudo sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab
sudo swapoff -a
# Install kubelet kubeadm kubectl
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl



# 
# kubeadm init \
#   --apiserver-advertise-address=$MASTER_NODE_IP \
#   --control-plane-endpoint $MASTER_NODE_IP \
#   --pod-network-cidr=$K8S_POD_NETWORK_CIDR \
#   --skip-phases=addon/kube-proxy \
#   --ignore-preflight-errors=NumCPU 