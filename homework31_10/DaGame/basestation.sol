
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameobj.sol"; 
import "gameobj_interface.sol"; 

contract basestation is  gameobj{
    // для деплоя проекта на новый адрес
    int kostil = 29; 

    // соотношение имеющихся юнитов и их адресов
    mapping (string => address)  _myUnits;

    address _enemyBaseAddr;
    // не реализовано
   // mapping (string => address)  _enemyUnits;


    constructor() public {
        require(tvm.pubkey() != 0, 101);

        require(msg.pubkey() == tvm.pubkey(), 102);
  
        tvm.accept();
        _hp = 1;
        
    }

    // сначала создается база и юниты

    // далее должен пройти обмен адресами между станциями
    function getAddr (address enemyBaseAddr)  public {
        tvm.accept();
        _enemyBaseAddr = enemyBaseAddr;

    }




    //не реализовано
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



    function showMeMyUnits() public returns(address, address){
        tvm.accept();
         
         
        return (_myUnits["Archer"] , _myUnits["Barbar"]);
    }

    // самоуничтожение 
    function iWantToDie() public{
        tvm.accept();
        
        iAmDead(_enemyBaseAddr);
    }

    function iAmDead (address dest) virtual public override{
        tvm.accept();
        gameobj(_myUnits["Archer"]).iAmDead2(dest);
        destroyUnit("Archer");
        gameobj(_myUnits["Barbar"]).iAmDead2(dest);
        destroyUnit("Barbar");
        dest.transfer(1, false, 160);  


    }

}
