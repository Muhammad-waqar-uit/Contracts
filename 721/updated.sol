// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
contract MyNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private myCounter;
    // string public mybaseuri;
    constructor() ERC721("ERC721", "721") {}
    
    // function _baseURI() internal view override returns (string memory) {
    //     return mybaseuri;
    // }
    
    function mintNFT(string memory tokenuri)
        public
        returns (uint256)
    {
        uint256 tokenId=myCounter.increment();
        // _mint(msg.sender, tokenId);
        // _setTokenURI(tokenId,tokenuri);
        return tokenId;
    }
    //   function setBaseUri(string memory uri_) public returns (string memory) {
    //     mybaseuri = uri_;
    //     return uri_;
    // }

    function constructUri(uint256 tokenId) internal pure returns (string memory) {
        bytes memory newOneBytes = abi.encodePacked(Strings.toString(tokenId), ".json");
        return string(newOneBytes);
    }

   function mintTokens(uint256 startTokenId, uint256 endTokenId) public {
    require(startTokenId <= endTokenId, "Invalid token ID range");
    uint256 numTokens = endTokenId - startTokenId + 1;
    for (uint256 i = 0; i < numTokens; i++) {
        uint256 tokenId = startTokenId + i;
        if (_exists(tokenId)) {
            address owner = ownerOf(tokenId);
            if (owner != address(0)) {
                continue;
            }
        }
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, constructUri(tokenId));
    }
}

}
