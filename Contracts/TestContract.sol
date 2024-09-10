// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { ISPHook } from "@ethsign/sign-protocol-evm/src/interfaces/ISPHook.sol";
import { IERC20 } from "@openzeppelin/contracts/interfaces/IERC20.sol";

contract custom {

    address public attester;
    string pA;
    string pB;
    string pC;
    string pD;

    function setValues(address _attester, bytes memory _data) public {
        attester = _attester;
        (pA, pB, pC, pD) = abi.decode(_data, (string, string, string, string));
    }

    // Function to get the current value of the counter (optional since the counter is public)
    function getValues() public view returns (string memory, string memory, string memory, string memory) {
        return (pA, pB, pC, pD);
    }
}

// @dev This contract implements the actual schema hook.
contract Hook is ISPHook, custom {

    function didReceiveAttestation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        bytes calldata extraData// extraData
    )
        external
        payable
    {
        setValues(attester, extraData);
    }

    function didReceiveAttestation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        IERC20, // resolverFeeERC20Token
        uint256, // resolverFeeERC20Amount
        bytes calldata // extraData
    )
        external
        view
    {
        getValues();
    }

    function didReceiveRevocation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        bytes calldata extraData// extraData
    )
        external
        payable
    {
        setValues(attester, extraData);
    }

    function didReceiveRevocation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        IERC20, // resolverFeeERC20Token
        uint256, // resolverFeeERC20Amount
        bytes calldata // extraData
    )
        external
        view
    {
        getValues();
    }
}