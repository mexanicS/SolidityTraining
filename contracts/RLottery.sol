// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RLottery {
  struct player{
    uint Num;
  }
  mapping(uint => player) public players;

  function getTickets (uint Num) public payable{
    require(Num <= 10,"10 players have already been registered");
    players[Num] = player(Num);
  }

  function Winner() public view returns(string memory, uint){
    uint lenght = 10;
    uint index;
    uint randomnumber = uint(keccak256(abi.encodePacked(block.timestamp,msg.sender, lenght)))%9;
    randomnumber++;
    index = randomnumber %10;
    return ("winner's number", index);
  }
}
