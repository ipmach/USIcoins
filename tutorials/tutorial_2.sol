pragma solidity ^0.5.1;

contract MyContract {

    enum State {Waiting, Ready, Active}
    State public state;

    constructor() public {
        state = State.Waiting;
    }

    function activate() public {
        state = State.Active;
    }

    function isActivate() public view returns(bool){
        return state == State.Active;
    }

}