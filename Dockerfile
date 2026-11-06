FROM ghcr.io/arvatoaws-labs/fedora:45

VOLUME /var/lib/docker

RUN dnf upgrade -y && dnf install -y sed lz4 awscli wget curl kubernetes1.37-client git openssh-clients openssl jq awscli bc findutils unzip mariadb redis rsync postgresql screen bind-utils procps nodejs npm traceroute gawk && dnf clean all