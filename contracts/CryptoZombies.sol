pragma solidity >=0.5.0 <0.6.0;

import "./ZombieOwnership.sol";

contract CryptoZombies is ZombieOwnership {
    function HelloWorld() external pure returns (string memory) {
        return "Wahaha!";
    }

    function kill() public payable onlyOwner {
        selfdestruct(address(uint160(owner())));
    }
}