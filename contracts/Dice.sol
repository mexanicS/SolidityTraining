// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Dice {
  address public manager;
  address payable[] public players;

  function CEO() public{
    manager = msg.sender;
  }

  function Enter() public payable returns(uint) {
    require(msg.value > .001 ether, "the bid is too small");
    players.push(payable(msg.sender));
  }

  function getRandomNumber(uint number) public view returns(uint) {
    uint brosok = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, number))) % 10;
    brosok = brosok + 2;
    return(brosok);
  }

  function Winner() public payable restricted returns(string memory, uint, uint){
    uint player1 = getRandomNumber(0);
    uint player2 = getRandomNumber(1);
    if(player1 > player2){
        players[0].transfer(address(this).balance);
        return("win 1 gamer",player1, player2);
      }
      else if(player1 < player2){
        players[1].transfer(address(this).balance);
        return("win 2 gamer",player1, player2);
    }
    else return("nobody", player1, player2);
  }
  modifier restricted() {
    require(msg.sender == manager, "No access ");
    _;
  }
}
