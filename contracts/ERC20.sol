pragma solidity >=0.5.0;

interface ERC20Interface {

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(
        address indexed tokenOwner, address indexed spender, uint tokens
    );

    function totalSupply()
        external view returns (uint);

    function balanceOf(address tokenOwner)
        external view returns (uint balance);

    function transfer(address to, uint tokens)
        external returns (bool success);

    function transferFrom(address from, address to, uint tokens)
        external returns (bool success);

    function approve(address spender, uint tokens)
        external returns (bool success);

    function allowance(address tokenOwner, address spender)
        external view returns (uint remaining);
}

contract ERC20Implementation is ERC20Interface {

    string private _name = "KhaNa Token";
    string private _symbol = "KHT";
    uint8 private _decimals = 18;
    uint private totalAmount;

    mapping(address => uint) private balances;

    mapping(address => mapping(address => uint)) private allowances;

    constructor(uint amount) public {
        totalAmount = amount * uint(10) ** _decimals;
        balances[msg.sender] = amount * uint(10) ** _decimals;
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function decimals() external view returns (uint8) {
        return _decimals;
    }

    function totalSupply() external view returns (uint) {
        return totalAmount;
    }

    function balanceOf(address tokenOwner)
        external view returns (uint balance) {
            return balances[tokenOwner];
        }

    function transfer(address to, uint tokens)
        external returns (bool success) {
            require(balances[msg.sender] >= tokens, "not enough tokens");
            balances[msg.sender] = balances[msg.sender] - tokens;
            balances[to] = balances[to] + tokens;
            emit Transfer(msg.sender, to, tokens);
            return true;
        }

    function transferFrom(address from, address to, uint tokens)
        external returns (bool success) {
            require(
                allowances[from][msg.sender] >= tokens,
                "not enough tokens in allowances"
            );
            require(balances[from] >= tokens, "not enough tokens");
            balances[from] = balances[from] - tokens;
            allowances[from][msg.sender] = allowances[from][msg.sender] - tokens;
            balances[to] = balances[to] + tokens;
            emit Transfer(from, to, tokens);
            return true;
        }

    function approve(address spender, uint tokens)
        external returns (bool success) {
            allowances[msg.sender][spender] = tokens;
            emit Approval(msg.sender, spender, tokens);
            return true;
        }

    function allowance(address tokenOwner, address spender)
        external view returns (uint remaining) {
            return allowances[tokenOwner][spender];
        }
}
