pragma solidity ^0.4.24;

/**
 * @title ERC20 Interface
 * Author : xas.io
 * Version : 1.0
*/
interface ERC20 {
    function balanceOf(address _owner) constant external returns (uint balance);
    function transfer(address _to, uint _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
}
