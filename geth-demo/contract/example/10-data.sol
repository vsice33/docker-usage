// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;
pragma experimental ABIEncoderV2;

struct Bank {
    string name;
    uint256 amount;
}

contract data_demo {
    Bank bank;

    constructor(string memory _name, uint256 _amount) {
        bank.name = _name;
        bank.amount = _amount;
    }

    function getBank() public view returns(Bank memory) {
        return bank;
    }
}

contract call_demo {
    data_demo data;

    constructor(address addr) {
        data = data_demo(addr); // 引用前一合约的数据
    }

    function upgrade(address addr) public {
        data = data_demo(addr);
    }

    // 调用data_demo的getBank()方法
    function getData() public view returns(Bank memory) {
        return data.getBank();
    }
}
