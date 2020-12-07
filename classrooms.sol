pragma solidity ^0.4.24;

contract classroom{

    room[] room_list;
    int256 count_rooms = 0;
    int256 price_aver = 10;
    address owner;

    struct room {
        string name;
        uint open_hour;
        uint close_hour;
        int256 number_people;
        int256 extra_price;
        uint[] schedule;
    }

    modifier onlyOwner() {
        // Only owner can do some operations
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function add_class(string _name, uint _open_hour,
                       uint _close_hour,
                       int256 _number_people) public onlyOwner returns(bool){
        // Add class
        if (_close_hour <= _open_hour){
            return false;
        }
        uint N = _close_hour - _open_hour;
        uint[] memory hour_list = new uint[](N);
        for (uint i=0; i<N; i++) {
            hour_list[i] = 0;
        }
        count_rooms += 1;
        room_list.push(room(_name, _open_hour, _close_hour,
                            _number_people, 0, hour_list));
    }

    function get_name_room(uint index) public view returns(string name){
        // Get name of a room
        return room_list[index].name;
    }

    function set_name_room(uint index, string _name) public onlyOwner{
        // Set name of a room
        room_list[index].name = _name;
    }

    function get_openHour_room(uint index) public view returns(uint open_hour){
        // Get open hour room
        return room_list[index].open_hour;
    }

    function set_openHour_room(uint index, uint _open_hour) public onlyOwner{
        // Set open hour room
        if (room_list[index].close_hour <= _open_hour){
            return false;
        }
        room_list[index].open_hour = _open_hour;
    }

    function get_closeHour_room(uint index) public view returns(uint close_hour){
        // Get close hour room
        return room_list[index].close_hour;
    }

    function set_closeHour_room(uint index, uint _close_hour) public onlyOwner{
        // Set close hour room
        if (_close_hour <= room_list[index].open_hour){
            return false;
        }
        room_list[index].close_hour = _close_hour;
    }

    function get_numberPeople_room(uint index) public view returns(int256 numberPeople){
        // Get number people room
        return room_list[index].number_people;
    }

    function set_numberPeople_room(uint index, int256 _numberPeople) public onlyOwner{
        // Set number people room
        room_list[index].number_people = _numberPeople;
    }


}