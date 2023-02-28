// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyERC1155 is ERC1155, Ownable {

    uint256 private _currentTokenID = 0;
    mapping (uint256 => string) private _tokenURIs;

    constructor() ERC1155("https://gateway.pinata.cloud/ipfs/QmRBGksSSobuafAXJj8Yww9JZ85CMMGyY8hor7w1KzkKa1/{id}.jpg") {}

    function mintNFT(address account,uint tokenId, string memory uri_) public onlyOwner returns (uint256) {
        _mint(account, tokenId, 1, "");
        _tokenURIs[_currentTokenID] = uri_;
        return _currentTokenID;
    }

    function uri(uint256 tokenId) public view override returns (string memory) {
        return _tokenURIs[tokenId];
    }
}