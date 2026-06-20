// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimeLockedVault {
    struct Vault {
        uint256 balance;
        uint256 unlockTime;
    }

    mapping(address => Vault) private vaults;

    event Deposited(
        address indexed user,
        uint256 amount,
        uint256 unlockTime
    );

    event Withdrawn(
        address indexed user,
        uint256 amount
    );

    modifier hasBalance() {
        require(vaults[msg.sender].balance > 0, "No funds available");
        _;
    }

    /// @notice Deposit ETH with a lock duration.
    /// @param lockDuration Duration in seconds.
    function deposit(uint256 lockDuration) external payable {
        require(msg.value > 0, "Must send ETH");
        require(lockDuration > 0, "Invalid lock duration");

        Vault storage vault = vaults[msg.sender];

        vault.balance += msg.value;

        uint256 newUnlock = block.timestamp + lockDuration;
        if (newUnlock > vault.unlockTime) {
            vault.unlockTime = newUnlock;
        }

        emit Deposited(msg.sender, msg.value, vault.unlockTime);
    }

    /// @notice Withdraw all locked ETH after unlock time.
    function withdraw() external hasBalance {
        Vault storage vault = vaults[msg.sender];

        require(
            block.timestamp >= vault.unlockTime,
            "Funds are still locked"
        );

        uint256 amount = vault.balance;
        vault.balance = 0;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdrawn(msg.sender, amount);
    }

    /// @notice Returns vault details.
    function getVault(address user)
        external
        view
        returns (uint256 balance, uint256 unlockTime)
    {
        Vault memory vault = vaults[user];
        return (vault.balance, vault.unlockTime);
    }

    /// @notice Returns seconds remaining until withdrawal.
    function timeRemaining(address user)
        external
        view
        returns (uint256)
    {
        if (block.timestamp >= vaults[user].unlockTime) {
            return 0;
        }

        return vaults[user].unlockTime - block.timestamp;
    }

    /// @notice Check if a vault is unlocked.
    function isUnlocked(address user)
        external
        view
        returns (bool)
    {
        return block.timestamp >= vaults[user].unlockTime;
    }

    receive() external payable {
        revert("Use deposit()");
    }

    fallback() external payable {
        revert("Invalid call");
    }
}
