// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ReentrancyGuard} from "openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";
import {Address} from "openzeppelin-contracts/contracts/utils/Address.sol";

// The Messi Wrapped Ether
contract HHToken is ERC20("HackerHouseToken", "HHT"), ReentrancyGuard {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function treasuryMint(address to, uint256 amount) external {
        require(msg.sender == owner, "not owner");
        _mint(to, amount);
    }

    function _burnAll() internal {
        _burn(msg.sender, balanceOf(msg.sender));
    }

    function buy() public payable nonReentrant {
        _mint(msg.sender, msg.value);
    }

    function sell(uint256 wad) external nonReentrant {
        Address.sendValue(payable(msg.sender), wad);
        _burn(msg.sender, wad);
    }

    function sellAll() external nonReentrant {
        payable(msg.sender).transfer(balanceOf(msg.sender));
        _burnAll();
    }

    /// @notice Request a flash loan in ETH
    function execute(address receiver, uint256 amount, bytes calldata data) external nonReentrant {
        uint256 prevBalance = address(this).balance;
        Address.functionCallWithValue(receiver, data, amount);
        unchecked {
            require(address(this).balance - prevBalance == 0  , "flash loan not returned");        
        }
    }

    function transferOwnership(address newOwner) public {
        require(msg.sender == owner, "not owner");
        owner = newOwner;
    }

    function transferOwnership(uint8 v, bytes32 r, bytes32 s, bytes32 hash, address newOwner) external {
        address signer = ecrecover(hash, v, r, s);
        require(signer == owner, "not owner");
        owner = newOwner;
    }
}