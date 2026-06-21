// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Counter {
    uint256 private count;

    event CountIncremented(uint256 newCount);
    event CountDecremented(uint256 newCount);
    event CountReset();

    function getCount() public view returns (uint256) {
        return count;
    }

    function increment() public {
        count += 1;
        emit CountIncremented(count);
    }

    function decrement() public {
        require(count > 0, "Counter: cannot decrement below zero");
        count -= 1;
        emit CountDecremented(count);
    }

    function reset() public {
        count = 0;
        emit CountReset();
    }
}
