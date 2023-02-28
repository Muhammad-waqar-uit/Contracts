// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MyERC1155 is ERC1155, Ownable {
    
    uint256 public constant nft1=1;
    uint256 public constant nft2=2;
    
    mapping (uint256 => string) private _uris;

    constructor()ERC1155("https://ipfs.moralis.io:2053/ipfs/QmVjfBMSLRi7JWtJpY6yApEjFfnXeU6Wt4P6cmfAjynGuR/metadata/{id}.jpg") {
        _mint(msg.sender, nft1,1,"");
        _mint(msg.sender,nft2,1,"");
    }
    
    function uri(uint256 tokenId) override public pure returns (string memory) {
        return string(
            abi.encodePacked(
                "https://gateway.pinata.cloud/ipfs/QmRBGksSSobuafAXJj8Yww9JZ85CMMGyY8hor7w1KzkKa1/",
                Strings.toString(tokenId),
                ".jpg"
            )
        );
    }
    
    function setTokenUri(uint256 tokenId, string memory uri_) public onlyOwner {
        require(bytes(_uris[tokenId]).length == 0, "Cannot set uri twice"); 
        _uris[tokenId] = uri_; 
    }

    function Tokenuri(uint256 tokenId) public view returns(string memory){
        return _uris[tokenId];
    }
}