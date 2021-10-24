
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract token {

    struct Hero {
        string name;
        string role;
        uint power;
        uint range;

    }

    //stores tokens
    Hero [] tokensArr;
        // tokenId => adress
    mapping (uint => uint ) tokenToOwner;
        // tokenId => price 
    mapping (uint => uint ) price;

    // для проверки уникальности
        //Hero.name => new Hero.name
    mapping (string => string) uniqName;
   
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();

    }

    function createToken(string name,string role, uint power, uint range) public{
        tvm.accept();
        // проверка на уникальность
        require(uniqName[name] != name, 101);
        // при создании инициализируется соответствие
        uniqName[name] = name;

        tokensArr.push( Hero(name,role, power, range) );

        tokenToOwner[ tokensArr.length - 1 ] = msg.pubkey();
    }

    // установка новой цены
    function  setThePrice (uint tokenId, uint priceValue) public{
        require(msg.pubkey() ==  tokenToOwner[tokenId], 101 );
        tvm.accept();
        price[ tokenId ] = priceValue;

    }


    function genTokenOwner(uint tokenId) public  view returns (uint){
        return tokenToOwner[ tokenId ]; 
    }

    function getTokenInfo (uint tokenId ) public returns(string tokenName, string tokenRole, uint tokenPower, uint tokenRange, optional(uint) price_){

        tokenName = tokensArr[tokenId].name;
        tokenRole = tokensArr[tokenId].role;
        tokenPower = tokensArr[tokenId].power;
        tokenRange = tokensArr[tokenId].range;
        // если цена 0, то токен не продается; price_ = none 
        if (price[tokenId] > 0)
            price_ = price[tokenId]; 
        tvm.accept();

    }

    function changeOwner ( uint tokenId, uint pubKeyOfNewOwner) public{
        require(msg.pubkey() ==  tokenToOwner[tokenId], 101 );
        tvm.accept();
        tokenToOwner[ tokenId] = pubKeyOfNewOwner;

    }

    function changePower ( uint tokenId, uint newPower) public{
        require(msg.pubkey() ==  tokenToOwner[tokenId], 101 );
        tvm.accept();
        tokensArr[ tokenId].power = newPower;

    }

    
}

