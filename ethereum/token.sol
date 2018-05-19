pragma solidity ^0.4.24;

import "./safeMath.sol";
import "./interface.sol";

contract HFRToken is ERC20 {
    using SafeMath for uint256;

    // balances for an address
    mapping (address => uint256) public balances;
    // approved balance for an address
    mapping (address => mapping (address => uint256)) public allowed;

    // Event fired when a transfer is executed
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    // Event fired when an approval is executed
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // Returns the name of the token
    function name() public pure returns (string) { return "HFR Token"; }
    // Returns the symbol of the token
    function symbol() public pure returns (string) { return "HFR"; }
    // Returns the number of decimals the token uses - e.g. 8, means to divide the token amount by 100000000 to get its user representation.
    function decimals() public pure returns (uint8) { return 18; }
    // Returns the total token supply. 10M here.
    function totalSupply() public pure returns (uint256) { return 10000000 ether; }

    /**
    * @dev Gets the balance of the specified address.
    * @param _owner The address to query the the balance of.
    * @return An uint256 representing the amount owned by the passed address.
    */
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    /**
    * @dev transfer token for a specified address
    * @param _to The address to transfer to.
    * @param _value The amount to be transferred.
    */
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0));
        require(_value <= balances[msg.sender]);

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /**
    * @dev Transfer tokens from one address to another
    * @param _from address The address which you want to send tokens from
    * @param _to address The address which you want to transfer to
    * @param _value uint256 the amount of tokens to be transferred
    */
    function transferFrom (
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool)
    {
        require(_to != address(0));
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);

        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    /**
    * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
    *
    * Beware that changing an allowance with this method brings the risk that someone may use both the old
    * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
    * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
    * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
    * @param _spender The address which will spend the funds.
    * @param _value The amount of tokens to be spent.
    */
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
    * @dev Function to check the amount of tokens that an owner allowed to a spender.
    * @param _owner address The address which owns the funds.
    * @param _spender address The address which will spend the funds.
    * @return A uint256 specifying the amount of tokens still available for the spender.
    */
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }
}