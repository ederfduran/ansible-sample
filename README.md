# ansible-sample

According to Ansible's rules, each sub-folder of each role must have a main.yml file in it, which is how it is able to discover and incorporate the role functionality.

### Note:

You can use following command to pipe you ec2 running instances into your inventory file.

```
aws ec2 describe-instances \
--query 'Reservations[*].Instances[*].PublicIpAddress' \
--filters --region us-east-1 \
--output text >> inventory
```
