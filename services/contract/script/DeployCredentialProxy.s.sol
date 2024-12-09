// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.27;

import {console} from "forge-std/Script.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {BaseScript} from "./Base.s.sol";
import {Credential} from "../contracts/Credential.sol";

contract DeployCredentialProxyScript is BaseScript {
    address admin = 0x67Df9d563032dAA77273a689041bC9cFC1B35911;
    address minter = 0x67Df9d563032dAA77273a689041bC9cFC1B35911;
    address pauser = 0x67Df9d563032dAA77273a689041bC9cFC1B35911;

    function run() public broadcast {
        // deploy UUPS proxy and initialize the contract
        address proxy =
            Upgrades.deployUUPSProxy("Credential.sol", abi.encodeCall(Credential.initialize, (admin, pauser, minter)));

        Credential credential = Credential(proxy);
        console.log("Credential deployed at:", address(credential));
    }
}
