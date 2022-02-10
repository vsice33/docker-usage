// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract localobj {
    address public admin;
    bytes32 public hash;
    uint256 public randnum;

    constructor() {
        admin = msg.sender;
        hash = blockhash(0);
        randnum = uint256(keccak256(abi.encode(block.timestamp, msg.sender, hash))) % 100;
    }
}
