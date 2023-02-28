// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MyNFT is ERC1155, Ownable {
    address owneraddress;
mapping (uint256 => uint256) private _totalSupply;

function _exists(uint256 tokenId) internal view returns (bool) {
    return _totalSupply[tokenId] > 0;
}

    mapping(uint256 => string) private _tokenUris;

    constructor(string memory newBaseURI) ERC1155(newBaseURI) {
        owneraddress = msg.sender;
    }

    function mintTokens(uint256 numTokens) public {
        for (uint256 i = 0; i < numTokens; i++) {
            uint256 tokenId = i + 1; // generate a new token ID
            uint256 amount = 1;
            _mint(msg.sender, tokenId, amount, abi.encode(msg.sender));

            // set the URI for the new token
            string memory tokenUri = Strings.toString(tokenId); // use the token ID as the URI for now
            _tokenUris[tokenId] = tokenUri;
        }
    }

    function uri(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "Token does not exist");

        string memory baseUri = super.uri(0); // get the base URI
        string memory tokenUri = _tokenUris[tokenId]; // get the token-specific URI

        // concatenate the base URI and token-specific URI
        return bytes(tokenUri).length > 0 ? string(abi.encodePacked(baseUri, tokenUri)) : baseUri;
    }

    function setTokenUri(uint256 tokenId, string memory uri_) public {
        require(_exists(tokenId), "Token does not exist");
        _tokenUris[tokenId] = uri_;
    }

    function setBaseURI(string memory newBaseURI) public onlyOwner {
        _setURI(newBaseURI);
    }
}
