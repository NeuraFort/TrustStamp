//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

contract TrustStamp {
    struct Product {
        uint256 productId;
        string serialNumber;
        // Add more fields as needed
    }
    
    mapping(address => Product[]) private registeredProducts;
    uint256 private productIdCounter;
    
    event ProductRegistered(address indexed user, uint256 productId, string serialNumber);
    
    constructor() {
        productIdCounter = 1; // Initialize the product ID counter
    }
    
    function registerProduct(string memory _serialNumber) public {
        // Generate a unique product ID
        uint256 productId = productIdCounter;
        productIdCounter++; // Increment the counter for the next product
        
        // Create a new product instance
        Product memory newProduct = Product(productId, _serialNumber);
        
        // Add the product to the registeredProducts mapping for the sender
        registeredProducts[msg.sender].push(newProduct);
        
        emit ProductRegistered(msg.sender, productId, _serialNumber);
    }
    
    // Other functions and modifiers...
}

