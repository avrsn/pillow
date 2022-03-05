// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract PillowSavings {
  
  struct SavingsPlan {
    uint savingsGoal;
    uint savingsBalance;
  }
  //new comment
  address payable pillowInc = payable(0x4B38016118FDE970e2371740F849840aEc745c7B);

  constructor() {}

  mapping(address => SavingsPlan) savingsAccounts;

  function createSavingsPlan(address _usersAddress, uint _savingsGoal) private {
    savingsAccounts[_usersAddress].savingsGoal = _savingsGoal;
  }

  function savingsBalance(address _usersAddress) view private returns(uint) {
    return savingsAccounts[_usersAddress].savingsBalance;
  }

  function transferDeposit(address _usersAddress, uint _amount) private {
    savingsAccounts[_usersAddress].savingsBalance += _amount;
  }

  function withdraw(address _usersAddress) private returns (uint) {
    //read savingsGoal from PillowSavings.sol, compare with savingsBalance amount, if the savingsBalance is less than the  savingsGoal     then charge a fee of 5%.

    if (savingsAccounts[_usersAddress].savingsGoal > savingsAccounts[_usersAddress].savingsBalance) {
      pillowInc.transfer(savingsAccounts[_usersAddress].savingsBalance * 5/100);
      savingsAccounts[_usersAddress].savingsBalance -= savingsAccounts[_usersAddress].savingsBalance * 5/100;
    }

    uint withdrawalAmount = savingsAccounts[_usersAddress].savingsBalance;
    savingsAccounts[_usersAddress].savingsBalance = 0;

    return withdrawalAmount;

  }
}