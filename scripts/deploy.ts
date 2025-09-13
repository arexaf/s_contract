const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying with address:", await deployer.getAddress());

  const Transactions = await hre.ethers.getContractFactory("Transactions", deployer);
  const transactions = await Transactions.deploy();
  
  // Wait for the transaction to be mined
  await transactions.waitForDeployment();

  const deployedAddress = await transactions.getAddress();
  console.log("Transactions contract deployed to:", deployedAddress);
}

main().catch((error) => {
  console.error("Deployment error:", error);
  process.exitCode = 1;
});
