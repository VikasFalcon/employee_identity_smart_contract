pragma solidity ^0.5.0;

import "./Ownable.sol";

contract IdentityContract is Ownable{
    
    struct User{
        string idNo;
        string name;
        string email;
        string profileImage;
        string designation;
        string contractNo;
        string bloodGroupGender;/*Combination of bloodGroup and gender*/
        string resAddress;
        string emergencyContactNo;
        uint joiningDate;
        uint jobLastDate;
        uint birthDate;
    }     
    
    string public companyName;
    string public companyAddress;
    string public companyContactNo;
    
    mapping(address => User) IdentityDetails;
    
    event IdentitySet(address indexed userAddress, string idNo, string userName);
    event IdentityUpdate(address indexed userAddress, string idNo, string userName);
    event CompanyDetailUpdated(string compyName,string compyAddress,string compyContactNo);
    
    constructor(string memory _cmpName, string memory _cmpAddress) public {
        companyName = _cmpName;
        companyAddress = _cmpAddress;
    }
    
    function setIdentity(string memory _idNo,
                    string memory _name,
                    string memory _email,
                    string memory _profileImage,
                    string memory _designation,
                    string memory _contractNo,
                    string memory _bloodGroupGender,
                    string memory _resAddress,
                    string memory _emergencyContactNo,
                    uint _joiningDate,
                    uint _birthDate) public onlyOwner {
                        
        address tmpAddress = address(uint(keccak256(abi.encodePacked(msg.sender,now))));  
        
        IdentityDetails[tmpAddress].idNo = _idNo;  
        IdentityDetails[tmpAddress].name = _name;
        IdentityDetails[tmpAddress].email = _email; 
        IdentityDetails[tmpAddress].profileImage = _profileImage;
        IdentityDetails[tmpAddress].designation = _designation;
        IdentityDetails[tmpAddress].contractNo = _contractNo;
        IdentityDetails[tmpAddress].bloodGroupGender = _bloodGroupGender;/*Input like A+===Male*/
        IdentityDetails[tmpAddress].resAddress = _resAddress;
        IdentityDetails[tmpAddress].emergencyContactNo = _emergencyContactNo;
        IdentityDetails[tmpAddress].joiningDate = _joiningDate;
        IdentityDetails[tmpAddress].jobLastDate = _joiningDate;
        IdentityDetails[tmpAddress].birthDate = _birthDate;
        
        emit IdentitySet(tmpAddress,_idNo,_name);
    }
    
    function updateCompanyDetails(string memory _compyName,
                                 string memory _compyAddress,
                                 string memory _compyContactNo) public onlyOwner{
            companyName = _compyName;
            companyAddress = _compyAddress;
            companyContactNo = _compyContactNo;
            
            emit CompanyDetailUpdated(_compyName, _compyAddress, _compyContactNo);
    }
    
    function updateIdentityDetails(address userAddress,
                                string memory _idNo,
                                string memory _name,
                                string memory _email,
                                string memory _profileImage,
                                string memory _designation,
                                string memory _contractNo,
                                string memory _bloodGroupGender,
                                string memory _resAddress,
                                string memory _emergencyContactNo,
                                uint _joiningDate,
                                uint _jobLastDate,
                                uint _birthDate) public onlyOwner{
        
        require(userAddress != address(0),'Must be valid User Address');
                                    
        IdentityDetails[userAddress].idNo = _idNo;  
        IdentityDetails[userAddress].name = _name; 
        IdentityDetails[userAddress].email = _email; 
        IdentityDetails[userAddress].profileImage = _profileImage;
        IdentityDetails[userAddress].designation = _designation;
        IdentityDetails[userAddress].contractNo = _contractNo;
        IdentityDetails[userAddress].bloodGroupGender = _bloodGroupGender;/*Input like A+===Male*/
        IdentityDetails[userAddress].resAddress = _resAddress;
        IdentityDetails[userAddress].emergencyContactNo = _emergencyContactNo;
        IdentityDetails[userAddress].joiningDate = _joiningDate;
        IdentityDetails[userAddress].jobLastDate = _jobLastDate;
        IdentityDetails[userAddress].birthDate = _birthDate;
        
        emit IdentityUpdate(userAddress,_idNo,_name);
    }
    
    function getUser(address userAddress) public view returns(string memory idNo,
                                                        string memory userData,
                                                        uint joiningDate,
                                                        uint jobLastDate,
                                                        uint birthDate){
        require(userAddress != address(0),'Must be valid User Address');

        return (IdentityDetails[userAddress].idNo,
                string(abi.encodePacked(IdentityDetails[userAddress].name,'###',IdentityDetails[userAddress].email,'###',IdentityDetails[userAddress].profileImage,'###',IdentityDetails[userAddress].designation,'###',IdentityDetails[userAddress].contractNo,'###',IdentityDetails[userAddress].bloodGroupGender,'###',IdentityDetails[userAddress].resAddress,'###',IdentityDetails[userAddress].emergencyContactNo)),
                IdentityDetails[userAddress].joiningDate,
                IdentityDetails[userAddress].jobLastDate,
                IdentityDetails[userAddress].birthDate);
    }
}