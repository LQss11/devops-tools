# Ansible

# Hosts
You can set hosts in **hosts.ini** file where we can have **single domains**, **group of domains** or **nested groups**.

the host file specifies which hosts we want to interact with.
# Inventory

## Commands
### Roles
[ansible galaxy](https://galaxy.ansible.com/)
```sh
ansible-galaxy init apache
# OR
ansible-galaxy role init cleaner
# you can create requirements.yaml containing roles and collections
ansible-galaxy install --roles-path . -r requirements.yaml
ansible-galaxy install -p . -r requirements.yaml
ansible-galaxy role install -p . -r requirements.yaml
ansible-galaxy collection install -p . -r requirements.yaml
```
### Inventory
```sh
# List all hosts
ansible -i inventory/aws.yaml -i inventory/aws2.yaml --list-hosts all
```
```sh
# m stands for modules which will use ping module to check connection with vm
ansible myawsinstance1 -i aws.ini -m ping
ansible myawsinstance1 -i aws.yaml -m ping
```
### Playbooks
```sh
ansible-playbook -i inventory/aws.yaml -v playbook/playbook.yaml
```
#### Variables
```sh
ansible-playbook playbook.yml --extra-vars "@vars.yml"
ansible-playbook playbook.yml -e "http_port=8080 server_name=myserver"

```

## Best practice
- When working with different environment you better work with seperate host files