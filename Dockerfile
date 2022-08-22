FROM ghcr.io/arvatoaws-labs/fedora:36

VOLUME /var/lib/docker

RUN dnf install -y sed

ADD det-arch.sh /usr/local/bin
ADD kubernetes.repo /etc/yum.repos.d/
RUN sed -i "s/x86_64/`det-arch.sh x c`/" /etc/yum.repos.d/kubernetes.repo

RUN dnf upgrade -y && dnf install -y lz4 awscli wget curl kubectl git hub openssh-clients jq awscli bc findutils unzip mariadb redis rsync postgresql
