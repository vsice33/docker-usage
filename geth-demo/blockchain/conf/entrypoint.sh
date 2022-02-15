#!/bin/sh

# modify date timezone
sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
apk update && apk upgrade
apk add tzdata
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
apk del tzdata

geth \
--datadir /data/node \
--networkid 100 \
--nousb \
--syncmode "full" \
--ipcdisable \
--pcscdpath "" \
--mine \
--miner.threads 1 \
--miner.gasprice 0 \
--miner.etherbase 0x0000000000000000000000000000000000000000 \
--http \
--http.addr "0.0.0.0" \
--http.vhosts "*" \
--http.api "eth,miner,net,txpool,web3" \
--http.corsdomain "*" \
console
