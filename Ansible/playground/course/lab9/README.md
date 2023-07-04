# Ansible vault
In case we have playbooks containing sensetive variables we can encrypt them using ansible vault command:
```sh
# This will ask you for a password and will encrypt the file
# In this example the password is 00000000
ansible-vault encrypt aws.yaml
# This will get the encrypted file using the password used for encryption
ansible-vault view aws.yaml
# Update vault password
ansible-vault rekey aws.yaml
# Decrypt the file to the original format
ansible-vault encrypt aws.yaml


# Ansible vault using ansible playbook
ansible -i aws.yaml all -m ping --ask-vault-pass
ansible-playbook -i aws.yaml --ask-vault-pass
```