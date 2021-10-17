

/*
Список дел

выполнено Ипполитоым Сергеем

Прим.: элемент списка дел считается пустым, если его название (itemName) пустая строка ("")
Попытка добавить пустое имя дела вызовет исключение 

*/

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract todolist {

    // структура элемента списка
    struct listitem{
        string itemName;
        uint32 timeStamp;
        bool isChecked;
    }

    // счетчик используемых ключей
    int8 public _numberItemKeys = 124; 

    // число всех элементов
    int8 public _numberItems = 0; 
    // счетчик количества неотмеченых элементов списка
    int8 public _numberUnchecedItems = 0;

   
    mapping (int8 => listitem) todoList;

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

    // функция добавления задачи 
    function addItem(string itemName) public checkOwnerAndAccept {
        require(_numberItemKeys < 127, 103, "Todo list is full. Try func optimization");
        require(itemName != "", 103, "itemName can not be empty");
        todoList [_numberItemKeys] = listitem(itemName, now, false);
        _numberItemKeys +=1;
        _numberUnchecedItems +=1;
        _numberItems +=1;
        
    }

// случайно сделал функцию возврата только неотмеченых пунктов списка.. Пусть будет
    function getUncheckItems() public checkOwnerAndAccept returns(listitem [] ){
         
        listitem [] uncheckedItems;

        for(int8 i =0; i < _numberItemKeys; i++){
           
            if (!todoList[i].isChecked && todoList[i].itemName != "") 
                uncheckedItems.push(todoList[i]);
                
        }
        
        return uncheckedItems;
    }
// функция возвращает число открытых (неотмеченых) задач
    function getNumberOfUncheckedItems() public checkOwnerAndAccept returns(int8 ){

        
        return _numberUnchecedItems;
    }

// функция возвращает число доступных задач  
    function getNumberOfItems() public checkOwnerAndAccept returns(int8 ){
        
        return _numberItems;
    }    

// возвращает весь список задач 
    function getList() public checkOwnerAndAccept returns(listitem []){
        listitem [] returnItems;

        for(int8 i = 0; i < _numberItemKeys; i++){
            if (todoList[i].itemName != "")
                returnItems.push(todoList[i]);
        }
        
        return returnItems;
        
    }

// возвращает задачу по ключу (вызов ключа без привязки к задаче вернет пустую задачу)
    function getItemName(int8 key) public checkOwnerAndAccept returns(listitem){
        return todoList[key];
    }

// функция удаления задачи
    function delItem(int8 key) public checkOwnerAndAccept {
        // если задача была неотммеченой, счетчик неотмеченых задач понизится 
        if (!todoList[key].isChecked) 
            _numberUnchecedItems -= 1;

        _numberItems -= 1;
        delete todoList[key];
    }


// функция отметки задачи
    function checkItem(int8 key) public checkOwnerAndAccept {
        require(todoList[key].itemName != "", 100, "The item for this key is empty");
       
        todoList[key].isChecked = !todoList[key].isChecked;
        
        if (todoList[key].isChecked)
            _numberUnchecedItems -= 1;

    }

/*  дополнительно функция отимизации использования ключей списка 
    
    сдвигает к началу все элементы списка дел (отображения) на  пустые (удаленные) позиции

    освобождает доступ к ключам, если в списке есть удаленные элементы

    пример: если в списке было 8 дел ("д0", "д1", "д2", "д3", "д4", "д5", "д6", "д7"), из них удалили дела 1, 2, 5   ("д0", "", "", "д3", "д4", "", "д6", "д7"),
    то после оптимизации список будет выглядеть так ("д0","д3", "д4", "д6", "д7")
    Освободилось три ключа, но дела с 3 по 7 сдвинуты по ключам вверх списка

    Возвращает "List optimized", если оптимизация прошла успешно
    Возвращает "List is full!", если список полон (нет пустых и/или удаленных элементов), и птимизацию провести невозможно
*/
    function listOptomization ()public checkOwnerAndAccept returns(string) {
   

    for (int8 i = 0; i < _numberItemKeys; i++){
        
        if (todoList[i].itemName == ""){
            
            int8 j = i;
            while (todoList[j].itemName == "" && j< _numberItemKeys ){
                
                j++;
            }
            

            if(todoList[j].itemName != ""){
                
                todoList[i] = todoList[j];
                delete todoList[j];
            }
               
            else
            {
                
                _numberItemKeys -= j-i;
                return "List optimized";
            }
             
           

        }
       
    }
     return "List is full!";
}
    

}
