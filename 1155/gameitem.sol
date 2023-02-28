// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract GameItems is ERC1155, Ownable {
    
    uint256 public constant NFT1 = 0;
    
    mapping (uint256 => string) private _uris;

    constructor() public ERC1155("https://gateway.pinata.cloud/ipfs/QmRBGksSSobuafAXJj8Yww9JZ85CMMGyY8hor7w1KzkKa1/{id}.jpg") {
        _mint(msg.sender, NFT1, 1, "");
    }
    
    function uri(uint256 tokenId) override public view returns (string memory) {
        return(_uris[tokenId]);
    }
    
    function setTokenUri(uint256 tokenId, string memory uri) public onlyOwner {
        require(bytes(_uris[tokenId]).length == 0, "Cannot set uri twice"); 
        _uris[tokenId] = uri; 
    }
}