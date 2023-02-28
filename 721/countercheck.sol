pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
contract MyNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MyNFT", "NFT") {}

    function mintNFT(string memory tokenuri) public returns (uint256) {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenuri);
        return tokenId;
    }

     function constructUri(uint256 tokenId,string memory _baseuri) internal pure returns (string memory) {
        bytes memory newOneBytes = abi.encodePacked(_baseuri,Strings.toString(tokenId), ".json");
        return string(newOneBytes);
    }

   function mintTokens(uint256 _amount,string memory baseuri) public {
    // require(startTokenId <= endTokenId, "Invalid token ID range");
    // uint256 numTokens = endTokenId - startTokenId + 1;

    for (uint256 i = 1; i <=_amount; i++) {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        // uint256 tokenId = startTokenId + i;
        // if (_exists(tokenId)) {
        //     address owner = ownerOf(tokenId);
        //     if (owner != address(0)) {
        //         continue;
        //     }
        // }
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, constructUri(i,baseuri));
    }
}
}
