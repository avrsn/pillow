pragma solidity ^0.7.0;
import "hardhat/console.sol";
contract Greeter {

    string greeting;

    constructor(string memory _greeting) {
        greeting = _greeting;
    }

    function greet() public view returns (string memory) {
        //console.log("Begin of greet");
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        greeting = _greeting;
    }

}
