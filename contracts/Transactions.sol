// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Transactions {
    address payable public owner;
    uint256 public transactionCount;
    uint256 public feeAmount = 0.001 ether;

    event Transfer(
        address from,
        address to,
        uint amount,
        string message,
        uint256 timestamp,
        string keyword
    );

    struct TransferStruct {
        address sender;
        address receiver;
        uint amount;
        string message;
        uint256 timestamp;
        string keyword;
    }

    TransferStruct[] public transactions;

    constructor() {
        owner = payable(msg.sender); // your wallet becomes the fee receiver
    }

    function addToBlockchain(
        address payable _receiver,
        string memory _message,
        string memory _keyword
    ) public payable {
        require(msg.value > feeAmount, "Insufficient ETH for fee and amount");

        uint256 amountToSend = msg.value - feeAmount;

        // Send the ETH minus fee to the receiver
        _receiver.transfer(amountToSend);

        // Send the fee to the contract owner
        owner.transfer(feeAmount);

        transactions.push(
            TransferStruct(
                msg.sender,
                _receiver,
                amountToSend,
                _message,
                block.timestamp,
                _keyword
            )
        );

        transactionCount += 1;

        emit Transfer(
            msg.sender,
            _receiver,
            amountToSend,
            _message,
            block.timestamp,
            _keyword
        );
    }

    function getAllTransactions() public view returns (TransferStruct[] memory) {
        return transactions;
    }

    function getTransactionCount() public view returns (uint256) {
        return transactionCount;
    }
}
