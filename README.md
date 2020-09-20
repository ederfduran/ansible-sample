# ansible-sample

According to Ansible's rules, each sub-folder of each role must have a main.yml file in it, which is how it is able to discover and incorporate the role functionality.

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

### Note(In case you prefer to use remote instances in aws):

You can use following command to pipe you ec2 running instances into your inventory file.

```
aws ec2 describe-instances \
--query 'Reservations[*].Instances[*].PublicIpAddress' \
--filters --region us-east-1 \
--output text >> inventory
```
