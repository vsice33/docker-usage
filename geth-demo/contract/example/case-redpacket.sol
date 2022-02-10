// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract redpacket {
    address payable public tuhao; // 土豪账户
    uint public number; // 红包数量

    // 构造函数，携带msg.value，必须带payable
    constructor(uint _number) payable {
        tuhao = payable(msg.sender); // 谁创建谁就是土豪
        number = _number; // 指定红包数量
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function stakeMoney() public payable returns(uint) {
        require(number > 0); // 剩余红包必须大于0
        require(getBalance() > 0); // 判断余额大于0

        number--; // 剩余红包数减1
        uint random = uint(keccak256(abi.encode(block.timestamp, msg.sender, "tuhao"))) % 100;
        uint  balance = getBalance();
        uint amount = balance * random / 100;
        payable(msg.sender).transfer(amount); // 打给抢红包的人

        return amount;
    }

    function kill() public {
        require(msg.sender == tuhao);

        selfdestruct(tuhao); // 销毁合约，tuhao为受益人
    }
}
