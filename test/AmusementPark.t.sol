// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/plotchy/Setup.sol";

contract AmusementParkTest is Test {
    Setup setup;
    AmusementPark public amusementpark;

    function setUp() public {
        setup = new Setup();
        amusementpark = AmusementPark(setup.instance());
    }

    function testSolve() public {
        /*
        Add exploit here

        */
        assertEq(setup.isSolved(), true);
    }
}
