# Ansible
# Containerization
```sh
docker run -it --rm -v ${pwd}/.ssh:/root/.ssh alpine sh -c "apk add openssh-client && ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa"
docker-compose build --parallel
docker-compose -p cac up -d --build
# Scale the number of instances
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
# Facts collection
ansible prod -i inventory/default.yaml  -m ansible.builtin.setup -a "filter=ansible_local"
```
## Dynamic inventory
You can get information about multiple aws ec2 instances directly through ansible using plugins, but first we need to install python and pip and the right python packages also the right configuration.
```sh
# Install pip and python if working on alpine
apk add py3-pip python3
pip install boto3 botocore 

# Get all information about all instances
ansible-inventory -i inventory/dynamic/aws_ec2.yaml --list
# Get a map of instances (in terminal)
ansible-inventory -i inventory/dynamic/aws_ec2.yaml --graph

# Ignore known hosts input
export ANSIBLE_HOST_KEY_CHECKING=False
# Run a playbook on an inventory (dynamic inventory)
ansible-playbook -i aws_ec2.yaml playbook.yaml
```
# Playbook
```sh
# Run playbook on prod group
ansible-playbook -i inventory/default.yaml playbook/cmd.yaml
```
## Variables
```sh
# From file
ansible-playbook -i inventory/default.yaml -v playbook/variables/demo.yaml -e "@playbook/variables/ref/vars.yaml"
# From CLI
ansible-playbook -i inventory/default.yaml -v playbook/variables/demo.yaml -e "http_port=8080 server_name=myserver"
```
# Roles
[ansible galaxy](https://galaxy.ansible.com/)
```sh
ansible-galaxy role init apache --init-path ./roles
# OR
ansible-galaxy role init cleaner
# you can create requirements.yaml containing roles and collections
ansible-galaxy role install -p ./roles -r roles/requirements.yaml
ansible-galaxy collection install -p ./roles -r roles/requirements.yaml
```

# Ansible vault
In case we have playbooks containing sensetive variables we can encrypt them using ansible vault command:
```sh
# This will ask you for a password and will encrypt the file
# In this example password is 0000
ansible-vault encrypt inventory/vault.yaml
# This will get the encrypted file using the password used for encryption
ansible-vault view inventory/vault.yaml
# Update vault password
ansible-vault rekey inventory/vault.yaml
# Decrypt the file to the original format
ansible-vault decrypt inventory/vault.yaml


# Ansible vault using ansible playbook
ansible -i inventory/vault.yaml all -m ping --ask-vault-pass
ansible-playbook -i inventory/vault.yaml --ask-vault-pass
```

# References and More
- [Facts variables](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_vars_facts.html)