// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract TravelQuest is ERC1155, Ownable{ 
    address public owneraddress;
    string public newBaseURI;
   
    mapping (uint256=>string) _uris;
    // mapping(uint256 => mapping(address => bool)) public member;

     constructor(string memory _ipfsBaseURI) ERC1155(_ipfsBaseURI) {
        owneraddress = msg.sender;
        _ipfsBaseURI=newBaseURI;
    }

    // to Put NFT to Opensea
     function uri(uint256 _tokenId) override public view returns (string memory) {
          return string(
        abi.encodePacked(
            newBaseURI,
            Strings.toString(_tokenId),
            ".json"
        )
        );
    }
     function mint(uint256 noOfNFT)  public{
        for (uint256 i = 0; i < noOfNFT; i++) {
        // require(!member[noOfNFT][msg.sender],"You have already claimed this NFT.");    
        // uint256 index = noOfNFT;
        uint256 tokenID=i+1;
        _mint(msg.sender, tokenID, 1, abi.encode(msg.sender));
        // "" is data which is set empty
        // member[noOfNFT][msg.sender] = true;
        }
    }

    function setTokenUri(uint256 tokenId, string memory uri_) public onlyOwner {
        require(bytes(_uris[tokenId]).length == 0, "Cannot set uri twice"); 
        _uris[tokenId] = uri_; 
    }

     function updateBaseURI(string memory newBaseURI_) public {
        require(msg.sender == owneraddress, "Only the contract owner can update the base URI");
        bytes memory newOneBytes = abi.encodePacked(
             newBaseURI_,
        "{id}",
        ".json"
        );

    string memory newOne = string(newOneBytes);
        _setURI(newOne);
        newBaseURI=newOne;
    }

    function constructTokenURI(uint256 tokenId) public view returns (string memory) {
    return string(abi.encodePacked(newBaseURI, Strings.toString(tokenId), ".json"));
    }
    function Tokenuri(uint256 tokenId) public view returns(string memory){
        return _uris[tokenId];
    }
}