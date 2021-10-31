
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameobj_interface.sol";
import "gameobj.sol"; 
import "basestation.sol";
contract armyunit is gameobj {
    
    // адрес базовой станции
    address public _baseAddr;
    // тип юнита
    string public unitType ="Hi";
    // атака юнита
    uint public myDmg = 2;
    constructor(basestation addr) public {
        
        require(tvm.pubkey() != 0, 101);

        require(msg.pubkey() == tvm.pubkey(), 102);
        
        tvm.accept();
        _baseAddr = address(addr);
        addr.newUnit(address(this), unitType);
        
    }
    function getAttackStrength (uint _myDmg) public{
        tvm.accept();
        myDmg = _myDmg;
    }
    function attackSomething (gameobj_interface addr ) public {
        tvm.accept();
        addr.getAttack(myDmg);
    }
  
}
