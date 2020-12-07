pragma solidity ^0.4.24;

import "./user_data.sol";

contract users_op is users_balance{

    function sent_points(address _user,
                         int256 amount) public returns (bool){
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

}