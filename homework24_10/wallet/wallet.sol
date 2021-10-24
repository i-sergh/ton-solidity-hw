pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Wallet {
    /*
     Exception codes:
      100 - message sender is not a wallet owner.
      101 - invalid transfer value.
     */

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }


    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}


    function sendTransactionIPay(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {
         
        dest.transfer(value, bounce, 0);
    }

    function sendTransactionUPay(address dest, uint128 value, bool bounce) public pure checkOwnerAndAccept {
         
        dest.transfer(value, bounce, 1);
    }

    function sendTransactionAllAndDestroy(address dest,  bool bounce) public pure checkOwnerAndAccept {
         
        dest.transfer(1, bounce, 160);
    }

    

}