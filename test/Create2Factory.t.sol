// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Create2Factory.sol";

contract Create2FactoryTest is Test {
    Create2Factory public create2Factory;

    function setUp() public {
        create2Factory = new Create2Factory();
    }

    function testDeploy() public {
        address alice = address(1);
        vm.prank(alice);

        address addr = create2Factory.deploy(alice, 1, "777");

        console.log("create2Factory deployed at ", address(create2Factory));
        console.log("TestContract deployed at ", addr);
    }
    


}
