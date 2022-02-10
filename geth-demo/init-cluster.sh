#!/bin/sh
# Geth/v1.10.15-unstable-356bbe34/linux-amd64/go1.17.5

# 创建签名者账号，需要手动输入密码
docker run --rm -it -v `pwd`/data/node1:/root/private-chain-node ethereum/client-go account new --datadir="/data/node"
docker run --rm -it -v `pwd`/data/node2:/root/private-chain-node ethereum/client-go account new --datadir="/data/node"

# 初始化数据库
docker run --rm -v `pwd`/data/node1:/data/node -v `pwd`/genesis.json:/data/genesis.json \
ethereum/client-go init --datadir "/data/node" /data/genesis.json

docker run --rm -v `pwd`/data/node2:/data/node -v `pwd`/genesis.json:/data/genesis.json \
ethereum/client-go init --datadir "/data/node" /data/genesis.json
