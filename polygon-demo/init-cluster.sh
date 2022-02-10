#!/bin/sh

# 初始化节点
docker run --rm -v `pwd`/data/test-chain-1:/data/test-chain 0xpolygon/polygon-edge secrets init \
--data-dir /data/test-chain
# [SECRETS INIT]
# Public key (address) = 0x0b926028F11143945E70cc7f1628e638c5a18Ae5
# Node ID              = 16Uiu2HAm96NQJqF2CGWSAxG6zJfv99hBW5psDc53gMYbQrrT5kuu

docker run --rm -v `pwd`/data/test-chain-2:/data/test-chain 0xpolygon/polygon-edge secrets init \
--data-dir /data/test-chain
# [SECRETS INIT]
# Public key (address) = 0x8245Cf34af8ca870948B63D95c95850488fF3bb9
# Node ID              = 16Uiu2HAkxp53dqh9EPeXygJU75KmhZwyh4DCii5c7GFRRvHLtTmf

docker run --rm -v `pwd`/data/test-chain-3:/data/test-chain 0xpolygon/polygon-edge secrets init \
--data-dir /data/test-chain
# [SECRETS INIT]
# Public key (address) = 0xeD3f7f83Ce37C215C5433e33fd8348eabA15Ba10
# Node ID              = 16Uiu2HAmN3m5mZ66zmPGNZTGJiZZQaJ4PvUk45r52Shc59SWy2WP

docker run --rm -v `pwd`/data/test-chain-4:/data/test-chain 0xpolygon/polygon-edge secrets init \
--data-dir /data/test-chain
# [SECRETS INIT]
# Public key (address) = 0xd7756ef9aB61f616CD9d08530b03162044188501
# Node ID              = 16Uiu2HAmLupyno1DNccQmsd9Hh6eJA6nhsiqdmBGZu6kR1SdSaaS

# 生成创世块配置文件，节点一、二作为bootnode
docker run --rm -v `pwd`/data/conf:/data/conf -w /data/conf 0xpolygon/polygon-edge genesis \
--consensus ibft \
--bootnode /ip4/127.0.0.1/tcp/1478/p2p/16Uiu2HAm96NQJqF2CGWSAxG6zJfv99hBW5psDc53gMYbQrrT5kuu \
--bootnode /ip4/127.0.0.1/tcp/1478/p2p/16Uiu2HAkxp53dqh9EPeXygJU75KmhZwyh4DCii5c7GFRRvHLtTmf \
--premine=0x7fbc0239AeF6a6C467B2837b692b0C447997aB63:1000000000000000000000 \
--block-gas-limit 1000000000 \
--ibft-validators-prefix-path test-chain
