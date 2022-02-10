# 查询余额
curl -X POST "http://localhost:8545" \
    -H "Content-Type: application/json" \
    --data '{"jsonrpc":"2.0", "method":"eth_getBalance", "params":["0xe48ddd5902e43b7c5e02c5c12cd71cecf4da4a04", "latest"], "id":1}'
