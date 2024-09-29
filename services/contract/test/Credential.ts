import { expect } from "chai";
import hre from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-toolbox-viem/network-helpers";
import { getAddress, parseEther } from "viem";

describe("Credential", function () {
  async function deployCredentialFixture() {
    const [owner, alice, bob] = await hre.viem.getWalletClients();
    
    const credential = await hre.viem.deployContract("Credential", [], {
      walletClient: owner,
    });

    await credential.write.initialize([owner.account.address]);

    return { credential, owner, alice, bob };
  }

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      const { credential, owner } = await loadFixture(deployCredentialFixture);
      expect(await credential.read.owner()).to.equal(getAddress(owner.account.address));
    });

    it("Should have correct name and symbol", async function () {
      const { credential } = await loadFixture(deployCredentialFixture);
      expect(await credential.read.name()).to.equal("Credential Token");
      expect(await credential.read.symbol()).to.equal("CRED");
    });
  });

  describe("Minting", function () {
    it("Should allow owner to mint tokens", async function () {
      const { credential, owner, alice, bob } = await loadFixture(deployCredentialFixture);
      const amount = parseEther("100");
      await credential.write.mint([alice.account.address, bob.account.address], [amount, amount]);
      expect(await credential.read.balanceOf(alice.account.address)).to.equal(amount);
      expect(await credential.read.balanceOf(bob.account.address)).to.equal(amount);
    });

    it("Should not allow non-owner to mint tokens", async function () {
      const { credential, otherAccount } = await loadFixture(deployCredentialFixture);
      const amount = parseEther("100");
      await expect(
        credential.write.mint([otherAccount.account.address, amount], { account: otherAccount.account })
      ).to.be.rejectedWith("Ownable: caller is not the owner");
    });
  });

  describe("Burning", function () {
    it("Should allow token holder to burn their tokens", async function () {
      const { credential, owner, otherAccount } = await loadFixture(deployCredentialFixture);
      const amount = parseEther("100");
      await credential.write.mint([otherAccount.account.address, amount]);
      
      const credentialAsOtherAccount = await hre.viem.getContractAt(
        "Credential",
        credential.address,
        { walletClient: otherAccount }
      );
      await credentialAsOtherAccount.write.burn([amount]);
      
      expect(await credential.read.balanceOf([otherAccount.account.address])).to.equal(0n);
    });
  });

  describe("Transfer", function () {
    it("Should not allow transfer between accounts", async function () {
      const { credential, owner, otherAccount } = await loadFixture(deployCredentialFixture);
      const amount = parseEther("100");
      await credential.write.mint([owner.account.address, amount]);
      
      await expect(
        credential.write.transfer([otherAccount.account.address, amount])
      ).to.be.rejectedWith("NonTransferableERC20: token transfers and approvals are disabled");
    });
  });
});
