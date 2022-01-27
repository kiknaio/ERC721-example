//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

// import "hardhat/console.sol";

contract ERC721 {
    /**
     * @dev indexed keyword allows users to easily search for values inside
     * of an events.
     */
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    /**
     * @dev This event is emitted when an owner transfers ownership of the
     * token to a new address.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 tokens
    );

    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    mapping(uint256 => address) internal _tokenApprovals;

    /**
     * @dev Get the balance of an address
     * @param owner The address to query the balance of
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Address is zero");
        return _balances[owner];
    }

    /**
     * @dev Find the owner of a given token ID.
     * @param tokenId ID of the token to find the owner of.
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "Token ID not found");
        return _owners[tokenId];
    }

    /**
     * @dev Enables or disables an operator to manage all of msg.sender assets.
     * @param operator The address who is eligible to manage owner's assets.
     * @param approved Boolean value of whether operator is approved or not.
     */
    function setApprovalForAll(address operator, bool approved) public {
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    /**
     * @dev Checks if an operator is approved to manage all of msg.sender assets.
     * @param owner The address who owns the assets.
     * @param operator The address who is eligible to manage owner's assets.
     */
    function isApprovedForAll(address owner, address operator)
        public
        view
        returns (bool)
    {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev Updates an approved address for a given token ID.
     * @param to The address to transfer ownership of a specific tokenId.
     * @param tokenId The ID of the token to transfer.
     */
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        // Only owner or approvedAll address can approve specific tokenId
        require(
            owner == msg.sender || isApprovedForAll(owner, msg.sender),
            "Only the owner can approve another address"
        );

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    /**
     * @dev Checks if an address is approved to manage a specific token ID.
     * @param tokenId The ID of the token to check if approved.
     */
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "Token ID not found");
        return _tokenApprovals[tokenId];
    }
}
