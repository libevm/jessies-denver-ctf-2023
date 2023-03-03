// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {LinearVRGDALib, LinearVRGDAx} from "MultiVRGDAs/lib/LinearVRGDALib.sol";
import {toWadUnsafe} from "solmate/utils/SignedWadMath.sol";

contract Bar {
    using LinearVRGDALib for LinearVRGDAx;

    bytes32 public data;
    mapping(address => uint256) public beers;

    LinearVRGDAx public auction = LinearVRGDALib.createLinearVRGDA(
        1e18,
        0.2e18,
        1e18
    );

    /// @notice Get the cost of n beers
    function beerPrice(uint256 _amount) public view returns (uint256 total) {
        require(_amount < 100, "Bar: too many beers");

        uint256 startTime;
        uint256 beersBought;
        assembly {
            let d := sload(data.slot)
            startTime := shr(128, d)
            beersBought := shl(128, shr(128, d))
        }
        
        uint256 i;
        for (i; i < _amount;) {
            total += auction.getVRGDAPrice(toWadUnsafe(block.timestamp - startTime), beersBought + i);
            unchecked {
                ++i;
            }
        }
    }

    /// @notice Buy n beers
    function buyBeer(uint256 _amount) public payable {
        uint256 total = beerPrice(_amount);
        require(msg.value == total, "Bar: wrong price");
        beers[msg.sender] += _amount;

        uint256 beersBought;
        assembly {
            let d := sload(data.slot)
            beersBought := shl(128, shr(128, d))
        }

        _increaseBeersBought(beersBought + _amount);
    }

    /// @notice Increase the total amount of beers bought, which influences the auction pricing
    function _increaseBeersBought(uint256 _amount) public {
        assembly {
            let d := sload(data.slot)
            d := or(shl(128, shr(128, d)), _amount)
            sstore(data.slot, d)
        }
    }
}
