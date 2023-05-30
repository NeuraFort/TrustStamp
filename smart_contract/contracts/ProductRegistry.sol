//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.18;

contract ProductRegistry {
    struct Product {
        uint256 id;
        string serialNumber;
        address owner;
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Product) private products;
    mapping(string => uint256) private productIds;
    uint256 private productIdCounter;


    event ProductRegistered(uint256 indexed productId, string serialNumber, address owner);
    event ProductVerified(uint256 indexed productId, address verifier);

    function registerProduct(string memory serialNumber, address owner) external returns (uint256) {

        productIdCounter++;
        uint256 productId = productIdCounter;
        uint256 timestamp = block.timestamp;
        products[productId] = Product(productId, serialNumber, owner, timestamp, false);
        emit ProductRegistered(productId, serialNumber, owner);
        return productId;
    }

    function verifyProduct(uint256 productId, address verifier) external returns (bool) {
        Product storage product = products[productId];
        require(product.id != 0, "Product not found");
        require(!product.verified, "Product already verified");
        product.verified = true;
        emit ProductVerified(productId, verifier);
        return true;
    }

    function getProduct(uint256 productId) external view returns (Product memory) {
        return products[productId];
    }

    function getProductId(string memory serialNumber) public view returns (uint256) {
        return productIds[serialNumber];
    }


}
