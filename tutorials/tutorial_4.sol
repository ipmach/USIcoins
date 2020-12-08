pragma solidity ^0.5.1;

contract MyContract {

    mapping(uint => Person) public people;
    uint256 public peopleCount = 0;
    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    struct Person {
        uint _id;
        string _firstName;
        string _lastName;
    }

    constructor() public {
        owner = msg.sender;
    }

    function addPerson(string memory _firstName, string memory _lastName) public onlyOwner{
        peopleCount += 1;
        people[peopleCount] = Person(peopleCount, _firstName, _lastName);

    }
}