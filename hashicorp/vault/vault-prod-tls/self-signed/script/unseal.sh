#/bin/sh
mkdir -p /vault/operator/
# Setup vault init
vault operator init > /vault/operator/init
# Fetch keys
cat /vault/operator/init | grep Token | awk {'print $4'} >/vault/operator/token
# Fetch token
cat /vault/operator/init | grep Unseal | awk {'print $4'} >/vault/operator/keys
# Unseal vault
for i in $(cat /vault/operator/keys) ;do vault operator unseal $i >/dev/null;done
# Print Unseal Keys and ROOT TOKEN
echo === ROOT TOKEN ===
cat /vault/operator/token
echo === Unseal Keys ===
cat /vault/operator/keys