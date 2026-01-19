// SPDX-License-Identifier: MIT

// This is considered an Exogenous, Decentralized, Anchored (pegged), Crypto Collateralized low volitility coin

// Layout of Contract:
// version
// imports
// interfaces, libraries, contracts
// errors
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

pragma solidity ^0.8.20;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/*
 * @title Decentralised Stablecoin
 * @author Gavin Singh
 * Collateral: Exogenous (ETH & BTC)
 * Minting: Algorithmic
 * Relative Stability: Pegged to USD
 *
 * This is the contract to be governed by the DSCEngine. This contract is just the ERC-20 implementation of the stablecoin.
 *
 */

contract DecentralisedStablecoin is ERC20Burnable, Ownable {
    error DecentralisedStablecoin__AmountMustBeGreaterThanZero();
    error DecentralisedStablecoin_BurnAmountExceedsBalance();
    error DecentralisedStablecoin__NotZeroAddress();

    constructor(
        address initialOwner
    ) ERC20("DecentralisedStablecoin", "DSC") Ownable(initialOwner) {}

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if (_amount <= 0) {
            revert DecentralisedStablecoin__AmountMustBeGreaterThanZero();
        }
        if (balance < _amount) {
            revert DecentralisedStablecoin_BurnAmountExceedsBalance();
        }
        super.burn(_amount);
    }

    function mint(
        address _to,
        uint256 _amount
    ) external onlyOwner returns (bool) {
        if (_to == address(0)) {
            revert DecentralisedStablecoin__NotZeroAddress();
        }
        if (_amount <= 0) {
            revert DecentralisedStablecoin__AmountMustBeGreaterThanZero();
        }
        _mint(_to, _amount);
        return true;
    }
}
