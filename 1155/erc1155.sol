// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract MyNFT is ERC1155 {
    // Base IPFS URL for the first type of NFT
    string private _baseUriToken1;

    // Base IPFS URL for the second type of NFT
    string private _baseUriToken2;

    // Token ID counter for each type of NFT
    uint256 private _token1Counter;
    uint256 private _token2Counter;

    // Event to emit when a new NFT is minted
    event NFTMinted(address indexed account, uint256 indexed id, uint256 amount);

    constructor(string memory baseUriToken1, string memory baseUriToken2) ERC1155("") {
        _baseUriToken1 = baseUriToken1;
        _baseUriToken2 = baseUriToken2;
    }

    function mintToken1(address account, uint256 amount) external {
        uint256 tokenId = ++_token1Counter;
        _mint(account, tokenId, amount, "");
        emit NFTMinted(account, tokenId, amount);
    }

    function mintToken2(address account, uint256 amount) external {
        uint256 tokenId = ++_token2Counter;
        _mint(account, tokenId + 1000, amount, "");
        emit NFTMinted(account, tokenId + 1000, amount);
    }

    function uri(uint256 tokenId) public view override returns (string memory) {
        require(tokenId > 0, "Invalid token ID");

        if (tokenId <= _token1Counter) {
            return string(abi.encodePacked(_baseUriToken1, tokenId,"")
        } else if (tokenId <= _token2Counter + 1000) {
            return string(abi.encodePacked(_baseUriToken2, (tokenId - 1000).toString()));
        } else {
            revert("Invalid token ID");
        }
    }
}
