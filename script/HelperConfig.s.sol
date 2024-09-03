// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";

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

    function getAnvilEthConfig() public returns(NetworkConfig memory){
        // Price feed address
        // 1. Deploy the mocks
        // 2. Return the mock address
    }

}