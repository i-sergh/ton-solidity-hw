
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Multiplier {

	
	uint public mul = 1;

	constructor() public {
		
		require(tvm.pubkey() != 0, 101);
		y
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}
	
	modifier checkOwnerAndAccept {
		
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

	
	function multiply(uint value) public checkOwnerAndAccept {
		mul *= value;
	}

    function multiply_10(uint value) public checkOwnerAndAccept {
        require ( value >= 1 && value <= 10, 100,  "NOT IN 1 TO 10 RANGE");
		mul *= value;
	}
   
}