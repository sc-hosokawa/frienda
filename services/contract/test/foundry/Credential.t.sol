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
    event CredentialBurned(address indexed account, uint256 amount);

    function setUp() public {
        // deploy UUPS proxy and initialize the contract
        address proxy =
            Upgrades.deployUUPSProxy("Credential.sol", abi.encodeCall(Credential.initialize, (admin, pauser, minter)));

        credential = Credential(proxy);
    }

    function testInitializations() external view {
        assertEq(credential.name(), "Credential");
        assertEq(credential.symbol(), "CRED");
        assertEq(credential.decimals(), 18);
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

    function testBurn() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        __mint(accounts, amounts, minter);
        assertEq(credential.balanceOf(alice), 100);

        // alice approve minter to burn 100 tokens
        // so that minter can burn the tokens that alice has
        __approve(alice, minter, 100);
        assertEq(credential.allowance(alice, minter), 100);

        vm.expectEmit(true, true, true, false);
        emit CredentialBurned(alice, 100);
        __burn(accounts, amounts, minter);

        // test check if the balance is correct
        assertEq(credential.balanceOf(alice), 0);
    }

    function testBatchBurn() external {
        address[] memory accounts = new address[](2);
        uint256[] memory amounts = new uint256[](2);

        accounts[0] = alice;
        amounts[0] = 100;
        accounts[1] = bob;
        amounts[1] = 200;

        __mint(accounts, amounts, minter);
        assertEq(credential.balanceOf(alice), 100);
        assertEq(credential.balanceOf(bob), 200);

        // alice approve minter to burn 100 tokens
        // so that minter can burn the tokens that alice has
        __approve(alice, minter, 100);
        assertEq(credential.allowance(alice, minter), 100);

        // bob approve minter to burn 200 tokens
        // so that minter can burn the tokens that bob has
        __approve(bob, minter, 200);
        assertEq(credential.allowance(bob, minter), 200);

        __burn(accounts, amounts, minter);

        // test check if the balance is correct
        assertEq(credential.balanceOf(alice), 0);
        assertEq(credential.balanceOf(bob), 0);
    }

    function testRevertBurn() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        // this will revert because alice has not approved minter to burn the tokens
        vm.expectRevert();
        __burn(accounts, amounts, bob);
    }

    function testRevertInvalidBurnLength() external {
        address[] memory accounts = new address[](2);
        uint256[] memory amounts = new uint256[](2);

        accounts[0] = alice;
        accounts[1] = bob;
        amounts[0] = 100;
        amounts[1] = 200;

        __mint(accounts, amounts, minter);

        address[] memory invalidAccounts = new address[](1);
        invalidAccounts[0] = alice;

        // this will revert because the length of the accounts and amounts are not the same
        vm.expectRevert(abi.encodeWithSelector(Credential.INVALID_LENGTH.selector));
        __burn(invalidAccounts, amounts, minter);
    }

    function testRevertInvalidBurner() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        __mint(accounts, amounts, minter);

        __approve(alice, minter, 100);

        vm.expectRevert();
        __burn(accounts, amounts, alice);
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

    function testRevertTransfer() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        __mint(accounts, amounts, minter);

        // expect revert transfer token alice -> bob
        vm.expectRevert(abi.encodeWithSelector(Credential.INVALID_TRANSFER.selector, alice, bob));
        __transfer(alice, bob, 100);
    }

    function testPause() external {
        __pause(pauser);
        assertEq(credential.paused(), true);
    }

    function testUnpause() external {
        __pause(pauser);
        assertEq(credential.paused(), true);

        __unpause(pauser);
        assertEq(credential.paused(), false);
    }

    function testInvalidPauser() external {
        // this will revert because bob is not a pauser
        vm.expectRevert();
        __pause(alice);
    }

    function testInvalidUnpauser() external {
        __pause(pauser);
        assertEq(credential.paused(), true);

        // this will revert because alice is not a pauser
        vm.expectRevert();
        __unpause(alice);
    }

    function __transfer(address from, address to, uint256 amount) internal prankception(from) {
        credential.transfer(to, amount);
    }

    function __mint(address[] memory accounts, uint256[] memory amounts, address caller)
        internal
        prankception(caller)
    {
        credential.mint(accounts, amounts);
    }

    function __burn(address[] memory accounts, uint256[] memory amounts, address caller)
        internal
        prankception(caller)
    {
        credential.burn(accounts, amounts);
    }

    function __approve(address owner, address spender, uint256 amount) internal prankception(owner) {
        credential.approve(spender, amount);
    }

    function __pause(address caller) internal prankception(caller) {
        credential.pause();
    }

    function __unpause(address caller) internal prankception(caller) {
        credential.unpause();
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
