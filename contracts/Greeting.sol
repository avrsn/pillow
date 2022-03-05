// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Greeting {

    string greeting;

    function getGreeting() public view returns(string memory) {
        return greeting;
    }

    function setGreeting(string memory theGreeting) public {
        greeting = theGreeting;
    }
}