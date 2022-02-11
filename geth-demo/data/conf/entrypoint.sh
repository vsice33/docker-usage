#!/bin/sh

modify date timezone
sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
apk add -U tzdata
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
apk del tzdata

geth \
--datadir /data/node \
--networkid 100 \
--http \
--http.addr "0.0.0.0" \
--http.vhosts "*" \
--http.api "admin,eth,miner,net,txpool,personal,web3" \
--http.corsdomain "*" \
--ipcdisable \
# --bootnodes "enode://04498622fed45e0def7c25c8e704e9027f8b4a796e8e321621afe3b185112982bc733978e956852d683faddd3f3e10689e3732f65118073a7840a0b8117eda48@geth-node1:30303" \
# --bootnodes "enode://8d493488a0966cd824e25c4478c4e6b29e98d2f46fd4e77e288f57521805c105720046564ba0810b882679d56ee61aa8d4b70a0985a440b8f270accb759a6fbd@geth-node2:30303" \
console
