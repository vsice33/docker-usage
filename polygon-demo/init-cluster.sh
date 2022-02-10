#!/bin/sh

# 初始化节点
docker run --rm -v `pwd`/data/test-chain-1:/data/test-chain 0xpolygon/polygon-sdk secrets init \
--data-dir /data/test-chain
# [SECRETS INIT]
# Public key (address) = 0x7fbc0239AeF6a6C467B2837b692b0C447997aB63
# Node ID              = 16Uiu2HAm6SbUBzao612kd2kkr6DotFD3y94XvMNYA9V46nb3k6kn

docker run --rm -v `pwd`/data/test-chain-2:/data/test-chain 0xpolygon/polygon-sdk secrets init \
--data-dir /data/test-chain
# [SECRETS INIT]
# Public key (address) = 0xCAF8a84B0a24c22E5eED3f52E1c7c0BcAe3FCE67
# Node ID              = 16Uiu2HAmN8mJE8X5XAoTKa1kRacMJitKSx59pnntZ3tvnjSpVjvC

docker run --rm -v `pwd`/data/test-chain-3:/data/test-chain 0xpolygon/polygon-sdk secrets init \
--data-dir /data/test-chain
# [SECRETS INIT]
# Public key (address) = 0xA8f7DE751bbc572055ACd9565aEC09b61E58A006
# Node ID              = 16Uiu2HAm66xWXtZyMsB33TvS1k24wPUnC3BUby33hEjrNkQfnumV

docker run --rm -v `pwd`/data/test-chain-4:/data/test-chain 0xpolygon/polygon-sdk secrets init \
--data-dir /data/test-chain
# [SECRETS INIT]
# Public key (address) = 0x9ABbD6D34849eEf24A90B7c0A499896F542d90c2
# Node ID              = 16Uiu2HAmQWc3tZmrYRNyCEaPLGkTV2VHfFfNUqmPjUtuZFkHiQzZ

# 生成创世块配置文件，节点一、二作为bootnode
docker run --rm -v `pwd`/data/conf:/data/conf -w /data/conf 0xpolygon/polygon-sdk genesis \
--consensus ibft \
--bootnode /ip4/127.0.0.1/tcp/1478/p2p/16Uiu2HAm6SbUBzao612kd2kkr6DotFD3y94XvMNYA9V46nb3k6kn \
--bootnode /ip4/127.0.0.1/tcp/1478/p2p/16Uiu2HAmN8mJE8X5XAoTKa1kRacMJitKSx59pnntZ3tvnjSpVjvC \
--premine=0x7fbc0239AeF6a6C467B2837b692b0C447997aB63:1000000000000000000000 \
--block-gas-limit 1000000000 \
--ibft-validators-prefix-path test-chain
