FROM python:3.11.13

RUN wget https://dist.ipfs.tech/kubo/v0.39.0/kubo_v0.39.0_linux-amd64.tar.gz

RUN tar -xvzf kubo_v0.39.0_linux-amd64.tar.gz && cd kubo && bash install.sh

RUN ipfs config --json Experimental.Libp2pStreamMounting true

RUN pip install ipfs-toolkit

RUN git clone https://github.com/Kubuxu/go-ipfs-swarm-key-gen \
    && cd go-ipfs-swarm-key-gen/ipfs-swarm-key-gen/ \
    && go run main.go > /data/ipfs/swarm.key