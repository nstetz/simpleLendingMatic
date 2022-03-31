// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Loan is ERC20, Ownable {
    constructor() ERC20("Loan Coin", "LC"){}
    uint256 public loanTokenAmount;
    uint256 public fee;
    uint256 public collateral;
    uint256 public dueOnLoan;

    function deposit(uint256 amountToDeposit) payable external {
        require(amountToDeposit == msg.value, "incorrect matic amount");
        uint256 amountToMint = amountToDeposit * 50/100;
        _mint(msg.sender, amountToMint);
        loanTokenAmount = amountToMint;
        fee = 10000000000000000;
        collateral = amountToDeposit;
        dueOnLoan = loanTokenAmount + fee;
    }

    function withdraw(uint256 repaymentAmount) payable external {
        require(repaymentAmount == dueOnLoan, "incorrect repayment amount");
        payable(msg.sender).transfer(collateral);
        loanTokenAmount = 0;
        fee = 0;
        collateral = 0;
        dueOnLoan = 0;
    }
}
