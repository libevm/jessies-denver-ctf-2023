// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

interface CTF {
    function write(uint256 i, uint256 v) external;

    function pop() external;

    function flagCaptured() external returns (bool);
}

contract CTFTest is Test {
    CTF ctf;

    function setUp() public {
        address deployed = _deploy(hex"60606040526000357c0100000000000000000000000000000000000000000000000000000000900480632ef05a4f146100525780639c0e3f7a1461007c578063a4ece52c146100a25761004d565b610002565b346100025761006460048050506100b6565b60405180821515815260200191505060405180910390f35b34610002576100a060048080359060200190919080359060200190919050506100d9565b005b34610002576100b46004805050610101565b005b600060006000600160005054905080549150600082141592506100d4565b505090565b80600060005083815481101561000257906000526020600020900160005b50819055505b5050565b60006000508054809190600190039090815481835581811511610156578183600052602060002091820191016101559190610137565b808211156101515760008181506000905550600101610137565b5090565b5b505050505b56");
        ctf = CTF(deployed);
    }

    function _deploy(bytes memory _data) internal returns (address pointer) {
        bytes memory code = abi.encodePacked(
            hex"63",
            uint32(_data.length),
            hex"80_60_0E_60_00_39_60_00_F3",
            _data
        );

        assembly {
            pointer := create(0, add(code, 32), mload(code))
        }
    }

    function testFlagCaptured() public {
        assertTrue(ctf.flagCaptured());
    }
}
