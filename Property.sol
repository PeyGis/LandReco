pragma solidity >=0.4.22 <0.7.0;

import "./Person.sol";
/**
 * @title Property
 * @dev Creates a new Property
 * 
 */
 
 contract Property{
     
     
     /**
      * Instance variables
      */
     address propertyID;
     uint64 propertySize;
     string gPSCordinates = "0.0, 0.0";
     Person owner;
     
     modifier isVerified(){
         require(msg.status == "verified");
        _;
     }
     
     function createNewPropety(address _propertyID, uint64 _propertySize, string _gPSCordinates, Person _ownerAddress) public {
         propertyID = _propertyID;
         propertySize = _propertySize;
         gPSCordinates = _gPSCordinates;
         owner = _ownerAddress;
     }
     
     function getPropertyDetails(address propertyID) public return (uint64, string, Person){
         
         return (propertySize, gPSCordinates, owner);
     }
     
     function changeOwner(Person newOwner) internal isOwner{
         owner = newOwner;
     }
     
 }
