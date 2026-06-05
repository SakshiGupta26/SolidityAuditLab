// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MultiSigLite {

    event TransactionSubmitted(uint txId, address to, uint value);
    event TransactionConfirmed(uint txId, address owner);
    event TransactionExecuted(uint txId);
    event ConfirmationRevoked(uint txId, address owner);
    event OwnerAdded(address owner);
    event OwnerRemoved(address owner);

    address[] public owners;
    uint public requiredConfirmations;

    struct Transaction {
        address to;
        uint value;
        bool executed;
        uint confirmations;
    }

    Transaction[] public transactions;

    mapping(uint => mapping(address => bool)) public usConfirmed;

    function submitTransaction(address _to, uint _value) public{

    }

    function confirmTransaction(uint _txId) public{

    }

    function executeTransaction(uint _txId) public{

    }

    function revokeConfirmation(uint _txId) public{

    }
    
    function addOwner(address _owner) public{

    }

    function removeOwner(address _owner) public{

    }

    function changeRequirement(uint _newRequirement) public{

    }

    function getTransaction(uint _txId) public view returns(
        address to,
        uint value,
        bool executed,
        uint confirmations
    ){

    }
    
    function getOwners() public view returns(address[] memory){

    }

    function getTransactionCount() public view returns (uint){

    }


}
