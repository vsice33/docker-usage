// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract safe_demo {
    using SafeMath for uint256; // 针对uint256类型使用SafeMath
    uint256 amount;

    constructor() {
        amount = amount.add(10); // uint256类型的数据可以调用SafeMath内的方法
    }
}
