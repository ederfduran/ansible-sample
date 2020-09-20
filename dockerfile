FROM ubuntu:latest
RUN apt update -y && apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install python3.8 && apt install -y python3-pip
RUN pip3 install ansible
WORKDIR /ansible-sample
COPY . /ansible-sample
CMD ansible-playbook main.yml \
    && sleep 1000
