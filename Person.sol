pragma solidity >=0.4.22 <0.7.0;
import "./Property.sol";


/**
 * @title Person
 * @dev Creates new person
 */


contract Person{
    
    //Define stance members
     address private owner;
     Property private propertyList;


    // modifier to check if caller is owner
    modifier isOwner() {

        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getPerson() external view returns (address) {
        return owner;
    }

    /**
     * @dev creates owner address 
     * @return address of owner
     */
    function createPerson(address publicAddress) internal returns (bool) {

        owner = publicAddress;
        return true;
    }

      /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getMyProperties(address publicAddress) external isOnwer returns (propertyList) {

        reutrn propertyList;
    }
}