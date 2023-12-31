// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

import { Pool } from "./Pool.sol";
import { IPoolFactory } from "./interfaces/IPoolFactory.sol";

contract PoolFactory is IPoolFactory, Ownable {
    constructor() Ownable(msg.sender) { }

    /*//////////////////////////////////////////////////////////////////////////
                        EXTERNAL NON-CONSTANT FUNCTIONS
    //////////////////////////////////////////////////////////////////////////*/

    function createPool(
        address fundAsset_,
        string memory baseURI_,
        uint256 startTimestamp_,
        uint256 endTimestamp_,
        uint256 targetAmount_,
        string[] memory names_,
        uint256[] memory ids_,
        uint256[] memory mintPrices_,
        uint256[] memory maxSupplys_
    )
        external
        override
        returns (address pool_)
    {
        require(fundAsset_ != address(0), "PoolFactory: fund asset is zero address");
        require(startTimestamp_ > block.timestamp, "PoolFactory: start timestamp must be in the future");
        require(endTimestamp_ > startTimestamp_, "PoolFactory: end timestamp must be after start timestamp");
        require(targetAmount_ > 0, "PoolFactory: target amount cannot be zero");

        Pool pool = new Pool(
            fundAsset_,
            msg.sender,
            baseURI_,
            startTimestamp_,
            endTimestamp_,
            targetAmount_,
            names_,
            ids_,
            mintPrices_,
            maxSupplys_
        );
        emit PoolCreated(msg.sender, address(pool));
        return (address(pool));
    }
}
