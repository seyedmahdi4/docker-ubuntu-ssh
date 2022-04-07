# docker-ubuntu-ssh
up and running ubuntu container with sshd and ip
this is very useful for test and learn configuration as code like ansible

![alt text](https://github.com/seyedmahdi4/docker-ubuntu-ssh/blob/main/image.png)

- this script use your id_rsa.pub in $HOME/.ssh/id_rsa.pub
- you can put your public key in this dir and script use it
- you can destroy all with ```docker-compose down ```
- ips save in ```hosts.ini```
- username and password is ```ubuntu```
- you can run command with sudo and it's doesn't need password

## Installation
```sh
git clone https://github.com/seyedmahdi4/docker-ubuntu-ssh
cd docker-ubuntu-ssh
chmod +x deploy.sh
./deploy.sh
```

#### example
```sh
ssh ubuntu@10.21.21.2
```

#### automate run example for 2 instance
```sh
echo 2 | ./deploy.sh
```
