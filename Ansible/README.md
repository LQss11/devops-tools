```sh
ansible-playbook -i 192.168.96.2, -u ansible -k -e ansible_network_os=vyos.vyos.vyos first_playbook.yml
```

```sh
apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible
```

```sh
ansible all -i tests -m ping
```
```sh
ansible-playbook  -i hosts second-playbook.yml --check
```