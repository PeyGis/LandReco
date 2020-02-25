pragma solidity 0.5.1;

contract Asset {
    
    //Structure for a land
    struct Land {
        string size;
        address owner;
        uint token_id;
        uint price;
        string gps;
        string details;
        uint date_created; 
    }
    
    //structure for a building
    struct Building {
        string size;
        address owner;
        uint token_id;
        uint price;
        string gps;
        string details;
        uint num_rooms;
        uint date_created; 
    }
     
    // A map of lands
    mapping(uint => Land) private landMaps;
    
    // A map of Buildings
    mapping(uint => Building) private buildingMaps;
    
    uint private numLands;
    uint private numBuildings;

    
    
    //constructor
    constructor() public{
        numLands = 0;
        numBuildings = 0;
    }
    
    //modifier
    modifier onlyOwner(address my_address){
        require(my_address == msg.sender);
        _;
    }
    
    
    function createNewLand(address user_addres,  string memory size, uint price, string memory gps, string memory details) public {
        
        uint id = uint(keccak256(abi.encodePacked(msg.sender, now)));
        Land memory thisLand = Land(size, user_addres, id, price, gps, details, now);
        landMaps[id] = thisLand;
        numLands+=1;
    }
    
    
    function createNewBuilding(address user_addres, uint num_rooms, string memory size, uint price, string memory gps, string memory details) public {
        
        uint id = uint(keccak256(abi.encodePacked(msg.sender, now)));
        Building memory thisBuilding = Building(size, user_addres, id, price, gps, details,num_rooms, now);
        buildingMaps[id] = thisBuilding;
        numBuildings+=1;
    }
    
}