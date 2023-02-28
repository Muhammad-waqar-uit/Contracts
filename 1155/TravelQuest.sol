// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract TravelQuest is ERC1155, Ownable{ 
    uint256[] public supplies = [20,20];
    uint256[] public minted = [0,0];
    address public owneraddress;
    string public newBaseURI;
   
    mapping (uint256=>string) _uris;
    mapping(uint256 => mapping(address => bool)) public member;

     constructor(string memory _ipfsBaseURI) ERC1155(_ipfsBaseURI) {
        owneraddress = msg.sender;
        newBaseURI=_ipfsBaseURI;
    }

    // to Put NFT to Opensea
    //  function uri(uint256 _tokenId) override public view returns (string memory) {
    //     require(_tokenId <= supplies.length-1,"NFT does not exist");
    //     return string(
    //     abi.encodePacked(
    //         "ipfs://QmRUDGSuJ6S5Py5DTeB5LPXio1xUXCGhEPCCkqqVPox4Zy/",
    //         Strings.toString(_tokenId),
    //         ".json"
    //     )
    //     );
    // }

     function mint(uint256 _tokenId,string memory baseURI ) 
        public
        {
         require(
            !member[_tokenId][msg.sender],
            "You have already claimed this NFT."
        );    
        require(_tokenId <= supplies.length-1,"NFT does not exist");
        uint256 index = _tokenId;
        string memory tokenURI = constructTokenURI(baseURI, _tokenId);
        require (minted[index] + 1 <= supplies[index], "All the NFT have been minted");
        _mint(msg.sender, _tokenId, 1, "");
        // "" is data which is set empty
        minted[index] += 1;
        member[_tokenId][msg.sender] = true;
    }

    function totalNftMinted(uint256 _tokenId) public view returns(uint256){
        return minted[_tokenId];
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
    }

    function constructTokenURI(string memory baseURI, uint256 tokenId) public pure returns (string memory) {
    return string(abi.encodePacked(baseURI, Strings.toString(tokenId), ".jpg"));
    }
}