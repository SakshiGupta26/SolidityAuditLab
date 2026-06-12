// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GiftCard {
    address public owner;

    mapping(address => uint256) public giftCardBalance;

    event GiftCardIssued(address indexed recipient, uint256 amount);
    event GiftCardRedeemed(address indexed recipient, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function issueGiftCard(address recipient, uint256 amount)
        public
        onlyOwner
    {
        require(recipient != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than zero");

        giftCardBalance[recipient] += amount;

        emit GiftCardIssued(recipient, amount);
    }

    function redeemGiftCard(uint256 amount) public {
        require(amount > 0, "Invalid amount");
        require(
            giftCardBalance[msg.sender] >= amount,
            "Insufficient gift card balance"
        );

        giftCardBalance[msg.sender] -= amount;

        emit GiftCardRedeemed(msg.sender, amount);
    }

    function getBalance(address user) public view returns (uint256) {
        return giftCardBalance[user];
    }
}
