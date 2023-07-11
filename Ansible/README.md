# Ansible
# Containerization
```sh
cd demo
docker-compose build --parallel
docker-compose -p cac up -d --build
docker-compose -p cac scale ansible_worker=3
docker exec -it ansible_controller sh
## SSH Inside docker container 
ssh -o "StrictHostKeyChecking=no" cac_ansible_worker_1
exit
# To stop and delete containers
docker-compose -p cac down -v
```
# Inventory
```sh
# Get all inventory instances
ansible-inventory -i inventory/default.yaml  --graph
# Run ping module on prod group
ansible prod -i inventory/default.yaml -m ping
```

# Playbook
```sh
# Run playbook on prod group
ansible-playbook -i inventory/default.yaml playbook/cmd.yaml
```