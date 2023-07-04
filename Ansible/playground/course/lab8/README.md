# Dynamic inventory
You can get information about multiple aws ec2 instances directly through ansible using plugins, but first we need to install python and pip and the right python packages also the right configuration.
```sh
# Install pip and python if working on alpine
apk add py3-pip python3
pip install boto3 botocore 

# Get all information about all instances
ansible-inventory -i aws_ec2.yaml --list
# Get a map of instances (in terminal)
ansible-inventory -i aws_ec2.yaml --graph

# Ignore known hosts input
export ANSIBLE_HOST_KEY_CHECKING=False
# Run a playbook on an inventory (dynamic inventory)
ansible-playbook -i aws_ec2.yaml playbook.yaml
```