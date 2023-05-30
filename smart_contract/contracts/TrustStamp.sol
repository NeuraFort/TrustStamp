//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.18;

import "./ProductRegistry.sol";
import "./UserRegistry.sol";
import "./AccessControl.sol";

contract TrustStamp is AccessControl {
    ProductRegistry private productRegistry;
    UserRegistry private userRegistry;
    uint256 productId;

    event ProductRegistered(uint256 indexed productId, string indexed serialNumber, address indexed user);
    event ProductVerified(uint256 indexed productId, address indexed user);

    constructor(ProductRegistry _productRegistry, UserRegistry _userRegistry) {
        productRegistry = _productRegistry;
        userRegistry = _userRegistry;
    }

    function registerProduct(string calldata serialNumber) external {
        productId = productRegistry.registerProduct(serialNumber, msg.sender);
        userRegistry.registerProductForUser(productId, msg.sender);
        emit ProductRegistered(productId, serialNumber, msg.sender);
    }

    function verifyProduct(uint256 checkId) external {
        bool success = productRegistry.verifyProduct(checkId, msg.sender);
        require(success, "Product verification failed");
        emit ProductVerified(checkId, msg.sender);
    }

    function getUserProducts() external view returns (uint256[] memory) {
        return userRegistry.getUserProducts(msg.sender);
    }
}
