// SPDX-License-Identifier: MIT
pragma solidity^0.8.7;

contract auction {
    address payable public seller; // 委托人
    address payable public auctioneer; // 拍卖师
    address payable public buyer; // 记录最高出价者地址，最终的买受人
    uint public auctionAmount; // 最高金额
    uint auctionEndTime; // 拍卖结束时间点
    bool isFinished; // 拍卖结束标志

    constructor(address payable _seller, uint _duration) {
        seller = _seller;
        auctioneer = payable(msg.sender);
        auctionAmount = 0;
        auctionEndTime = _duration + block.timestamp;
        isFinished = false;
    }

    function bid() public payable {
        require(!isFinished, "the auction is finished"); // 竞拍未结束
        require(block.timestamp < auctionEndTime); // 竞拍结束时间点之前
        require(msg.value > auctionAmount); // 出价高于上次竞拍价

        if (auctionAmount > 0 && address(0) != buyer) {
            buyer.transfer(auctionAmount); // 退钱给上一买家
        }

        buyer = payable(msg.sender); // 保留新买家
        auctionAmount = msg.value;
    }

    function auctionEnd() public payable {
        require(block.timestamp >= auctionEndTime); // 超过竞拍时间
        require(!isFinished); // 竞拍未结束

        isFinished = true;
        seller.transfer(auctionAmount); // 给卖家打钱
    }
}
