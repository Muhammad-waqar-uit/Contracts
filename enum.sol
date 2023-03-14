pragma solidity ^0.8.0;

contract MyContract {
    enum Action {
        SIGNUP,
        LOGIN,
        LOGOUT
    }
    
    function getActionValue(Action action) public view returns (uint) {
        if (action == Action.SIGNUP) {
            return uint(Action.SIGNUP);
        } else if (action == Action.LOGIN) {
            return uint(Action.LOGIN);
        } else if (action == Action.LOGOUT) {
            return uint(Action.LOGOUT);
        }
    }
}
