FROM fedora:34

VOLUME /var/lib/docker

RUN dnf upgrade -y && dnf install -y lz4 awscli wget curl kubectl git hub openssh-clients jq awscli bc findutils unzip
