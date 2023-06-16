// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Boom.sol";

contract BoomTest is Test {
    DCDCBomb public dCDCBomb;

    function setUp() public {  
        dCDCBomb = new DCDCBomb{value: 41 ether}();
        console.log("DCDCBomb deployed at ", address(dCDCBomb));      
    }

    function testBoom() public {
        console.log("DCDCBomb balance before selfdestruct ", address(dCDCBomb).balance);
        assertEq(address(dCDCBomb).balance, 41 * 1e18 );

        // trigger fallback in DCDCBomb
        // it creates new contract DCBomb and then trigger fallback in DCBomb and send all remaining ethers
        // it creates new contract Bomb and then trigger fallback in Bomb and send all remaining ethers
        (bool s,) = address(dCDCBomb).call("");        
        //require(s, "fallback failed");

        console.log("DCDCBomb balance after selfdestruct ", address(dCDCBomb).balance);
        assertEq(address(dCDCBomb).balance, 0 );
    }

}
