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

    event CredentialGranted(address indexed account, uint256 amount);

    error INVALID_TRANSFER(address from, address to);

    function setUp() public {
        // deploy UUPS proxy and initialize the contract
        address proxy =
            Upgrades.deployUUPSProxy("Credential.sol", abi.encodeCall(Credential.initialize, (admin, pauser, minter)));

        credential = Credential(proxy);
    }

    function testMint() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;
        // test check if the event is emitted
        vm.expectEmit(true, true, true, false);
        emit CredentialGranted(alice, 100);
        __mint(accounts, amounts, minter);

        // test check if the balance is correct
        assertEq(credential.balanceOf(alice), 100);
    }

    function testBatchMint() external {
        address[] memory accounts = new address[](2);
        uint256[] memory amounts = new uint256[](2);

        accounts[0] = alice;
        amounts[0] = 100;
        accounts[1] = bob;
        amounts[1] = 200;

        __mint(accounts, amounts, minter);

        // test check if the balance is correct
        assertEq(credential.balanceOf(alice), 100);
        assertEq(credential.balanceOf(bob), 200);
    }

    function testRevertMint() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        vm.expectRevert();
        __mint(accounts, amounts, bob);
    }

    function testRevertInvalidMinter() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        vm.expectRevert();
        __mint(accounts, amounts, alice);
    }

    function testRevertInvalidMintLength() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](2);

        accounts[0] = alice;
        amounts[0] = 100;
        amounts[1] = 200;

        vm.expectRevert(abi.encodeWithSelector(Credential.INVALID_LENGTH.selector));
        __mint(accounts, amounts, minter);
    }

    function __mint(address[] memory accounts, uint256[] memory amounts, address caller)
        internal
        prankception(caller)
    {
        credential.mint(accounts, amounts);
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
