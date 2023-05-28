// Import the required modules
const { expect } = require("chai");
const { ethers } = require("hardhat");

// Describe the ProductRegistry contract tests
describe("ProductRegistry", function () {
  let ProductRegistry;
  let productRegistry;
  let owner;
  let user;
  let productId;
  let serialNumber;

  // Deploy the contract before each test
  beforeEach(async function () {
    // Deploy the ProductRegistry contract
    ProductRegistry = await ethers.getContractFactory("ProductRegistry");
    productRegistry = await ProductRegistry.deploy();
    await productRegistry.deployed();

    // Set the owner and user addresses
    [owner, user] = await ethers.getSigners();

    // Assign a product serial number
    serialNumber = "ABC123";
  });

  // Test the product registration
  it("should register a product", async function () {
    // Call the registerProduct function
    await productRegistry.registerProduct(serialNumber, owner.address);
    // Get the product ID
    productId = await productRegistry.getProductId(serialNumber);

    // Verify the product details
    const product = await productRegistry.getProduct(productId);
    expect(product.serialNumber).to.equal(serialNumber);
    expect(product.owner).to.equal(owner.address);
  });

  // Test the product verification
  it("should verify a product", async function () {
    // Register a product
    await productRegistry.registerProduct(serialNumber, owner.address);

    // Get the product ID
    productId = await productRegistry.getProductId(serialNumber);

    // Call the verifyProduct function
    await productRegistry.verifyProduct(productId, owner.address);

    // Get the product details after verification
    const product = await productRegistry.getProduct(productId);
    expect(product.verified).to.equal(true);
  });
});
