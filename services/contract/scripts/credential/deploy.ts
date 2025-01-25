import {ethers, upgrades} from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("========== Deployer address:", deployer.address);

  console.log("========== Deploying Contracts...");
  const factory = await ethers.getContractFactory("Credential");
  const credential_contract = await upgrades.deployProxy(factory, [
    deployer.address, // initialOwner
    deployer.address, // pauser
    deployer.address  // minter
  ]);

  await credential_contract.waitForDeployment();
  const credential_address = await credential_contract.getAddress();
  console.log("========== Deployed to:", credential_address);
  console.log("========== Finished")
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
