pragma solidity ^0.4.24;

contract Users_balance {

    mapping(address => Person)  balances;

    int256  peopleCount = 0;
    int256 reset_points = 100;
    uint256 reset_period = 7*24*60*60;

    // Add time reset in the future
    struct Person {
        string firstName;
        string lastName;
        int256 balance;
        string study;
        bool isValue;
        uint256 time_reset;
    }

    function reset_user() internal{
        // Reset the user data if a periof of time pass
        if (balances[tx.origin].time_reset <= now){
            balances[tx.origin].balance = reset_points;
            balances[tx.origin].time_reset += reset_period;
        }
    }

    function addPerson(string memory _firstName, string memory _lastName,
                       string memory _study) public  returns (bool){
        // Regirst in the app, you only can do it once
        if(balances[tx.origin].isValue){
            return false;
        }
        balances[tx.origin] = Person(_firstName, _lastName,
                                      reset_points, _study, true, now + reset_period);
        peopleCount ++;
        return true;
    }

    function get_name() public returns (string memory){
        reset_user(); //Check if we have to reset user
        // Get variable name
        if(balances[tx.origin].isValue){
            return balances[tx.origin].firstName;
        }
        return "Not found";
    }

    function set_name(string memory _firstName) public returns (bool){
         reset_user(); //Check if we have to reset user
        // Set variable name
        if(balances[tx.origin].isValue){
            balances[tx.origin].firstName = _firstName;
            return true;
        }
        return false;
    }

    function get_lastName() public returns (string memory){
        reset_user(); //Check if we have to reset user
        // Get variable last name
        if(balances[tx.origin].isValue){
            return balances[tx.origin].lastName;
        }
        return "Not found";
    }

    function set_lastName(string memory _lastName) public returns (bool){
        reset_user(); //Check if we have to reset user
        // Set variable last name
        if(balances[tx.origin].isValue){
            balances[tx.origin].lastName = _lastName;
            return true;
        }
        return false;
    }

    function get_study() public returns (string memory){
        reset_user(); //Check if we have to reset user
        // Get variable study
        if(balances[tx.origin].isValue){
            return balances[tx.origin].study;
        }
        return "Not found";
    }

    function set_study(string memory _study) public returns (bool){
        reset_user(); //Check if we have to reset user
        // Set variable study
        if(balances[tx.origin].isValue){
            balances[tx.origin].study = _study;
            return true;
        }
        return false;
    }

    function get_balance() public returns (int256){
        reset_user(); //Check if we have to reset user
        // Get variable balance
        if(balances[tx.origin].isValue){
            return balances[tx.origin].balance;
        }
        return 0;
    }

    function get_count() public returns (int256){
        reset_user(); //Check if we have to reset user
        // Get number of people in the system
        return peopleCount;
    }

    function get_reset_points() public returns (int256){
        reset_user(); //Check if we have to reset user
        //Get number of points reset every week
        return reset_points;
    }
}