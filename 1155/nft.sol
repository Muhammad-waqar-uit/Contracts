// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MyNFT is ERC1155,Ownable{
    address owneraddress;
    string public baseURI;

    // constructor()ERC1155("https://ipfs.moralis.io:2053/ipfs/QmVjfBMSLRi7JWtJpY6yApEjFfnXeU6Wt4P6cmfAjynGuR/metadata/metadata/{id}.json"){
    //     owneraddress=msg.sender;
    // }
    constructor(string memory newBaseURI)ERC1155(newBaseURI){
        owneraddress=msg.sender;
        baseURI=newBaseURI;
    }

    function mintTokens(uint256 numTokens) public {
        for (uint256 i = 0; i < numTokens; i++) {
            uint256 tokenId = i + 1; // assuming token IDs start at 1
            uint256 amount = 1;
            _mint(msg.sender, tokenId, amount, abi.encode(msg.sender));
    }

    }
    // function uri(uint256 tokenId) override public pure returns (string memory) {
    //     return string(
    //         abi.encodePacked(
    //             "https://ipfs.moralis.io:2053/ipfs/QmVjfBMSLRi7JWtJpY6yApEjFfnXeU6Wt4P6cmfAjynGuR/metadata/",
    //             Strings.toString(tokenId),
    //             ".json"
    //         )
    //     );
    // }

    function seturitoken(string memory Tokenuri) public returns(string memory){
        baseURI=Tokenuri;
        _setURI(Tokenuri);
        return Tokenuri;
    }
}