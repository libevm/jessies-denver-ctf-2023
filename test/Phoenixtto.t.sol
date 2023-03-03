// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/proxy/Clones.sol";
import {Phoenixtto, Laboratory} from "../src/Phoenixtto.sol";

contract PhoenixttoTest is Test {
    Laboratory lab;

    function setUp() public {
        lab = new Laboratory();
    }

    function testhack() public {
        address hacker = makeAddr("hacker");
        vm.startPrank(hacker);

        // do stuff

        assertEq(lab.isCaught(), true, "ser hacker, drain the contract to win");
    }
}