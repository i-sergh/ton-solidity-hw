
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameobj_interface.sol";
import "gameobj.sol"; 
import "basestation.sol";
contract armyunit is gameobj {
    
  
  
    constructor(basestation addr) public {
        
        require(tvm.pubkey() != 0, 101);

        require(msg.pubkey() == tvm.pubkey(), 102);
        
        tvm.accept();
        _baseAddr = address(addr);
        addr.newUnit(address(this), unitType);
        myDmg = 4;
        unitType ="Archer";
        
    }

}