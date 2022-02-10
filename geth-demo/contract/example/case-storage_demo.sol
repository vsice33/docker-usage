// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract storage_demo {
    struct User {
        string name;
        uint256 age;
    }

    User public adminUser;

    event setAge(address _owner, uint256 _age); // 定义事件：修改年龄

    constructor() {
        adminUser.name = "yekai";
        adminUser.age = 40;
    }

    // 值传递，adminUser的age不会被修改
    function setAge1(uint256 _age) public {
        User memory user = adminUser;
        user.age = _age;

        emit setAge(msg.sender, _age); // 事件调用
    }

    // 引用传递，adminUser的age会被修改
    function setAge2(uint256 _age) public {
        User storage user = adminUser;
        user.age = _age;

        emit setAge(msg.sender, _age); // 事件调用
    }
}
