// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
error CannotMintSame(address sender,uint256 tokenid);
contract MyNFT is ERC721,Ownable,ERC721URIStorage {
    address ownerAddress;
    string public mybaseUri;
    mapping (uint256=>string) tokenuris;
    mapping(uint256 => mapping(address => bool)) public member;
    constructor() ERC721("QTKN", "Q") {
        ownerAddress=msg.sender;
    }

    function _baseURI() internal view override returns (string memory) {
        return mybaseUri;
    }
    
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }
    function constructUri(string memory uri_,uint256 tokenid)internal returns(string memory){
        bytes memory newOneBytes = abi.encodePacked(
             uri_,
            Strings.toString(tokenid),
        ".json"
        );
        tokenuris[tokenid]=string(newOneBytes);
         return string(newOneBytes);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    } 

    function mintTokens(uint256 startTokenId, uint256 endTokenId) public {
    require(startTokenId <= endTokenId, "Invalid token ID range");

    uint256 numTokens = endTokenId - startTokenId + 1;

    for (uint256 i = 0; i < numTokens; i++) {
        uint256 tokenId = startTokenId + i; // Calculate the current token ID based on the starting token ID and loop variable
        if (ownerOf(tokenId)==msg.sender){
            continue;
        }
        require(!member[tokenId][msg.sender],"You have already claimed this NFT."); 
        _mint(msg.sender,tokenId);
        tokenuris[tokenId]=constructUri(mybaseUri,tokenId);
        _setTokenURI(tokenId,constructUri(mybaseUri,tokenId));
        member[tokenId][msg.sender] = true;
    }
}
    function mintToken(uint256 tokenid)public returns(bool){
        if(ownerOf(tokenid)==msg.sender){
            revert CannotMintSame(msg.sender,tokenid);
        }
         require(!member[tokenid][msg.sender],"You have already claimed this NFT.");
        _mint(msg.sender, tokenid);
        tokenuris[tokenid]=constructUri(mybaseUri,tokenid);
        _setTokenURI(tokenid,constructUri(mybaseUri,tokenid));
        member[tokenid][msg.sender] = true;
        return true;
    }
    function setbaseuri(string memory uri_)public returns(string memory){
        mybaseUri=uri_;
        return uri_;
    }
     function uri(uint256 tokenid) public view virtual returns(string memory){
        return tokenuris[tokenid];
    } 
}
