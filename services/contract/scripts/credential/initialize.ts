import hre from "hardhat";

async function main() {
  const [deployer] = await hre.viem.getWalletClients();
  console.log("Deployer address:", deployer.account.address);

  const contractAddress = "0x5fbdb2315678afecb367f032d93f642f64180aa3";

  const credential = await hre.viem.getContractAt("Credential", contractAddress);

  console.log("Initializing Credential...");

  const initializeTx = await credential.write.initialize([deployer.account.address], {
    account: deployer.account,
  });
  await (await hre.viem.getPublicClient()).waitForTransactionReceipt({ hash: initializeTx });

  console.log("Credential initialized");
  console.log("Finished")
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});