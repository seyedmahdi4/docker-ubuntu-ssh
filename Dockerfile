FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install required tools.
RUN apt-get -qq update \
    && apt-get -qq --no-install-recommends install sudo=1.8.* \
    && apt-get -qq --no-install-recommends install openssh-server=1:8.* \
    && apt-get -qq --no-install-recommends install iproute2 \
    && apt-get -qq --no-install-recommends install python3 \
    && apt-get -qq clean    \
    && rm -rf /var/lib/apt/lists/* \ 
    && mkdir /var/run/sshd \
    && useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo ubuntu \
    && echo 'ubuntu:ubuntu' | chpasswd

# Configure sudo.
RUN echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && ssh-keygen -A -v

# Generate and configure user keys.
#WORKDIR /home/ubuntu
USER ubuntu
RUN ssh-keygen -A -v
COPY --chown=ubuntu:root "./id_rsa.pub" /home/ubuntu/.ssh/authorized_keys
EXPOSE 22
CMD ["/usr/bin/sudo", "/usr/sbin/sshd", "-D", "-o", "ListenAddress=0.0.0.0"]
