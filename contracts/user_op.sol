pragma solidity ^0.5.16;

import "./user_data.sol";
import "./classrooms.sol";


contract Users_op is Users_balance, Rooms_Use{

    function() payable external{}

    function sent_points(address _user,
                         int256 amount) public returns (bool){
        reset_user(); //Check if we have to reset user
        // Sent points to another user
        if (balances[msg.sender].balance >= amount){
            if (balances[_user].isValue) {
                balances[_user].balance += amount;
                balances[msg.sender].balance -= amount;
                return true;
            }
        }
        return false;
    }

    function reservate_room(uint index, uint hour) public returns (bool){
        // reservate room
        reset_user(); //Check if we have to reset use
        reset_rooms(); //Resert rooms schedules
        set_price(index, hour);
        //You must be register
        if(balances[msg.sender].isValue){
            // check if the room is free
            if (is_free(index, hour)){
                // You need to have enough money to pay
                if (get_balance() < price_aver + room_list[index].extra_price){
                    return false;
                }
                // Making payment and reservation
                balances[msg.sender].balance -= price_aver + room_list[index].extra_price;
                uint hour_index = hour - room_list[index].open_hour;
                room_list[index].schedule[hour_index] ++;
                return true;
            }
        }
       return false;
    }
}