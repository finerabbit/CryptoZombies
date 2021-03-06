pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {
    uint levelUpFee = 0.001 ether;
    
    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }
    
    function changeName(uint _zombieId, string calldata _name) external aboveLevel(2, _zombieId) onlyOwnerOf(_zombieId) {
        zombies[_zombieId].name = _name;
    }
    
    function changeDna(uint _zombieId, uint _dna) external aboveLevel(20, _zombieId) onlyOwnerOf(_zombieId) {
        zombies[_zombieId].dna = _dna;
    }
    
    function getZombiesByOwner(address _owner) external view returns (uint[] memory) {
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        uint counter = 0;
        
        for (uint i=0; i<zombies.length; i++) {
            if (zombieToOwner[i] == _owner) {
                result[counter++] = i;
            }
        }
        
        return result;
    }
    
    function levelUp(uint _zombieId) external payable {
        require(msg.value == levelUpFee);
        zombies[_zombieId].level++;
    }
    
    function withdraw() external onlyOwner {
        address payable _owner = address(uint160(owner()));
        _owner.transfer(address(this).balance);
    }
    
    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }
}