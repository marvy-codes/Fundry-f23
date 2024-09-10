// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {FundMe} from "../src/FundMe.sol";

import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {

    FundMe fundMe;

    address USER = makeAddr("User");
    uint256 constant SEND_VALUE = 0.1 ether; // 10000000000000000
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);

    }


    function testMinimumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }
    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.getOwner(), address(msg.sender));
    }

    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert();
       fundMe.fund();
    }
    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER);
         fundMe.fund{value: SEND_VALUE}();
         uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
         assertEq(amountFunded, SEND_VALUE);
    }
    function testAddsFundersToArrayOfFunders() public {
        vm.prank(USER);
         fundMe.fund{value: SEND_VALUE}();
         address funders = fundMe.getFunder(0);
         assertEq(funders, USER);
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        vm.expectRevert();
        vm.prank(USER);
        fundMe.withdraw();

    }
}