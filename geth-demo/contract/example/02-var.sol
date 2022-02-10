// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract vardefine {
    int256 public AuthAge; // 定义作者年龄
    bytes32 public AuthHash; // 定义作者hash值
    string public AuthName; // 定义作者姓名
    uint256 public AuthSal; // 定义作者薪水

    constructor(int256 _age, string memeory _name, uint256 _sal) {
        AuthAge = _age;
        AuthName = _name;
        AuthSal = _sal;
        AuthHash = keccak256(abi.encode(AuthAge, AuthName, AuthSal));
    }
}
