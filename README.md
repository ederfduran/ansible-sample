# ansible-sample

According to Ansible's rules, each sub-folder of each role must have a main.yml file in it, which is how it is able to discover and incorporate the role functionality.

This Repository contains some basic examples on how to use ansible.

## feature-v0.1

This branch contains a sample of a very basic ansible playbook. it define only one task to print the PATH environment variable and it is executed locally .

### Steps to run

```
cd to/your/repo/folder
ansible-playbook main.yml
```

## feature-v0.2

In this sample code you can see how to use two different roles to install apache2, copy files, and start an apache server. For this particular example you can use a docker container to execute your ansible example.

## Requirements

To execute this example you'll need to have docker client installed.

## Steps To Run

### Build Docker Image

```
 git clone <this repo>
 cd to/ansible-sample/folder
 docker image build -t ansible-sample .
```

### Launch the container

```
docker image ls
# copy your new imageid
docker container run -it -p 8080:80 <imageid>
```

### Confirm it is running

you could got to your browser and visit localhost:8080 or in your console:

```
# in your host machine
curl localhost:8080
```

## feature-v0.3 / develop

This Branch Contains an example on how to deploy a node server using aws EC2 ubuntu instances and CircleCI. This is a representation of a common CD(continuos delivery pipeline). Then Jobs described in `.circleci/config.json` are:

## create_infrastructure

This Job creates an Ec2 ubuntu instance where we're going to put our node server. `template.yml` is the cloudformation template used to make the deployment. Also notice that security group leaves TCP port 3000 open because this is the port where the server will listen. Also we have ssh port open, so we can use ansible provisioning tool. Also you'll need to create a **key-pair** for your instance, in my case key-pair name is **server-devops-key**. For more information on how to create a key pair refer to [docs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html). Make sure that you set the name of your keypair in `Keyname` field on your `template.yml`. This is important.

## add_target_host

This job asks for ip address of the EC2 instance previously created, then we will persists this ip using a file and circleci worksapces [circleci worksapces](https://circleci.com/docs/2.0/configuration-reference/#persist_to_workspace).

## configure_infrastructure

This Job will use ansible to connect to the instance, set our server code located in `roles/setup/files/index.json` and finally start the server. Remember Ansible tasks are described in `roles/setup/tasks`. There are two important requirements to run ansible playbook. the first one is to load from circleci workspace the host ip and set the ip in our `inventory` file. This file will have ips of the server we need to connect to. the second requirement is to add ssh fingerprint to circleci project configuration. for more information on how to add your fingerprint see [docs](https://circleci.com/docs/2.0/add-ssh-key/) . remember to use the **key-pair.pem** you create in previous step to generate the fingerprint. This requirement is for ansible to be connected to your instance.

## smoke_test

This is a simple curl test to you endopint, to verify the server is up and running.

## Rollback

This is not a job but it is an important command named **destroy_environment** used to rollback our CD process whenever it is needed.

### Notes:

1. You can use following command to pipe you ec2 running instances into your inventory file.

```
aws ec2 describe-instances \
--query 'Reservations[*].Instances[*].PublicIpAddress' \
--filters --region us-east-1 \
--output text >> inventory
```
