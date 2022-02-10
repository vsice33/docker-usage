[toc]

# 初始化
## 1. 加载docker镜像
```bash
$ docker pull 0xpolygon/polygon-edge
```

## 2. 创建账户
- a. 创建相关文件夹
```bash
$ mkdir -p data/test-chain-1
$ mkdir -p data/test-chain-2
$ mkdir -p data/test-chain-3
$ mkdir -p data/test-chain-4
```

- b. 执行"init-cluster.sh"中的以下命令，并记录下"Node ID"和"Public key"
```bash
$ docker run --rm -v `pwd`/data/test-chain-1:/data/test-chain 0xpolygon/polygon-edge secrets init \
--data-dir /data/test-chain
$ ...
$ ...
$ ...
$ docker run --rm -v `pwd`/data/test-chain-4:/data/test-chain 0xpolygon/polygon-edge secrets init \
--data-dir /data/test-chain
```

- c. 生成创世块配置文件，节点一、二作为bootnode
```bash
$ docker run --rm -v `pwd`/data/conf:/data/conf -w /data/conf 0xpolygon/polygon-edge genesis \
--consensus ibft \
--bootnode /ip4/127.0.0.1/tcp/1478/p2p/16Uiu2HAm96NQJqF2CGWSAxG6zJfv99hBW5psDc53gMYbQrrT5kuu \
--bootnode /ip4/127.0.0.1/tcp/1478/p2p/16Uiu2HAkxp53dqh9EPeXygJU75KmhZwyh4DCii5c7GFRRvHLtTmf \
--premine=0x7fbc0239AeF6a6C467B2837b692b0C447997aB63:1000000000000000000000 \
--block-gas-limit 1000000000 \
--ibft-validators-prefix-path test-chain
```

- d. 修改"bootnodes"配置
替换"127.0.0.1"为"polygon-node1"和"polygon-node2"，"{}"内填写相应数据
```bash
$ vim ./data/conf/genesis.json
......
"bootnodes": [
        "/ip4/polygon-node1/tcp/1478/p2p/{节点1 node id}",
        "/ip4/polygon-node2/tcp/1478/p2p/{节点2 node id}"
    ]
......
```

# 启动集群
```bash
$ docker-compose up -d
```
