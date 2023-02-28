// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";
// import "@openzeppelin/upgrades-core/contracts/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
contract NFT is Initializable,ERC721URIStorageUpgradeable {
    using CountersUpgradeable for CountersUpgradeable.Counter;
    CountersUpgradeable.Counter private _tokenIds; // Tracking the no of tokens minted
    address ownerAdress;
    
    //  constructor() ERC721("ICT Tokens", "ICT") {
    //     ownerAdress = msg.sender;
    // }
    function initialize() public virtual initializer {
        __ERC721_init("ICT Tokens", "ICT");
        ownerAdress = msg.sender;
    }
    // This function is called when the token is to be created
    function createToken(address _to,string memory tokenURI) public returns (uint256) {
        _tokenIds.increment(); // Increment the tokenIds counter
        uint256 newTokenId = _tokenIds.current(); // The new token id is the current value of the counter
        _mint(_to, newTokenId); // mint the token to the sender
        _setTokenURI(newTokenId, tokenURI); // set the tokenURI to the tokenId.
        _approve(ownerAdress,newTokenId);
        return newTokenId;
    }
}