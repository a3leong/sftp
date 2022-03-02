FROM debian:bullseye
MAINTAINER Adrian Dvergsdal [atmoz.net]

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
    apt-get -y install openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key*

COPY files/sshd_config /etc/ssh/sshd_config
COPY files/create-sftp-user /usr/local/bin/
COPY files/entrypoint /

# Create and copy keys early to prevent needing to local bind
COPY keys/ssh_host_rsa_key.pub /home/efe/.ssh/keys/ssh_host_rsa_key.pub
COPY keys/ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
COPY keys/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
