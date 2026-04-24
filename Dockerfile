FROM ghcr.io/arvatoaws-labs/fedora:43

VOLUME /var/lib/docker

RUN dnf upgrade -y && dnf install -y sed lz4 awscli wget curl kubernetes1.34-client git openssh-clients openssl jq awscli bc findutils unzip mariadb redis rsync postgresql screen bind-utils procps nodejs npm traceroute gawk

FROM --platform=$BUILDPLATFORM alpine:latest AS builder

# TARGETARCH is automatically set to 'amd64' or 'arm64'
ARG TARGETARCH
ARG ORAS_VERSION=1.2.0

RUN apk add --no-cache curl tar

# We map Docker's architecture names to ORAS's naming convention
RUN case "${TARGETARCH}" in \
    "amd64")  ARCH="amd64" ;; \
    "arm64")  ARCH="arm64" ;; \
    *) echo "Unsupported architecture: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    curl -LO "https://github.com/oras-project/oras/releases/download/v${ORAS_VERSION}/oras_${ORAS_VERSION}_linux_${ARCH}.tar.gz" && \
    mkdir -p oras-install && \
    tar -zxf oras_${ORAS_VERSION}_linux_${ARCH}.tar.gz -C oras-install && \
    mv oras-install/oras /usr/local/bin/

# Final Stage
FROM alpine:latest
COPY --from=builder /usr/local/bin/oras /usr/local/bin/oras

ENTRYPOINT ["oras"]