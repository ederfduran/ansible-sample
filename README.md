# ansible-sample

According to Ansible's rules, each sub-folder of each role must have a main.yml file in it, which is how it is able to discover and incorporate the role functionality.

This Branch Contains an example on how to deploy a node server using aws EC2 ubuntu instances.

## How to run

```
cd to/your/project/directory
ansible-playbook main-remote.yml -i inventory --private-key <dir/to/your.pem>
```

### Notes:

1. You can use following command to pipe you ec2 running instances into your inventory file.

```
aws ec2 describe-instances \
--query 'Reservations[*].Instances[*].PublicIpAddress' \
--filters --region us-east-1 \
--output text >> inventory
```

2. When you create your instance, make sure to add a tcp rule to leave open port 3000 , as this is where the server will going to listen.
