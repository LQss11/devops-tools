# Terraform
You can run terraform using the cli or run the docker
```sh
# docker-compose
docker-compose up -d
docker exec -i terraform-cli sh -c "terraform init -upgrade"
# Docker
cat >.env <<EOF
ARM_CLIENT_ID=$(CLIENT_ID)
ARM_CLIENT_SECRET=$(CLIENT_SECRET)
ARM_SUBSCRIPTION_ID=$(SUBSCRIPTION_ID)
ARM_TENANT_ID=$(TENANT_ID)
EOF
docker run -d --name terraform-cli --env-file=".env" --entrypoint="" -w="/terraform" -v .:/terraform/staging hashicorp/terraform tail -f /dev/null
```