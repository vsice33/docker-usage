// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract bet {
    address public owner; // 管理者
    bool isFinished; // 游戏结束标志

    // 玩家结构信息，可以记录玩家及其下注金额
    struct Player {
        address payable addr;
        uint amount;
    }

    Player[] inBig; // 下大的人
    Player[] inSmall; // 下小的人

    uint totalBig; // 下大的总金额
    uint totalSmall; // 下小的总金额
    uint startTime; // 游戏开始时间

    // 构造函数
    constructor() {
        owner = msg.sender;
        totalSmall = 0;
        totalBig = 0;
        isFinished = false;
        startTime = block.timestamp;
    }

    // 下注，选大或小
    function stake(bool flag) public payable returns(bool) {
        require(msg.value > 0, "please input the amount in value field");

        Player memory player = Player(payable(msg.sender), msg.value);
        if (flag) { // 下大
            inBig.push(player);
            totalBig += player.amount; // 记录下大的总金额，便于后期结算

            return true;
        }

        inSmall.push(player);
        totalSmall += player.amount;

        return true;
    }

    // 开奖，随机取一个值，然后分析是大还是小
    function open() payable public returns(uint) {
        require(block.timestamp > startTime + 20, "the game hasn't started");
        require(!isFinished, "the game is finished");

        isFinished = true; // 只能开奖一次

        // 求一个18以内的随机值，0~8开小，9~17开大
        uint points = uint(keccak256(abi.encode(msg.sender, block.timestamp, block.number))) % 18;
        uint i = 0;

        Player memory player;
        if (points >= 9) { // 开大
            for (i = 0; i < inBig.length; i++) {
                player = inBig[i];
                // 玩家收入 = 下注本金 + 按比例分配的奖金
                player.addr.transfer(player.amount + totalSmall * player.amount / totalBig);
            }
        } else {
            for (i = 0; i < inSmall.length; i++) {
                player = inSmall[i];
                player.addr.transfer(player.amount + totalBig * player.amount / totalSmall);
            }
        }

        return points;
    }
}
