// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.27;

import {console} from "forge-std/Script.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {BaseScript} from "./Base.s.sol";

contract UpgradeScript is BaseScript {
    function run() public broadcast {
        address proxy = 0x55c7a0a35940Aa78d88dF3e301BF65De51B81fc9;

        Upgrades.upgradeProxy(proxy, "CredentialV2.sol", "");
    }
}
