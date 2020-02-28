pragma solidity 0.5.1;

import "browser/Asset.sol";

///@author Isaac Coffie
///@title A contract to keep track of transactions
contract Transaction is Asset{
    
    //keeping track of the amount of money (ETHER a user has)
    mapping(address => uint) private userBalanceMap;
    
    //a modifier to ensure buyer has made full payment
    modifier fullPayment(uint token_id, uint asset_type, uint price){
        uint asset_price = getPrice(token_id, asset_type);
        require( asset_price <= price);
        _;
    }
    
    //broadcast event when payment is successful
    event PaymentEvent(
        address indexed _from,
        address indexed _to,
        uint indexed _id,
        uint _value,
        string message
    );

    //a public constructor
    constructor() public payable{
        
    }

    
    //this function transfers ownership from one person to the another
    //it calls the changeOnwer() function from the Asset contract
    function transferAsset(uint _token_id, address from_user_addres, address to_user_addres, uint asset_type) private returns(bool){
        return changeOwner(_token_id, from_user_addres, to_user_addres, asset_type);
    }
    
    //Making payment for an asset.. automatically transfers ownership once payment is successful
    function makePayment(uint token_id, address payable owner_addres, address buyer_addres, uint asset_type, uint amount) public payable fullPayment(token_id, asset_type, amount) returns(bool){   
        bool result = transferAsset(token_id, owner_addres, buyer_addres, asset_type);
        
        //if transaction was succcesful, update user balance
        if(result == true){
            emit PaymentEvent(buyer_addres, owner_addres, token_id, amount, "ownership transffered"); //emit event
            uint balance = userBalanceMap[owner_addres];
            userBalanceMap[owner_addres] = (balance + amount);
            owner_addres.transfer(address(this).balance);
            return true;
        }
    }
    //returns the total amount of ether stored in the contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
}