[toc]

# 初始化
## 1. 加载docker镜像
```bash
$ docker pull ethereum/client-go:stable
```

## 2. 创建账户
- a. 创建相关文件夹
```bash
$ mkdir -p data/node-1
$ mkdir -p data/node-2
```

- b. 执行"init-cluster.sh"中的以下命令，并记录下"Public address"
```bash
$ docker run --rm -it -v `pwd`/data/node-1:/data/node ethereum/client-go:stable account new --datadir="/data/node"
# Public address of the key:   0x45200a99e0e290e0f276E8EBC77b66D7D017a7c9
# Path of the secret key file: /data/node/keystore/UTC--2022-02-11T07-43-09.676650184Z--45200a99e0e290e0f276e8ebc77b66d7d017a7c9
$ docker run --rm -it -v `pwd`/data/node-2:/data/node ethereum/client-go:stable account new --datadir="/data/node"
# Public address of the key:   0xF923c636De5F76Bb40294bb17A2392E3FD65D7a3
# Path of the secret key file: /data/node/keystore/UTC--2022-02-11T07-43-39.349227128Z--f923c636de5f76bb40294bb17a2392e3fd65d7a3
```

- c. 配置创世块文件，分配初始账户
将上述生成的账户地址填写到"genesis.json"的"alloc"部分

- d. 初始化数据库
```bash
$ docker run --rm -v `pwd`/data/node-1:/data/node -v `pwd`/data/conf/genesis.json:/data/conf/genesis.json \
ethereum/client-go:stable init --datadir "/data/node" /data/conf/genesis.json
$ docker run --rm -v `pwd`/data/node-2:/data/node -v `pwd`/data/conf/genesis.json:/data/conf/genesis.json \
ethereum/client-go:stable init --datadir "/data/node" /data/conf/genesis.json
```

# 启动集群
```bash
$ docker-compose up -d
```

# 测试
## 1. 转换abi文件
```bash
$ docker run --rm -it -v `pwd`:/go -w /go ethereum/client-go:alltools-stable \
abigen -abi contract/abi/11-calldemo.abi -type calldemo -pkg main -out src/calldemo.go
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
