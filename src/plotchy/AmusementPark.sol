//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

//max 200 LoC
contract AmusementPark {

    /*
    The Amusement Park is designed to be navigated however the user wants, meaning there are several permutations available. 
    Each ride is designed to take the user onto another ride, 
    and the user wins the CTF challenge if they can complete each ride and leave the park with a Big Smile :) 
    If the user is able to leave the park without riding each of the rides, that would be an unforeseen vulnerability.
    */

    address payable attacker;
    address parkInstance;
    bool Carousel = false;
    bool BumperCars = false;

    bool public BigSmile = false; // This is the flag for this challenge. Set it to true to win.
    
    constructor() {
        parkInstance = address(this);
    }

    modifier insidePark() {
        require(msg.sender == parkInstance, "Only customers can ride these rides!");
        _;
    }

    modifier rodeAllRides() {
        require(Carousel && BumperCars, "Ride all the rides before leaving!");
        _;
    }

    // START HERE!
    function parkEntrance(bytes calldata ticket) public {
        attacker = payable(msg.sender);
        address(this).call(ticket);
    }

    function _Carousel(bytes calldata ticket) external insidePark {

        bytes memory nextRide;
        for(uint s = ticket.length; s > 0; s--) {
            nextRide = bytes.concat(nextRide, ticket[s-1]);
        }

        Carousel = true;
        address(this).call(nextRide);
        Carousel = false;
    }

    function _BumperCars(bytes calldata blueCar, uint40 redCar, bytes calldata yellowCar) external insidePark {
        bytes memory nextRide;

        require(keccak256(blueCar) == keccak256("blue"));
        require(redCar == uint40(bytes5(bytes.concat("255", "0", "0"))));
        bytes memory crash = abi.encodePacked(blueCar, redCar, yellowCar);

        ( , bytes memory _rainbowCar) = abi.decode(crash, (uint256, bytes));

        nextRide = abi.encodePacked(_rainbowCar);

        BumperCars = true;
        address(this).call(nextRide);
        BumperCars = false;
    }

    // END HERE!
    function _leavePark() external insidePark rodeAllRides {
        BigSmile = true;
    }

    fallback() external {
    }
}