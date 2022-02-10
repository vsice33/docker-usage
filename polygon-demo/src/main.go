package main

import (
	"fmt"
	"log"

	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
)

func main() {
	// 1. 连接到节点
	conn, err := ethclient.Dial("http://localhost:8545")
	if err != nil {
		log.Fatalf("failed to connect to the ethereum client: %v", err)
	}

	// 延迟关闭连接
	defer conn.Close()

	// 2. 生成合约实例，这里需要部署后的合约地址
	demoIns, err := NewCalldemo(common.HexToAddress("0x101bb6d1d28154d88AE74fB7FA696Fe7f03feAb6"), conn)
	if err != nil {
		log.Fatalf("failed to NewCalldemo: %v", err)
	}

	// 3. 调用合约的getCount函数
	val, err := demoIns.GetCount(nil)
	if err != nil {
		log.Fatalf("failed to GetCount: %v", err)
	}

	// 4. 打印执行结果
	fmt.Println(val)
}
