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

# 测试
## 1. 转换abi文件
```bash
$ docker run --rm -it -v `pwd`:/go -w /go ethereum/client-go:alltools-latest \
abigen -abi contract/abi/01-calldemo.abi -type calldemo -pkg main -out src/calldemo.go
```

## 2. 部署合约
在"remix"测试节点中部署合约，记录合约地址，如"0x101bb6d1d28154d88AE74fB7FA696Fe7f03feAb6"

## 3. 编译代码
填写部署后的合约地址到"main.go"中，编译代码
```bash
$ vim src/main.go
...
common.HexToAddress("0x101bb6d1d28154d88AE74fB7FA696Fe7f03feAb6")
...
$ docker run --rm -it -v `pwd`:/go -w /go/src golang:latest go mod init calldemo
$ docker run --rm -it -v `pwd`:/go -w /go/src golang:latest go build
```

## 4. 运行
```bash
$ docker run --rm -it -v `pwd`:/go -w /go/src golang:latest ./calldemo
```
