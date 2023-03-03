/*
pragma solidity ^0.4.0;

contract CTF {
    uint256 public ownerSlot = uint256(sha256("jessies.hackerhouse.owner"));
    uint256[] public myArray;

    function write(uint256 i, uint256 v) public {
        myArray[i] = v;
    }

    function pop() public {
        myArray.length--;
    }

    function flagCaptured() public returns (bool) {
        uint256 owner;

        uint256 slot = ownerSlot;
        assembly {
            owner := sload(slot)
        }

        return (msg.sender == address(owner));
    }
}
*/