## Vulnerability

Contracts can be deleted from the blockchain by calling selfdestruct.

selfdestruct sends all remaining Ether stored in the contract to a designated address.

It does not matter if the designated address has receive() / fallback() or not (even without payable functions).

A malicious contract can use selfdestruct to force sending Ether to any contract.


## Preventative Techniques

Don't rely on address(this).balance



## Additional Comments 

create2 and selfdestruct can be combined as an attack.

1. deploy C0 --create2--> C1 --create--> C2
2. selfdestruct C1 & C2
3. deploy C0 --create2--> C1 --create--> attack

C1 is deployed with the same precompute contract address using create2.
Because create2 depends on sender_address, salt, init_code
C1 contract address remains unchanged as long as salt remains unchanged.

C2 is selfdestruct and then deployed with attack code using create.
Because create depends on sender_address, nonce
C1 is re-depolyed and its nonce is reset to 0
attack contract address remains unchanged as long as nonce remains unchanged.


[create](https://docs.soliditylang.org/en/latest/control-structures.html#creating-contracts-via-new)

function addr(sender_address, nonce)


[create2](https://docs.soliditylang.org/en/latest/control-structures.html#salted-contract-creations-create2)

function addr(sender_address, salt, init_code)


