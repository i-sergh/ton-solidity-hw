
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
    int public myDmg = 2;
    
    /*
    constructor(basestation addr) public {
        
        require(tvm.pubkey() != 0, 101);

        require(msg.pubkey() == tvm.pubkey(), 102);
        
        tvm.accept();
        _baseAddr = address(addr);
        addr.newUnit(address(this), unitType);
        
    }
    */
    function getAttackStrength (int _myDmg) virtual public{
        tvm.accept();
        myDmg = _myDmg;
    }
    function attackSomething (gameobj_interface addr ) virtual public {
        tvm.accept();
        addr.getAttack(myDmg);
    }



     function iAmDead (address dest) public override{
        tvm.accept();
        // 0_0 
        // я очень удивлен, что это так работает
        basestation(_baseAddr).destroyUnit( unitType);
        dest.transfer(1, false, 160);  
        

    }
  
}
