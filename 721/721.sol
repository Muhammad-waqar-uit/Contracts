// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MyNFT is  Ownable, ERC721URIStorage {
    address ownerAddress;
    string public myBaseUri;
    mapping(uint256 => string) tokenUris;
    mapping(uint256 => mapping(address => bool)) public member;

    constructor() ERC721("QTKN", "Q") {
        ownerAddress = msg.sender;
    }

    function _baseURI() internal view override returns (string memory) {
        return myBaseUri;
    }

    function _burn(uint256 tokenId) internal override  {
        super._burn(tokenId);
    }

    function constructUri(string memory uri_, uint256 tokenId) internal returns (string memory) {
        bytes memory newOneBytes = abi.encodePacked(uri_, Strings.toString(tokenId), ".json");
        tokenUris[tokenId] = string(newOneBytes);
        return string(newOneBytes);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function mintTokens(uint256 startTokenId, uint256 endTokenId) public {
        require(startTokenId <= endTokenId, "Invalid token ID range");
        for (uint256 i = startTokenId; i <= endTokenId; i++) {
            if (ownerOf(i) == msg.sender) {
                continue;
            }
            require(!member[i][msg.sender], "You have already claimed this NFT.");
            _safeMint(msg.sender, i);
            tokenUris[i] = constructUri(myBaseUri, i);
            _setTokenURI(i, constructUri(myBaseUri, i));
            member[i][msg.sender] = true;
        }
    }

    function mintToken(uint256 tokenId) public returns (bool) {
        if (ownerOf(tokenId) == msg.sender) {
            revert("Cannot mint the same NFT");
        }
        _safeMint(msg.sender, tokenId);
        tokenUris[tokenId] = constructUri(myBaseUri, tokenId);
        _setTokenURI(tokenId, constructUri(myBaseUri, tokenId));
        member[tokenId][msg.sender] = true;
        return true;
    }

    function setBaseUri(string memory uri_) public returns (string memory) {
        myBaseUri = uri_;
        return uri_;
    }

    function uri(uint256 tokenId) public view virtual returns (string memory) {
        return tokenUris[tokenId];
    }
}
