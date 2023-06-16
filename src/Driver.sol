// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/console.sol";


contract Driver {
    // you can inspect these addresses in REMIX
    C0 public c0 = new C0();
    address public addr1;
    //address public addr2;
    //address public addr3;

    // STEP 1
    function newC1C2C3() external {
        console.log("Creating C1 -> C2 -> C3");

        C1 c1 = c0.newC1(); // CREATE2
        addr1 = address(c1);
        console.log("C1 deployed at ", addr1);

        // C2 c2 = c1.newC2(); // CREATE
        // addr2 = address(c2);
        // console.log("C2 deployed at ", addr2);

        // C3 c3 = c2.newC3(); // CREATE
        // addr3 = address(c3);
        // console.log("C3 deployed at ", addr3);
    }

    // STEP 2
    function bomb() external {
        console.log("selfdestruct");

        (bool ok1, ) = addr1.call(""); // trigger SELFDESTRUCT in fallback()
        require(ok1);
        // (bool ok2, ) = addr2.call(""); // trigger SELFDESTRUCT in fallback()
        // require(ok2);
        // (bool ok3, ) = addr3.call(""); // trigger SELFDESTRUCT in fallback()
        // require(ok3);
    }

    // STEP 3
    function newC1CafeBabe() external {
        console.log("Creating C1 -> Cafe -> Babe");
        
        C1 c1 = c0.newC1();         // CREATE2: deploy C1 at the same address
        addr1 = address(c1);
        console.log("C1 deployed at ", addr1);

        // Cafe cafe = c1.newCafe();   // CREATE: replaces C2 at the same address
        // addr2 = address(cafe);
        // console.log("Cafe deployed at ", addr2);

        // Babe babe = cafe.newBabe(); // CREATE: replaces C3 at the same address
        // addr3 = address(babe);
        // console.log("Babe deployed at ", addr3);
    }
}

contract C0 {
    function newC1() external returns (C1 test) {
        console.log("newC1 in C0");
        test = new C1{salt: 0}();
    }
}
contract C1 {
    uint name = 0xC1;
    //           addr1   addr2   addr3
    // branches: C1   -> C2   -> C3
    //        or C1   -> Cafe -> Babe
    function newC2() external returns (C2) { return new C2(); }       // CREATE
    function newCafe() external returns (Cafe) { return new Cafe(); } // CREATE
    fallback() external { 
        console.log("selfdestruct in C1");
        selfdestruct(payable(address(0)));
        console.log("finish in C1");
    }
}
contract C2 {
    uint name = 0xC2;
    function newC3() external returns (C3) { return new C3(); }       // CREATE
    fallback() external { 
        console.log("selfdestruct in C2");
        selfdestruct(payable(address(0))); 
        console.log("finish in C2");
    }
}
contract C3 {
    uint name = 0xC3;
    fallback() external { 
        console.log("selfdestruct in C3");
        selfdestruct(payable(address(0))); 
        console.log("finish in C3");
    }
}
contract Cafe {
    uint name = 0xCafe;
    function newBabe() external returns (Babe) { return new Babe(); } // CREATE
    fallback() external { 
        console.log("selfdestruct in Cafe");
        selfdestruct(payable(address(0))); 
        console.log("finish in Cafe");
    }
}
contract Babe {
    uint name = 0xBabe;
    fallback() external { 
        console.log("selfdestruct in Babe");
        selfdestruct(payable(address(0))); 
        console.log("finish in Babe");
    }
}