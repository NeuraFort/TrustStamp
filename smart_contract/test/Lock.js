const { expect } = require("chai");

describe("TrustStamp", function () {
  let trustStamp;
  let owner;
  let user1;

  beforeEach(async function () {
    const TrustStamp = await ethers.getContractFactory("TrustStamp");
    [owner, user1] = await ethers.getSigners();
    trustStamp = await TrustStamp.deploy();
    await trustStamp.deployed();
  });

  it("should register a new product", async function () {
    const serialNumber = "ABC123";

    await trustStamp.connect(user1).registerProduct(serialNumber);

    const products = await trustStamp.registeredProducts(user1.address);

    expect(products.length).to.equal(1);
    expect(products[0].productId).to.equal(1);
    expect(products[0].serialNumber).to.equal(serialNumber);
  });

  // Add more test cases as needed
});
