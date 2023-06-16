// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Driver.sol";

contract DriverTest is Test {
    Driver public driver;

    function setUp() public {  
        driver = new Driver(); 
    }

    function testDriver() public {
        address alice = address(1);
        vm.startPrank(alice);
        vm.deal(alice, 10 ether);

        driver.newC1C2C3();
        driver.bomb();
        driver.newC1CafeBabe();

    }

}
