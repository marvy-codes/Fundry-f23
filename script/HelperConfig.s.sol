// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";


contract HelperConfig  is Script{

    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address priceFeed; 
    }

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        }
        // else (
        //     // activeNetworkConfig = getAnvilEthConfig();
        // )
    }



    function getSepoliaEthConfig() public pure returns(NetworkConfig memory){
        // Price feed address
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed:  0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function getAnvilEthConfig() public returns (NetworkConfig memory){
        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(8, 2000e8);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed:  address(mockPriceFeed)
        });
        return anvilConfig;

    }

}