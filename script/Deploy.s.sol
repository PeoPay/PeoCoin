// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Script.sol";
import "../src/PeoCoin.sol";

contract DeployPeoCoin is Script {
    function run() external {
        vm.startBroadcast();

        PeoCoin token = new PeoCoin(1000000 ether, msg.sender, 2, msg.sender);

        console.log("PeoCoin deployed at:", address(token));

        vm.stopBroadcast();
    }
}
