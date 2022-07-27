// SPDX-License-Identifier: MIT


/*pragma solidity ^0.6.0;

import "./akibaHalisi.sol";

contract AkibaHalisiAccountsStorage is AkibaHalisi {
    AkibaHalisi[] public accountsStorageList;

    function createAccountsStorage() public onlyOwner {
        AkibaHalisi accountsStorage = new AkibaHalisi();
        accountsStorageList.push(accountsStorage);
    }

    function accountStore(uint256 _accountIndex, string memory _accountName)
        public
        onlyOwner
    {
        accountsStorageList[_accountIndex].createUserAccount(_accountName);
    }
}
*/