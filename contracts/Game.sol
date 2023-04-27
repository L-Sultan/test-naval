// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;



// Uncomment this line to use console.log
// import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Game { 

using Counters for Counters.Counter;
Counters.Counter triesCounter;

enum Name {
    CARRIER,
    BATTLESHIP,
    CRUISER1,
    CRUISER2,
    DESTROYER
}

enum Kind {
    CARRIER,
    BATTLESHIP,
    CRUISER,
    DESTROYER
}

enum Direction {
    HORIZONTAL,
    VERTICAL
}  

struct Coord {
    uint8 row;
    uint8 col;
}

enum State {
    UNKNOWN,
    MISSED,
    HIT,
    SUNK
}

struct Boat {
    Name name;
    Kind kind;
    Direction direction;
    Coord coord;
    State state;
}

Boat[] public boats;

function placeBoat(
        Boat calldata boat
    ) external {
        require(boat.coord.row < 10 && boat.coord.col < 10, "Invalid coordinates");
    require(boat.direction == Direction.HORIZONTAL || boat.direction == Direction.VERTICAL, "Invalid direction");
    require(boat.kind == Kind.CARRIER || boat.kind == Kind.BATTLESHIP || boat.kind == Kind.CRUISER || boat.kind == Kind.DESTROYER, "Invalid boat kind");

    uint8 boatLength;
    if (boat.kind == Kind.CARRIER) {
        boatLength = 5;
    } else if (boat.kind == Kind.BATTLESHIP) {
        boatLength = 4;
    } else if (boat.kind == Kind.CRUISER) {
        boatLength = 3;
    } else {
        boatLength = 2;
    }

    require(
        (boat.direction == Direction.HORIZONTAL && boat.coord.col + boatLength <= 10) ||
        (boat.direction == Direction.VERTICAL && boat.coord.row + boatLength <= 10),
        "Boat placement out of bounds"
    );

    // Check that the boat doesn't overlap with any existing boats
    for (uint8 i = 0; i < boats.length; i++) {
        Boat storage existingBoat = boats[i];
        for (uint8 j = 0; j < boatLength; j++) {
            Coord memory newCoord = boat.direction == Direction.HORIZONTAL ?
                Coord(boat.coord.row, boat.coord.col + j) :
                Coord(boat.coord.row + j, boat.coord.col);
            if (newCoord.row == existingBoat.coord.row && newCoord.col == existingBoat.coord.col) {
                revert("Boat placement overlaps with an existing boat");
            }
        }
    }

    // Add the boat to the list of boats
    boats.push(boat);
    }

    function showBoat() external returns (Boat memory)  {

        
    }
}