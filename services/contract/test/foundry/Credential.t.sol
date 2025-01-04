// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.27;

import {Test, console} from "forge-std/Test.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IAccessControl} from "@openzeppelin/contracts/access/IAccessControl.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {CredentialV2} from "../../contracts/CredentialV2.sol";

/// @custom:oz-upgrades-from CredentialV2
contract CredentialV3 is CredentialV2 {
    function version() public pure override returns (string memory) {
        return "v3.0.0";
    }
}

contract CredentialV2Test is Test {
    address currentPrankee;
    address admin = makeAddr("admin");
    address minter = makeAddr("minter");
    address pauser = makeAddr("pauser");
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    address charlie = makeAddr("charlie");

    CredentialV2 public credential;
    address proxy;

    event CredentialGranted(address indexed account, uint256 amount);
    event CredentialBurned(address indexed account, uint256 amount);

    function setUp() public {
        // deploy UUPS proxy and initialize the contract
        proxy = Upgrades.deployUUPSProxy(
            "CredentialV2.sol", abi.encodeCall(CredentialV2.initialize, (admin, pauser, minter))
        );

        credential = CredentialV2(proxy);
    }

    function testInitializations() external view {
        assertEq(credential.name(), "Credential");
        assertEq(credential.symbol(), "CRED");
        assertEq(credential.decimals(), 18);
    }

    function testUpgrade() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;
        __mint(accounts, amounts, minter);

        assertEq(credential.version(), "v2.0.0");
        assertEq(credential.balanceOf(alice), 100);

        vm.startPrank(admin);
        Upgrades.upgradeProxy(proxy, "out/Credential.t.sol/CredentialV3.json", "");
        vm.stopPrank();

        assertEq(credential.version(), "v3.0.0");
        // check if the balance is correct
        assertEq(credential.balanceOf(alice), 100);
        assertEq(credential.totalSupply(), 100);
    }

    function testVersion() external view {
        assertEq(credential.version(), "v2.0.0");
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

        accounts[0] = minter;
        amounts[0] = 100;

        __mint(accounts, amounts, minter);
        assertEq(credential.balanceOf(minter), 100);

        vm.expectEmit(true, true, true, false);
        emit CredentialBurned(minter, 100);
        __burn(100, minter);

        // test check if the balance is correct
        assertEq(credential.balanceOf(minter), 0);
    }

    function testBurnFrom() external {
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
        __burnFrom(alice, 100, minter);

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

        __batchBurn(accounts, amounts, minter);

        // test check if the balance is correct
        assertEq(credential.balanceOf(alice), 0);
        assertEq(credential.balanceOf(bob), 0);
    }

    function testRevertBurn() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        __mint(accounts, amounts, minter);

        // this will revert because alice does not have the burner role
        vm.expectRevert(
            abi.encodeWithSelector(CredentialV2.CALLER_MUST_HAVE_BURNER_ROLE.selector, alice, credential.BURNER_ROLE())
        );
        __burn(100, alice);
    }

    function testRevertBurnFrom() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        __mint(accounts, amounts, minter);

        __approve(alice, bob, 100);

        // this will revert because bob does not have the burner role
        vm.expectRevert(
            abi.encodeWithSelector(CredentialV2.CALLER_MUST_HAVE_BURNER_ROLE.selector, bob, credential.BURNER_ROLE())
        );
        __burnFrom(alice, 100, bob);
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
        vm.expectRevert(abi.encodeWithSelector(CredentialV2.INVALID_LENGTH.selector));
        __batchBurn(invalidAccounts, amounts, minter);
    }

    function testRevertInvalidBurner() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        __mint(accounts, amounts, minter);

        __approve(alice, minter, 100);

        // this will revert because alice does not have the burner role
        vm.expectRevert(
            abi.encodeWithSelector(
                IAccessControl.AccessControlUnauthorizedAccount.selector, alice, credential.BURNER_ROLE()
            )
        );
        __batchBurn(accounts, amounts, alice);
    }

    function testRevertMint() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        vm.expectRevert(
            abi.encodeWithSelector(
                IAccessControl.AccessControlUnauthorizedAccount.selector, bob, credential.MINTER_ROLE()
            )
        );
        __mint(accounts, amounts, bob);
    }

    function testRevertInvalidMinter() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        vm.expectRevert(
            abi.encodeWithSelector(
                IAccessControl.AccessControlUnauthorizedAccount.selector, alice, credential.MINTER_ROLE()
            )
        );
        __mint(accounts, amounts, alice);
    }

    function testRevertInvalidMintLength() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](2);

        accounts[0] = alice;
        amounts[0] = 100;
        amounts[1] = 200;

        vm.expectRevert(abi.encodeWithSelector(CredentialV2.INVALID_LENGTH.selector));
        __mint(accounts, amounts, minter);
    }

    function testRevertTransfer() external {
        address[] memory accounts = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        accounts[0] = alice;
        amounts[0] = 100;

        __mint(accounts, amounts, minter);

        // expect revert transfer token alice -> bob
        vm.expectRevert(abi.encodeWithSelector(CredentialV2.INVALID_TRANSFER.selector, alice, bob));
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

    function testRevertInvalidPauser() external {
        // this will revert because bob is not a pauser
        vm.expectRevert(
            abi.encodeWithSelector(
                IAccessControl.AccessControlUnauthorizedAccount.selector, alice, credential.PAUSER_ROLE()
            )
        );
        __pause(alice);
    }

    function testRevertInvalidUnpauser() external {
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

    function __batchBurn(address[] memory accounts, uint256[] memory amounts, address caller)
        internal
        prankception(caller)
    {
        credential.batchBurn(accounts, amounts);
    }

    function __burn(uint256 amount, address caller) internal prankception(caller) {
        credential.burn(amount);
    }

    function __burnFrom(address account, uint256 amount, address caller) internal prankception(caller) {
        credential.burnFrom(account, amount);
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
