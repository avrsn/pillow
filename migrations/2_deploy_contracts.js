const PillowChecking = artifacts.require("PillowChecking.sol");
const PillowSavings = artifacts.require("PillowSavings.sol");
const Greeting = artifacts.require("Greeting.sol");

module.exports = function (deployer) {
  deployer.deploy(PillowChecking);
  deployer.deploy(PillowSavings);
  deployer.deploy(Greeting);
};