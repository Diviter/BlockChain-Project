// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./priceInterface.sol";
import "./akibaHalisi.sol";

contract akibaFunds is AkibaHalisi {
    using priceInterface for uint256;

    mapping(address => uint256) public addressToPremiumDeposited;
    address[] public Insureds;

    uint256 public constant premiumInUSD = 50 * 10**18;

    /*
    The functions needs:
    - abi of the price conversaton rate contract
    - address- from the chainlink data feeds ehtereum testnet (0x8A753747A1Fa494EC906cE90E9f37563A8AF630e)
    - choose a network to work with from the data.chain.link (rinkeyby)
    */

    function Deposit() public payable {
        require(
            msg.value.getConversionRate() >= premiumInUSD,
            "insuffient Amount"
        ); // we are not passing a variable even though it is expected (uint256 ethAmount) this is because msg.value is the first variable recognised.
        addressToPremiumDeposited[msg.sender] += msg.value;
        Insureds.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        ); // the address is from chainlink ethereum data feeds rinkeby testnet
        return priceFeed.version();
    }

    // creating a loop for withdraw function such that anytime premiums are send to th account it is withdrawn and reset to the initial default number of the address.
    function withdraw() public onlyOwner {
        for (
            uint256 insuredIndex = 0;
            insuredIndex < Insureds.length;
            insuredIndex++
        ) {
            address insured = Insureds[insuredIndex];
            addressToPremiumDeposited[insured] = 0;
        }

        //resetting the array
        Insureds = new address[](0);

        //call
        (bool callSuccessful, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccessful, "call failed");
    }
}
