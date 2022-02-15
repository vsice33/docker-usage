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
--ipcdisable \
--pcscdpath "" \
--mine \
--miner.threads 1 \
--http \
--http.addr "0.0.0.0" \
--http.vhosts "*" \
--http.api "eth,net,web3,txpool" \
--http.corsdomain "*" \
console
