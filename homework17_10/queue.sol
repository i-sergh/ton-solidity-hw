
/*
Очередь 


Выполнено Ипполитовым Сергеем

*/


pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract queue {
   
    string [] public people_queue ;


    constructor() public {

        require(tvm.pubkey() != 0, 101);

        require(msg.pubkey() == tvm.pubkey(), 102);

        tvm.accept();

        
    }

	modifier checkOwnerAndAccept {
		
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

    // функция добавления в конец
    function qAppend(string person_name) public checkOwnerAndAccept {
        people_queue.push(person_name);

    }

    // функция удаления из начала
     function qRemove () public checkOwnerAndAccept {
        require(!people_queue.empty(), 100);

        for (uint i = 0; i<people_queue.length-1; i++){
            people_queue[i] = people_queue[i+1];
        }
        
        people_queue.pop();
    }


}
