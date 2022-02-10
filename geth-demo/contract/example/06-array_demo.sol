// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract array_demo {
    string[5] public names;
    uint256[] public ages;

    constructor() {
        names[0] = "yekai";
        ages.push(10);
    }

    function getLength() public view returns(uint256, uint256) {
        return (names.length, ages.length);
    }
}
