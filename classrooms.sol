pragma solidity ^0.4.24;

contract Rooms_Use{

    room[] room_list;
    uint count_rooms = 0;
    int256 price_aver = 10;
    uint256 reset_rooms_time;
    uint256 period_reset_rooms = 24*60*60;
    address owner;

    struct room {
        string name;
        uint open_hour;
        uint close_hour;
        int256 number_people;
        int256 extra_price;
        int256[] schedule;
    }

    modifier onlyOwner() {
        // Only owner can do some operations
        require(tx.origin == owner);
        _;
    }

    constructor() public {
        owner = tx.origin;
        reset_rooms_time = now + period_reset_rooms;
    }

    function reset_rooms() internal{
        // Reset rooms
        if (reset_rooms_time <= now){
            for (uint i=0; i<count_rooms; i++){
                uint N = room_list[i].close_hour - room_list[i].open_hour;
                for (uint j=0; j<N; j++) {
                    room_list[i].schedule[j] = 0;
                }
            }
        }
    }

    function add_class(string _name, uint _open_hour,
                       uint _close_hour,
                       int256 _number_people) public onlyOwner returns(bool){
        reset_rooms(); //Resert rooms schedules
        // Add class
        if (_close_hour <= _open_hour){
            return false;
        }
        uint N = _close_hour - _open_hour;
        int256[] memory hour_list = new int256[](N);
        for (uint i=0; i<N; i++) {
            hour_list[i] = 0;
        }
        count_rooms += 1;
        room_list.push(room(_name, _open_hour, _close_hour,
                            _number_people, 0, hour_list));
    }

    function get_name_room(uint index) public returns(string name){
        // Get name of a room
        reset_rooms(); //Resert rooms schedules
        return room_list[index].name;
    }

    function set_name_room(uint index, string _name) public onlyOwner{
        // Set name of a room
        reset_rooms(); //Resert rooms schedules
        room_list[index].name = _name;
    }

    function get_openHour_room(uint index) public returns(uint open_hour){
        // Get open hour room
        reset_rooms(); //Resert rooms schedules
        return room_list[index].open_hour;
    }

    function set_openHour_room(uint index, uint _open_hour) public onlyOwner returns(bool){
        // Set open hour room
        reset_rooms(); //Resert rooms schedules
        if (room_list[index].close_hour <= _open_hour){
            return false;
        }
        room_list[index].open_hour = _open_hour;
        return true;
    }

    function get_closeHour_room(uint index) public returns(uint close_hour){
        // Get close hour room
        reset_rooms(); //Resert rooms schedules
        return room_list[index].close_hour;
    }

    function set_closeHour_room(uint index, uint _close_hour) public onlyOwner returns(bool){
        // Set close hour room
        reset_rooms(); //Resert rooms schedules
        if (_close_hour <= room_list[index].open_hour){
            return false;
        }
        room_list[index].close_hour = _close_hour;
        return true;
    }

    function get_numberPeople_room(uint index) public returns(int256 numberPeople){
        // Get number people room
        reset_rooms(); //Resert rooms schedules
        return room_list[index].number_people;
    }

    function set_numberPeople_room(uint index, int256 _numberPeople) public onlyOwner returns(bool){
        // Set number people room
        reset_rooms(); //Resert rooms schedules
        room_list[index].number_people = _numberPeople;
        return true;
    }

    function is_free(uint index, uint hour) public returns(bool){
        // Check if the room is free in an specific hour
        reset_rooms(); //Resert rooms schedules
        // Check if the room open yet
        if (room_list[index].open_hour > hour){
            return false;
        }
        // Check if the room it has already close
        if (room_list[index].close_hour < hour){
            return false;
        }
        uint hour_index = hour - room_list[index].open_hour;
        //Check if the class is full
        if (room_list[index].schedule[hour_index] >= room_list[index].number_people){
            return false;
        }
        return true;
    }

    function get_count_room() public returns(uint){
        // Number of classes
        reset_rooms(); //Resert rooms schedules
        return count_rooms;
    }

    function set_price(uint index, uint hour) internal returns(bool){

        int256 valid_rooms = int256(room_list.length);
        valid_rooms -= 1;
        int256 cost = 0;
        int256 avg;

        room storage chosen_room = room_list[index];
        if (is_free(index, hour)){




            for (uint i = 0; i < room_list.length; i++){


                if(i == index){

                    continue;
                }

                if(hour < room_list[i].open_hour || hour > room_list[i].close_hour){

                    valid_rooms -= 1;
                    continue;
                }

                else{

                    room storage r = room_list[i];
                    cost += r.schedule[hour - r.open_hour];
                }
            }
        }


        else{

            return false;
        }

        avg = cost/valid_rooms;
        chosen_room.extra_price = chosen_room.schedule[hour - chosen_room.open_hour - 1] + 1 - avg;

        return true;


    }

    function get_price(uint index, uint hour) public returns(int256){

        set_price(index, hour);


        return price_aver + int256(room_list[index].extra_price);
    }

}