// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract func_demo2 {
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function deposit() public payable {

    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
