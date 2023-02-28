pragma solidity ^0.8.0;

contract LinearBondingCurve {
    uint256 public supply;
    uint256 public a;
    uint256 public b;

    constructor(uint256 _a, uint256 _b) public {
        a = _a;
        b = _b;
    }

    function getPrice(uint256 _supply) public view returns (uint256) {
        return a * _supply + b;
    }

    function issue(uint256 _amount) public {
        supply += _amount;
    }

    function redeem(uint256 _amount) public {
        require(_amount <= supply);
        supply -= _amount;
    }
}
