pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players; 

    function Lottery() public {
        manager = msg.sender;
    }
    function enter() public payable  { // we added payable because when someone calls this method they might send some ether along 
        require(msg.value > .01 ether); // if throws false the program stops, otherwise it continues 
        players.push(msg.sender);
    }

    function random() private view returns(uint) {
        return uint(keccak256(block.difficulty, now, players)); //all this variables are global variables already available

    }

    function pickWinner() public restricted {

        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0); 
    }

    modifier restricted() { //you can choose whatever name you like 
        require(msg.sender == manager);
        _; // underscore will be replaced by the function code where restricted what present in it's signature 
    }

    function getPlayers() public view  returns(address[]) {
        return players; 
    }
}