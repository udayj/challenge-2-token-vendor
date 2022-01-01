//SPDX-License-Identifier:MIT
pragma solidity ^0.7.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";



contract Vendor is Ownable{

  YourToken yourToken;
  uint256 private tokensPerEth = 100;
  
  event BuyTokens(address buyer, uint256 amountOfEth, uint256 amountOfTokens);
  constructor(address tokenAddress) public {
    yourToken = YourToken(tokenAddress);
  }

  //ToDo: create a payable buyTokens() function:

  function buyTokens() payable public {

    require(msg.value >0, "Not enough ETH");
    yourToken.transfer(msg.sender,msg.value*tokensPerEth);
    emit BuyTokens(msg.sender,msg.value,msg.value*tokensPerEth);

  }

  //ToDo: create a sellTokens() function:

  function sellTokens(uint256 amount) public {

    //this if should actually be a require statement so that user knows that sell cant be called without calling approve on the token
    if(yourToken.allowance(msg.sender,address(this))>=amount) {

      yourToken.transferFrom(msg.sender,address(this),amount);
      msg.sender.transfer(amount/tokensPerEth);
    }
  }

  //ToDo: create a withdraw() function that lets the owner, you can 
  //use the Ownable.sol import above:

  function withdraw(uint256 amount) public onlyOwner{
    
      uint256 balance = address(this).balance;
      require(balance >=amount,"Not enough balance with contract") ;
      
      address payable ownerAddress=payable(owner());
      ownerAddress.transfer(amount);
      
  }
}
