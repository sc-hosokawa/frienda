import hre from "hardhat";

async function main() {
  const [deployer] = await hre.viem.getWalletClients();
  console.log("Deployer address:", deployer.account.address);

  console.log("Deploying Credential...");
  const credential = await hre.viem.deployContract("Credential", [], {
    walletClient: deployer,
  });
  console.log("Credential deployed to:", credential.address);
  console.log("Finished")
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});