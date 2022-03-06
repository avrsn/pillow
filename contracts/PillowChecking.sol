// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "hardhat/console.sol";

contract PillowChecking {
  
  mapping(address => uint) checkingAccounts;
  mapping(address => bool) hasAccount;
  address[] public accountAddresses;

  address pillowSavingsAddress;
  address thisAddress;

  function setThisAddress() public {
    console.log("Begin of setThisAddress");
    thisAddress = msg.sender;
    console.log("End of setThisAddress");
  }

  function getThisAddress() public view returns(address) {
    return thisAddress;
  }

  uint abc;
  string greeting;

  constructor() {
    greeting = "hello";
  }

  function getGreeting() public view returns (string memory) {
    return greeting;
  }

  function setGreeting(string memory theGreeting) public {
    greeting = theGreeting;
  }


  function setPillowSavingsAddress(address _address) external {
    pillowSavingsAddress = _address;
  }
  //new comment
  function getAddress() public view returns (address) {
    address myAddress = address(this);
    return myAddress;
  }

  function getValue() public pure returns (uint) {
    //console.log("I am here.");
    uint value = 5;
    return value;
  }

  function createAccount(uint _savingsGoal) public {
    
    //require(!hasAccount[msg.sender]);
    console.log("Create Account 1");
    hasAccount[msg.sender] = true;
    console.log("Create Account 2");
    accountAddresses.push(msg.sender);
    console.log("Create Account 3");
    PillowSavingsInterface pillowSavingsInstance = PillowSavingsInterface(pillowSavingsAddress);
    console.log("Create Account 4");
    pillowSavingsInstance.createSavingsPlan(msg.sender, _savingsGoal);
    console.log("Create Account 5");
  }

  function deposit() external payable {

    require(hasAccount[msg.sender]);

    if(msg.value < 210000000000000 wei) {
      revert("Must send at least .00021 eth."); //this is approximately 1 USD
    }

    checkingAccounts[msg.sender] += msg.value;

  }

  function withdrawFromChecking(uint withdrawalAmount) private {

    require(hasAccount[msg.sender]);

    //if they are attemping to withdraw more than they currently have in their checking account - revert
    if (withdrawalAmount > checkingAccounts[msg.sender]) {
      revert("You are attempting to withdraw more than the account balance.");
    }

    checkingAccounts[msg.sender] -= withdrawalAmount;
    //send money to users wallet
  }

  function withdrawFromSavings(address _savingsAddr) private {

    require(hasAccount[msg.sender]);

    PillowSavingsInterface pillowSavingsInstance = PillowSavingsInterface(_savingsAddr);
    checkingAccounts[msg.sender] += pillowSavingsInstance.withdraw(msg.sender);

  }

  function balanceFromChecking() public view returns(uint) {

    require(hasAccount[msg.sender]);

    return checkingAccounts[msg.sender];
  }

  function balanceFromSavings(address _savingsAddr) public view returns(uint) {

    require(hasAccount[msg.sender]);

    PillowSavingsInterface pillowSavingsInstance = PillowSavingsInterface(_savingsAddr);
    return pillowSavingsInstance.savingsBalance(msg.sender);

  }

  function transferToSavings(address _savingsAddr, uint _transferAmount) private {

    require(hasAccount[msg.sender]);
    
    if(_transferAmount > checkingAccounts[msg.sender]) {
      revert("You are attempting to transfer more funds than are currently available in the checking account.");
    }

    PillowSavingsInterface pillowSavingsInstance = PillowSavingsInterface(_savingsAddr);

    checkingAccounts[msg.sender] -= _transferAmount;
    pillowSavingsInstance.transferDeposit(msg.sender, _transferAmount);
    //address("0x82h82hf82hf8h").transfer(transferAmount);
    //send the amount to the savings account for this address
  }

}

interface PillowSavingsInterface {
  function transferDeposit(address _msgSender, uint _transferAmount) external;
  function createSavingsPlan(address _msgSender, uint _savingsGoal) external;
  function savingsBalance(address _msgSender) view external returns(uint);
  function withdraw(address _msgSender) external returns(uint);
}