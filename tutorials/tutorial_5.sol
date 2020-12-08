pragma solidity ^0.5.1;

contract MyContract {
    mapping(address => uint256) public balances;
    address payable wallet;

    // To be able to listen when their is a purcharse in this contract
    event Purchase(
        // indexed allow you to index events, in this case by buyers
        address indexed _buyer,
        uint256 _amount
    );

    constructor(address payable _wallet) public {
        wallet = _wallet;
    }

    // External functions cannot be called internally
    // They can be called from other contracts and via transactions
    function() external payable {
        buyToken();
    }

    function buyToken() public payable {
        //buy a tokken
        balances[msg.sender] += 1;
        // send ether to the wallet
        wallet.transfer(msg.value);
        emit Purchase(msg.sender, 1);
    }
}