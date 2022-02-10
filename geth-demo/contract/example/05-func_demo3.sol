// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract func_demo3 {
    address public admin;
    uint256 public count;

    constructor() {
        admin = msg.sender;
    }

    function setCount(uint256 _count) external {
        count = _count;
    }

    function withdraw() public payable {

    }

    function getCount() public view returns(uint256) {
        return count;
    }
}
