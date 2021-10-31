
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameobj_interface.sol";
import "armyunit.sol"; 
import "basestation.sol";
contract barbar is  armyunit {
    
  
  
    constructor(basestation addr) public {
        
        require(tvm.pubkey() != 0, 101);

        require(msg.pubkey() == tvm.pubkey(), 102);
        
        tvm.accept();
        _baseAddr = address(addr);
        addr.newUnit(address(this), unitType);
        myDmg = 10;
        _hp = 10;
        unitType ="Barbar";
        
    }

}