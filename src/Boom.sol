// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/console.sol";


contract Bomb {
    fallback() external {
        console.log("fallback in Bomb", address(this).balance);
        selfdestruct(payable(address(0)));

        // this line cannot execute after selfdestruct
        console.log("finish in Bomb", address(this).balance);
    }
}

contract DCBomb {
    fallback() external {
        console.log("fallback in DCBomb", address(this).balance);
        (bool ok, ) = address(new Bomb()).delegatecall("");
        require(ok);
        console.log("finish in DCBomb", address(this).balance);
    }
}

contract DCDCBomb {
    uint private name = 0xDCDCBBBB;
    constructor() payable {}
    fallback() external {
        console.log("fallback in DCDCBomb", address(this).balance);
        (bool ok, ) = address(new DCBomb()).delegatecall("");
        require(ok);
        console.log("finish in DCDCBomb", address(this).balance);
    }
}