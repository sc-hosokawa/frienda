// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.27;

import {Test, console} from "forge-std/Test.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {Credential} from "../../contracts/Credential.sol";

contract CredentialTest is Test {
    address currentPrankee;

    address admin = makeAddr("admin");
    address minter = makeAddr("minter");
    address pauser = makeAddr("pauser");
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    address charlie = makeAddr("charlie");

    Credential public credential;

    function setUp() public {
        // deploy UUPS proxy and initialize the contract
        address proxy =
            Upgrades.deployUUPSProxy("Credential.sol", abi.encodeCall(Credential.initialize, (admin, pauser, minter)));

        credential = Credential(proxy);
    }

    function testInitializations() external {
        assertEq(credential.name(), "Credential");
        assertEq(credential.symbol(), "CRED");
        assertEq(credential.decimals(), 18);
    }

    modifier prankception(address prankee) {
        address prankBefore = currentPrankee;
        vm.stopPrank();
        vm.startPrank(prankee);
        _;
        vm.stopPrank();
        if (prankBefore != address(0)) {
            vm.startPrank(prankBefore);
        }
    }
}
