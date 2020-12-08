pragma solidity ^0.4.24;

contract Users_balance {

    mapping(address => Person)  balances;

    int256  peopleCount = 0;
    int256 reset_points = 100;

    // Add time reset in the future
    struct Person {
        string firstName;
        string lastName;
        int256 balance;
        string study;
        bool isValue;
    }

    function addPerson(string memory _firstName, string memory _lastName,
                       string memory _study) public  returns (bool){
        // Regirst in the app, you only can do it once
        if(balances[tx.origin].isValue){
            return false;
        }
        balances[tx.origin] = Person(_firstName, _lastName,
                                      reset_points, _study, true);
        peopleCount ++;
        return true;
    }

    function get_name() public view returns (string memory){
        // Get variable name
        if(balances[tx.origin].isValue){
            return balances[tx.origin].firstName;
        }
        return "Not found";
    }

    function set_name(string memory _firstName) public returns (bool){
        // Set variable name
        if(balances[tx.origin].isValue){
            balances[tx.origin].firstName = _firstName;
            return true;
        }
        return false;
    }

    function get_lastName() public view returns (string memory){
        // Get variable last name
        if(balances[tx.origin].isValue){
            return balances[tx.origin].lastName;
        }
        return "Not found";
    }

    function set_lastName(string memory _lastName) public returns (bool){
        // Set variable last name
        if(balances[tx.origin].isValue){
            balances[tx.origin].lastName = _lastName;
            return true;
        }
        return false;
    }

    function get_study() public view returns (string memory){
        // Get variable study
        if(balances[tx.origin].isValue){
            return balances[tx.origin].study;
        }
        return "Not found";
    }

    function set_study(string memory _study) public returns (bool){
        // Set variable study
        if(balances[tx.origin].isValue){
            balances[tx.origin].study = _study;
            return true;
        }
        return false;
    }

    function get_balance() public view returns (int256){
        // Get variable balance
        if(balances[tx.origin].isValue){
            return balances[tx.origin].balance;
        }
        return 0;
    }

    function get_count() public view returns (int256){
        // Get number of people in the system
        return peopleCount;
    }

    function get_reset_points() public view returns (int256){
        //Get number of points reset every week
        return reset_points;
    }
}