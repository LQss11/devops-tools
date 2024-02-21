# Commands
Generate a single file containing all chart resources:
```sh
# Get chart values
helm show values chaos-mesh/chaos-mesh >values.yaml
# Create values.yaml template from chart
helm template vault hashicorp/vault --namespace vault --version 0.19.0  > ./vault.yaml
# Another way to get info about upgrade
helm upgrade --install --create-namespace --namespace test  my-release hashicorp/vault --dry-run >./manifests.yaml
# Pull whole chart
helm pull metrics-server/metrics-server  --version 3.12.0
docker run -it --rm -v ${pwd}:/app -w /app alpine sh -c "mkdir -p chart && tar -xzf metrics-server-3.12.0.tgz -C chart"  
```
```sh
# Favorite command full (can use --reuse-values and --reset-values)
helm upgrade --install --create-namespace --namespace test --description="Vault release" my-release hashicorp/vault --set key1=val1,key2=val2 --values values.yaml  
helm list -A
helm uninstall -n test my-release
```
