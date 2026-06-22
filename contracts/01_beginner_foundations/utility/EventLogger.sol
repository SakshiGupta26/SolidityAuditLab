// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EventLogger {

    // 🔹 Event definition
    event LogEvent(
        address indexed sender,
        string message,
        uint256 timestamp
    );

    // 🔹 Struct for optional storage
    struct Log {
        address sender;
        string message;
        uint256 timestamp;
    }

    Log[] public logs;

    // 🔹 Emit event + store log on-chain
    function createLog(string memory _message) public {
        logs.push(Log({
            sender: msg.sender,
            message: _message,
            timestamp: block.timestamp
        }));

        emit LogEvent(msg.sender, _message, block.timestamp);
    }

    // 🔹 Get total logs
    function getLogsCount() public view returns (uint256) {
        return logs.length;
    }

    // 🔹 Get a specific log
    function getLog(uint256 index) public view returns (address, string memory, uint256) {
        require(index < logs.length, "Index out of range");

        Log memory logEntry = logs[index];
        return (logEntry.sender, logEntry.message, logEntry.timestamp);
    }
}
