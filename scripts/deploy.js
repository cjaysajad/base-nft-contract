const hre = require("hardhat");
async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying with account:", deployer.address);

  const name = "My Base NFT";
  const symbol = "MBNFT";
  const baseURI = "ipfs://REPLACE_WITH_YOUR_METADATA_CID/";

  const SimpleNFT = await hre.ethers.getContractFactory("SimpleNFT");
  const nft = await SimpleNFT.deploy(name, symbol, baseURI, deployer.address);
  await nft.waitForDeployment();

  console.log("SimpleNFT deployed to:", await nft.getAddress());
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
