pragma solidity ^0.5.1;


contract ERC20Token{
    string public name;
    mapping(address => uint256) public balances;

    function mint() public {
     balances[tx.origin]++;
    }
}

contract MyContract{
    address payable wallet;
    address token;

    event Purchase(
       address indexed _buyer,
       uint256 _amount
    );

    constructor(address payable _wallet, address _token) public {
        wallet = _wallet;
        token = _token;
    }

    function() external payable {
        buyToken();
    }
    //....... send ether
    function buyToken() public payable{
      ERC20Token(address(token)).mint();
        // send ether to the wallet
        wallet.transfer(msg.value);
        // emit Purchase(msg.sender, 1);
    }

 //Data types in solidity

    string public value = "my value";
    bool public myBool = true;
    int public myInt = -1;
    uint public myUint = 1;
    uint8 public myUint8 = 8;
    uint256 public myUint256 = 9998433;


//Enum

    enum State { Waiting, Ready, Active }
    State public state;

    // constructor() public {
    //     state = State.Waiting;
    // }

    function activate() public {
        state = State.Active;
    }

    function isActive() public view returns(bool) {
        return state == State.Active;
     }


//Struct

    Person[] public people;
    mapping(uint => Person) public people;
    uint256 public peopleCount = 0;

    uint256 openingTime = 1673246999;
    address owner;

//custom modifier
    modifier onlyOwner() {
        // check if the function call equals a specific owner
       require(msg.sender == owner);
       _;
    }

    modifier onlyWhileOpen(){
        require(block.timestamp >= openingTime);
        _;
    }

    // set the owner account value
    // constructor() public {
    //    owner = msg.sender;
    //  }

    struct Person {
        uint _id;
        string _firstname;
        string _lastname;
    }

    function addPerson(
     string memory _firstname, 
     string memory _lastname) 
     public onlyWhileOpen
     {
     incrementCount();
      people[peopleCount] = Person(peopleCount, _firstname, _lastname);
    }

  //modifiers (public, internal...)

    function incrementCount() internal {
         peopleCount += 1;
    }


//  //define a constructor to set initial values
//     constructor() public {
//         value = "MyValue";
//     }

//     function get() public view returns(string memory){
//         return value;
//     }

//     function set(string memory _value) public{
//       value = _value;
//   }


    
}