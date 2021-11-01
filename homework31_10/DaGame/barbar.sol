
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameobj_interface.sol";
import "armyunit.sol"; 
import "basestation.sol";
contract barbar is  armyunit {
    // для деплоя проекта на новый адрес
    int kistyl_ = 6;
  
    constructor(basestation addr) public {
        
        require(tvm.pubkey() != 0, 101);

        require(msg.pubkey() == tvm.pubkey(), 102);
        
        tvm.accept();
        unitType ="Barbar";
        myDmg = 10;
        _hp = 10;
        _baseAddr = address(addr);
        addr.newUnit(address(this), unitType);
        
        
    }

}