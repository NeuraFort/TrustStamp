//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.18;

contract UserRegistry {
    mapping(address => uint256[]) private userProducts;
    mapping(address => bool) private verifiedUsers;


    event ProductRegisteredForUser(address indexed user, uint256 indexed productId);

    function registerProductForUser(uint256 productId, address user) external {
        userProducts[user].push(productId);
        emit ProductRegisteredForUser(user, productId);
    }

    function getUserProducts(address user) external view returns (uint256[] memory) {
        return userProducts[user];
    }

    function isUserVerified(address user) external view returns (bool) {
        return verifiedUsers[user];
    }
}

