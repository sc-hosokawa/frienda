import {ethers} from "hardhat";

async function main() {
  const accounts = await ethers.getSigners();

  for (const account of accounts.slice(0, 5)) {
    const balance = await ethers.provider.getBalance(account.address);
    console.log(`========== Address: ${account.address}, Balance: ${balance}`);
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
