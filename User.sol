pragma solidity 0.5.1;

///@author Isaac Coffie
///@title A contract to keep track of users on the platform
contract UserAccount {
    
     enum Role {User, Institution, LandOfficial}
     event newUserAdded(uint id, address user_address);
     
    //creates a structure for a user object 
    struct User{
        string username;
        address owner;
        Role userRole;
    }
    
    //array of users
    User[] private users;
    uint private numUsers;
    
    
    //modifier to restrict access to functions 
    modifier onlyOwner(address my_address){
        //require(users[user_id].owner == msg.sender);
        require(my_address == msg.sender);
        _;
    }
    

    //constructor
    constructor() public{
        numUsers = 0;
    }

    //creates a new user
    function createUser(string memory _username, address user_addres, Role role) public {
        
        uint id = users.push(User(_username, user_addres, role)) - 1 ;
        emit newUserAdded(id, user_addres);
        numUsers+=1;
    }
    
    //changes the name of a user
    function changeUserName(string memory new_name, address user_addres) public onlyOwner(user_addres) {
        for(uint i=0; i < numUsers; i++){
            if(users[i].owner == user_addres){
                users[i].username = new_name;
                break;
            }
        }
        
    }
    
    //returns the total number of users who have been registered on the blockchain
    function getNumUser() public view returns (uint){
        return numUsers;
    }

    //returns details of a particular user
    function getUserDetails(address user_addres) view public returns (string memory, address, Role){
        
        for(uint i=0; i < numUsers; i++){
            if(users[i].owner == user_addres){
                return (users[i].username, users[i].owner, users[i].userRole);
            }
        }
        
    }
    
}