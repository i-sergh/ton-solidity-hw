
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameobj_interface.sol";
import "armyunit.sol"; 
import "basestation.sol";
contract archer is  armyunit {
    
    int kistyl_ = 3;
  
    constructor(basestation addr) public {
        
        require(tvm.pubkey() != 0, 101);

        require(msg.pubkey() == tvm.pubkey(), 102);
        
        tvm.accept();
        unitType ="Archer";
        myDmg = 4;
        _hp = 5;
        _baseAddr = address(addr);
        addr.newUnit(address(this), unitType);
        
        
        
    }

}