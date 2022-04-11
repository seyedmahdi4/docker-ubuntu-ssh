# ubuntu docker container with ssh


###### this is very useful for test and learn configuration as code like ansible



- after run script ask you: "how many instanse you need?"
- ips save in ```hosts.ini```
- you can destroy all with ```./unstack.sh ```
- this script default use your id_rsa.pub in $HOME/.ssh/id_rsa.pub
- you can put your public key in this dir and script use it
- username and password is ```ubuntu```
- you can run command with sudo and it's doesn't need password

## Installation

##### script just work on linux

[run container in window or mac](https://github.com/seyedmahdi4/docker-ubuntu-ssh#use-docker-image-in-mac-and-windows "for window or mac")




```sh
git clone https://github.com/seyedmahdi4/docker-ubuntu-ssh && cd docker-ubuntu-ssh
chmod +x deploy.sh
./deploy.sh
```

## unstack and down container
```sh
./unstack.sh
```

![alt text](https://github.com/seyedmahdi4/docker-ubuntu-ssh/blob/main/image.jpg)

#### example to connect
```sh
ssh ubuntu@10.21.21.2
```

#### automate run example for 2 instance
```sh
echo 2 | ./deploy.sh
```

### use docker image in mac and windows

commnet line 22 in Dockerfile

where ```COPY --chown=ubuntu:root "./id_rsa.pub" /home/ubuntu/.ssh/authorized_keys```

to ```#COPY --chown=ubuntu:root "./id_rsa.pub" /home/ubuntu/.ssh/authorized_keys```

build it:

```docker build -t ssh-ubuntu .```

run it with port forward

```docker run -d --name ubuntu-ssh -p 2222:22 ssh-ubuntu```

and use it :)   

```ssh ubuntu@127.0.0.1 -p 2222```

and password is: ubuntu
