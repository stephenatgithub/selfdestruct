// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/EtherGame.sol";

contract EtherGameTest is Test {
    EtherGame public etherGame;
    Attack public a;

    function setUp() public {
        etherGame = new EtherGame();
        a = new Attack(etherGame);
    }

    function testDeposit() public {
        address alice = address(1);
        vm.prank(alice);
        vm.deal(alice, 1 ether);
        etherGame.deposit{value: 1 ether}();

        address bob = address(2);
        vm.prank(bob);
        vm.deal(bob, 1 ether);
        etherGame.deposit{value: 1 ether}();

        assertEq(address(etherGame).balance, 2 * 1e18 );
    }

    function testAttack() public {
        address alice = address(1);
        vm.prank(alice);
        vm.deal(alice, 1 ether);
        etherGame.deposit{value: 1 ether}();

        address bob = address(2);
        vm.prank(bob);
        vm.deal(bob, 1 ether);
        etherGame.deposit{value: 1 ether}();

        address eve = address(3);
        vm.prank(eve);
        vm.deal(eve, 10 ether);
        a.attack{value: 10 ether}();

        assertEq(address(etherGame).balance, 12 * 1e18 );
    }

}
