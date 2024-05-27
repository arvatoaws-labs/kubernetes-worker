FROM ghcr.io/arvatoaws-labs/fedora:40

VOLUME /var/lib/docker

RUN dnf upgrade -y && dnf install -y sed lz4 awscli wget curl kubernetes-client git hub openssh-clients openssl jq awscli bc findutils unzip mariadb redis rsync postgresql screen bind-utils procps nodejs npm traceroute
