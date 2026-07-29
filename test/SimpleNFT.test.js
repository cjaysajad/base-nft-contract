const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SimpleNFT", function () {
  let nft, owner, user;
  const mintPrice = ethers.parseEther("0.001");

  beforeEach(async function () {
    [owner, user] = await ethers.getSigners();
    const SimpleNFT = await ethers.getContractFactory("SimpleNFT");
    nft = await SimpleNFT.deploy(
      "Test NFT",
      "TNFT",
      "ipfs://test/",
      owner.address
    );
    await nft.waitForDeployment();
  });

  it("mints an NFT when the correct price is sent", async function () {
    await expect(nft.connect(user).mint({ value: mintPrice }))
      .to.emit(nft, "Minted")
      .withArgs(user.address, 1);

    expect(await nft.ownerOf(1)).to.equal(user.address);
    expect(await nft.totalMinted()).to.equal(1);
  });

  it("reverts when the wrong ETH amount is sent", async function () {
    await expect(
      nft.connect(user).mint({ value: ethers.parseEther("0.0005") })
    ).to.be.revertedWith("Incorrect ETH sent");
  });

  it("allows only the owner to withdraw", async function () {
    await nft.connect(user).mint({ value: mintPrice });
    await expect(nft.connect(user).withdraw()).to.be.revertedWithCustomError(
      nft,
      "OwnableUnauthorizedAccount"
    );

    await expect(nft.connect(owner).withdraw()).to.changeEtherBalance(
      owner,
      mintPrice
    );
  });

  it("lets the owner update the mint price", async function () {
    await nft.connect(owner).setMintPrice(ethers.parseEther("0.002"));
    expect(await nft.mintPrice()).to.equal(ethers.parseEther("0.002"));
  });
});
