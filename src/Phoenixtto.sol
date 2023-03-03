pragma solidity 0.8.17;


/**
    @author Rotcivegaf <victorfage@gmail.com>

    @dev Within the world of crossovers there is a special one, where the universes of pokemon,
        harry potter and solidity intertwine.
        In this crossover a mix creature is created between dumbledore's phoenix, a wild ditto and
        since we are in the solidity universe this creature is a contract.
        We have called it Phoenixtto and it has two important abilities, that of being reborn from
        it's ashes after its destruction and that of copying the behavior of another bytecode
        Try to capture the Phoenixtto, if you can...
*/
contract Laboratory {
    address public getImplementation;
    address public addr;

    function mergePhoenixDitto() external {
        reBorn(type(Phoenixtto).creationCode);
    }

    function reBorn(bytes memory _code) public {
        address x;
        assembly {
            x := create(0, add(0x20, _code), mload(_code))
        }
        getImplementation = x;

        _code = hex"5860208158601c335a63aaf10f428752fa158151803b80938091923cf3";
        assembly {
            x := create2(0, add(_code, 0x20), mload(_code), 0)
        }
        addr = x;
        Phoenixtto(x).reBorn();
    }

    function isCaught() external view returns(bool) {
        return Phoenixtto(addr).owner() == msg.sender;
    }
}

contract Phoenixtto {
    address public owner;
    bool private _isBorn;

    function reBorn() external {
        if (_isBorn) return;

        _isBorn = true;
        owner = address(this);
    }

    function capture(string memory _newOwner) external {
        if (address(this).balance == 0) revert("I don't have balance");
        if (!_isBorn || msg.sender != tx.origin) return;

        address newOwner = address(uint160(uint256(keccak256(abi.encodePacked(_newOwner)))));
        if (newOwner == msg.sender) {
            owner = newOwner;
        } else {
            selfdestruct(payable(msg.sender));
            _isBorn = false;
        }
    }
}
