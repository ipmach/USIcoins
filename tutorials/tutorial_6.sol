pragma solidity ^0.5.1;

contract ERC20Token {
    string public name;
    mapping(address => uint256) public balances;

    function mint() public {
        // if you are calling for other contract use tx.origin
        // msg.sender will not work because you will get the adddress
        // of the other contract not the user one
        balances[tx.origin] ++;
    }
}

contract MyContract {
    address payable wallet;
    address public token;

    constructor(address payable _wallet, address _token) public {
        wallet = _wallet;
        token = _token;
    }

    function() external payable {
        buyToken();
    }

    function buyToken() public payable {
        ERC20Token _token = ERC20Token(address(token));
        _token.mint();
        // You also can use
        // ERC20Token(address(token)).mint();
        wallet.transfer(msg.value);
    }
}