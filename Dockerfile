FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ARG DEB_PORT=amd64

RUN echo "Install general purpose packages" && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        clang \
        cmake \
        curl \
        libssl-dev \
        make \
        pkg-config \
        unzip

# Install protoc
RUN PROTOC_ZIP=protoc-3.14.0-linux-aarch_64.zip && \
    curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/$PROTOC_ZIP && \
    unzip -o $PROTOC_ZIP -d /usr/local bin/protoc && \
    unzip -o $PROTOC_ZIP -d /usr/local 'include/*' && \
    rm -f $PROTOC_ZIP

# Download rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=$PATH:"$HOME/.cargo/env"
