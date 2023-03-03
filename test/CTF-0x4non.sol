// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/proxy/Clones.sol";
import {HHToken} from "../src/CTF-0x4non.sol";

contract HHTokenTest is Test {
    HHToken token;

    function setUp() public {
        token = HHToken(Clones.clone(address(new HHToken())));

        token.buy{value: 10 ether}();
    }


           function testhack() public {
        address hacker = makeAddr("hacker");
        vm.startPrank(hacker);

    
        
        assertEq(address(token).balance, 0, "ser hacker, drain the contract to win");
    }
    
}