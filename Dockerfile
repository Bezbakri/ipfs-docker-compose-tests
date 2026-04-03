FROM python:3.11.13

RUN wget https://dist.ipfs.tech/kubo/v0.39.0/kubo_v0.39.0_linux-amd64.tar.gz

RUN tar -xvzf kubo_v0.39.0_linux-amd64.tar.gz && cd kubo && bash install.sh

RUN ipfs init

RUN apt-get update && apt-get install -y \
curl make git golang

RUN  go version

RUN git clone https://github.com/ipfs-cluster/ipfs-cluster.git

RUN cd ipfs-cluster && make build && cp ./cmd/ipfs-cluster-ctl/ipfs-cluster-ctl /bin/ipfs-cluster-ctl

RUN pip install ipfs-toolkit

# RUN git clone https://github.com/Kubuxu/go-ipfs-swarm-key-gen \
#     && cd go-ipfs-swarm-key-gen/ipfs-swarm-key-gen/ \
#     && go run main.go > /data/ipfs/swarm.key