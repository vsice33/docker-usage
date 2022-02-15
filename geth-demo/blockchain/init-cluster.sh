#!/bin/sh
# Geth/v1.10.13-stable-7a0c19f8/linux-amd64/go1.17.3

# 创建签名者账号，需要手动输入密码
docker run --rm -it -v `pwd`/node-1:/data/node ethereum/client-go:stable account new --datadir="/data/node"
docker run --rm -it -v `pwd`/node-2:/data/node ethereum/client-go:stable account new --datadir="/data/node"

# 初始化数据库
docker run --rm -v `pwd`/node-1:/data/node -v `pwd`/conf/genesis.json:/data/conf/genesis.json \
ethereum/client-go:stable init --datadir "/data/node" /data/conf/genesis.json

docker run --rm -v `pwd`/node-2:/data/node -v `pwd`/conf/genesis.json:/data/conf/genesis.json \
ethereum/client-go:stable init --datadir "/data/node" /data/conf/genesis.json
