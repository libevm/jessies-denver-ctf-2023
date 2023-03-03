// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Bar.sol";

contract BarTest is Test {
    address jessy = makeAddr("jessy");
    Bar public bar;

    uint256 public constant TARGET_BEERS = 69;

    function setUp() public {
        bar = new Bar();

        // buy some beers to kick start the auction
        uint256 cost = bar.beerPrice(3);
        bar.buyBeer{value: cost}(3);
        vm.warp(69);

        vm.deal(jessy, 1 ether);
    }

    function testBuy69Beers() public {
        _preCondition();
        vm.startPrank(jessy);
        // -------------------------------------------
        // Add/Remove logic here. No cheatcodes 👿 

        uint256 cost = bar.beerPrice(TARGET_BEERS);
        bar.buyBeer{value: cost}(TARGET_BEERS);
        // -------------------------------------------
        vm.stopPrank();
        _postCondition();
    }

    function _preCondition() internal {
        assertEq(bar.beers(jessy), 0);
        assertEq(bar.beerPrice(1), 257110087081);
        assertEq(bar.beerPrice(2), 578497695932);
    }

    function _postCondition() internal {
        assertEq(bar.beers(jessy), TARGET_BEERS);
    }
}
