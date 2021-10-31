
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameobj.sol"; 
import "gameobj_interface.sol"; 

contract basestation is  gameobj{
    
    int kostil = 24; 

    // соотношение имеющихся юнитов и их адресов
    mapping (string => address)  _myUnits;

    mapping (string => address)  _enemyUnits;


    constructor() public {
        require(tvm.pubkey() != 0, 101);

        require(msg.pubkey() == tvm.pubkey(), 102);
  
        tvm.accept();
        _hp = 1;
        
    }

    // сначала создается база и юниты

    //после происходит обмен адресами
/*
    function getAddr (address enemyBaseAddr, address enemyArcherAdrr, address enemyBarbarUnit) public {
         _enemyUnits["Base"] = enemyBaseAddr;
         _enemyUnits["Archer"] = enemyArcherAdrr;
         _enemyUnits["Barbar"] = enemyBarbarUnit;

    }
    function sendAddr () public returns(address, address, address){
         return (  
            _myUnits["Base"],
            _myUnits["Archer"],
            _myUnits["Barbar"]
            );

    }
*/


    function newUnit (address addrOfUnit, string unitType) public {
        tvm.accept();
        _myUnits[unitType] = addrOfUnit;
    } 

    function destroyUnit(string unitType) public{
        tvm.accept();
        delete _myUnits[unitType];
    }

    // самоуничтожение 
    function iWantToDie() public{
        tvm.accept();
        iAmDead(_enemyUnits["Base"]);
    }

}
