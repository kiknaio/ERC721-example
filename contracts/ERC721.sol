//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

// import "hardhat/console.sol";

contract ERC721 {
    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;

    /**
     * @dev Get the balance of an address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Address is zero");
        return _balances[owner];
    }

    /**
     * @dev Find the owner of a given token ID.
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "Token ID not found");
        return _owners[tokenId];
    }
}
