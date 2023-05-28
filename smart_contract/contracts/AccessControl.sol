//SPDX-License-Identifier: UNLICENSED


pragma solidity ^0.8.18;

contract AccessControl {
    address private owner;
    mapping(address => bool) private admins;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event AdminAdded(address indexed admin);
    event AdminRemoved(address indexed admin);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized: Only owner can perform this action");
        _;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender], "Not authorized: Only admins can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
        admins[msg.sender] = true;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address: Cannot transfer ownership to zero address");
        owner = newOwner;
        emit OwnershipTransferred(msg.sender, newOwner);
    }

    function addAdmin(address admin) external onlyOwner {
        require(admin != address(0), "Invalid address: Cannot add zero address as admin");
        admins[admin] = true;
        emit AdminAdded(admin);
    }

    function removeAdmin(address admin) external onlyOwner {
        require(admin != address(0), "Invalid address: Cannot remove zero address as admin");
        admins[admin] = false;
        emit AdminRemoved(admin);
    }

    function isOwner() external view returns (bool) {
        return msg.sender == owner;
    }

    function isAdmin() external view returns (bool) {
        return admins[msg.sender];
    }
}

