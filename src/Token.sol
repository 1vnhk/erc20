// SPDX-License-Identifier: MIT

pragma solidity ^0.8.33;

contract Token {
    mapping(address => uint256) private s_balances;

    string public constant name = "My Token";
    uint8 public constant decimals = 18;
    uint256 public constant totalSupply = 100 ether;

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        uint256 previousBalances = balanceOf(msg.sender) + balanceOf(_to);
        s_balances[msg.sender] -= value;
        s_balances[_to] += value;

        return (balanceOf(msg.sender) + balanceOf(_to) == previousBalances);
    }

}