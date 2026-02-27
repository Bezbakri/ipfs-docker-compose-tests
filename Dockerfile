FROM ubuntu:22.04

RUN apt-get update && apt-get install -y wget tar

RUN wget https://dist.ipfs.tech/kubo/v0.39.0/kubo_v0.39.0_linux-amd64.tar.gz

RUN tar -xvzf kubo_v0.39.0_linux-amd64.tar.gz && cd kubo && bash install.sh

