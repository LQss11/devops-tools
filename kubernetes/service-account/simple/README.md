# Simple sa

kubectl delete -f .
kubectl apply -f .
kubectl create token -n kube-system default





export APISERVER="https://xx.xx.xx.xx:6443"


curl -k $APISERVER/api/v1/namespaces/default/pods/ --header "Authorization: Bearer $TOKEN" --cacert ca.pem | jq -rM '.items[].metadata.name'
