import hre from "hardhat";

async function main() {
  const addresses = await hre.viem.getWalletClients();
  const publicClient = await hre.viem.getPublicClient();

  for (const addr of addresses.slice(0, 5)) {
    const balance = await publicClient.getBalance({ address: addr.account.address });
    console.log(`Address: ${addr.account.address}, Balance: ${balance}`);
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
