// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {ERC20BurnableUpgradeable} from
    "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import {ERC20PausableUpgradeable} from
    "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PausableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/// @title Credential contract
/// @notice ERC20 token representing a credential
/// @dev The contract is upgradeable using the UUPS pattern
contract Credential is
    Initializable,
    ERC20Upgradeable,
    ERC20BurnableUpgradeable,
    ERC20PausableUpgradeable,
    AccessControlUpgradeable,
    UUPSUpgradeable
{
    /// @notice Pauser role for pausing and unpausing the contract
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /// @notice Minter role for minting new tokens
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /// @notice Burner role for burning tokens
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    /// @notice Upgrader role for upgrading the contract
    bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");

    /// @notice Error message for invalid length
    error INVALID_LENGTH();

    /// @notice Event emitted when a credential is granted
    event CredentialGranted(address indexed account, uint256 amount);

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /// @notice Initialize the contract
    /// @param initialOwner The address that will have the default admin/upgrader role
    /// @param pauser The address that will have the pauser role
    /// @param minter The address that will have the minter/burner role
    function initialize(address initialOwner, address pauser, address minter) public initializer {
        __ERC20_init("Credential", "CRED");
        __ERC20Burnable_init();
        __ERC20Pausable_init();
        __UUPSUpgradeable_init();

        _grantRole(DEFAULT_ADMIN_ROLE, initialOwner);
        _grantRole(PAUSER_ROLE, pauser);
        _grantRole(MINTER_ROLE, minter);
        _grantRole(BURNER_ROLE, minter);
        _grantRole(UPGRADER_ROLE, initialOwner);
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyRole(UPGRADER_ROLE) {}

    /// @notice Pause the contract
    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /// @notice Unpause the contract
    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    /// @notice Mint new tokens to the specified addresses
    /// @dev The length of the `to` and `amount` arrays must be the same, otherwise the function will revert
    /// @param to The addresses to which the tokens will be minted
    /// @param amount The amount of tokens to mint to each address
    function mint(address[] memory to, uint256[] memory amount) public onlyRole(MINTER_ROLE) {
        require(to.length == amount.length, INVALID_LENGTH());
        for (uint256 i = 0; i < to.length; i++) {
            _mint(to[i], amount[i]);
            emit CredentialGranted(to[i], amount[i]);
        }
    }

    /// @notice Burn tokens from the specified addresses
    /// @dev The length of the `from` and `amount` arrays must be the same, otherwise the function will revert
    /// @dev from address must have allowance for the burner to burn the tokens
    /// @param from The addresses from which the tokens will be burned
    /// @param amount The amount of tokens to burn from each address
    function burn(address[] memory from, uint256[] memory amount) public onlyRole(BURNER_ROLE) {
        require(from.length == amount.length, INVALID_LENGTH());
        for (uint256 i = 0; i < from.length; i++) {
            burnFrom(from[i], amount[i]);
        }
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        revert("Credential: transfer is disabled");
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        revert("Credential: transferFrom is disabled");
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        revert("Credential: approve is disabled");
    }

    // The following functions are overrides required by Solidity.
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20Upgradeable, ERC20PausableUpgradeable)
    {
        super._update(from, to, value);
    }
}
