// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract revert_demo {
    address public admin; // 合约管理者
    uint256 public amount;

    constructor() {
        admin = msg.sender; // 部署合约时指定管理员
        amount = 0;
    }

    // 充值功能
    function deposit(uint256 _amount) public payable {
        require(msg.value == _amount, "msg.value must equal _amount");
        assert(_amount > 0);

        amount += _amount;
    }

    function setCount() public onlyadmin {
        amount *= 2;
    }

    modifier onlyadmin() {
        require(admin == msg.sender, "only admin can do this");

        _; // 占位符，表示结束
    }
}
