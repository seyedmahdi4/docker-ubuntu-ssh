# docker-ubuntu-ssh
up and running ubuntu container with sshd and ip

this is very useful for test and learn configuration as code like ansible



- after run script ask you: "how many instanse you need?"
- ips save in ```hosts.ini```
- you can destroy all with ```./unstack.sh ```
- this script default use your id_rsa.pub in $HOME/.ssh/id_rsa.pub
- you can put your public key in this dir and script use it
- username and password is ```ubuntu```
- you can run command with sudo and it's doesn't need password

## Installation
```sh
git clone https://github.com/seyedmahdi4/docker-ubuntu-ssh && cd docker-ubuntu-ssh
chmod +x deploy.sh
./deploy.sh
```

## unstack and down container
```sh
./unstack.sh
```

![alt text](https://github.com/seyedmahdi4/docker-ubuntu-ssh/blob/main/image.png)

#### example to connect
```sh
ssh ubuntu@10.21.21.2
```

#### automate run example for 2 instance
```sh
echo 2 | ./deploy.sh
```
