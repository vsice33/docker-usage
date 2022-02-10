// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract map_demo {
    mapping(address => string) public addr_names;

    constructor() {
        addr_names[msg.sender] = "yekai";
    }

    function setNames(string memory _name) public {
        addr_names[msg.sender] = _name;
    }
}
