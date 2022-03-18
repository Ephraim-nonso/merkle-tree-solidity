//SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleAirdrop {
    mapping(address => bool) public claimed;
    bytes32 public merkleRoot =
        0xf55c84ed4c7e0dd9786ec8c2a510adddcbca7d56e1ecd1fa46b165552274fe9f;

    IERC20 private token = IERC20(0x0e83Cd3Dd1209d36F8147948C3318E53803d1Be0);
    event Minted(address _addr, uint256 _amount);

    function claim(
        bytes32[] calldata _merkleProof,
        uint256 id,
        uint256 _amount
    ) public returns (bool success) {
        require(!claimed[msg.sender], "Already claimed token");
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, id, _amount));
        require(
            MerkleProof.verify(_merkleProof, merkleRoot, leaf),
            "Invalid proof."
        );
        claimed[msg.sender] = true;

        // transfer token.
        token.transfer(msg.sender, _amount);

        // Change status of claimed.
        success = true;

        // transfer(msg.sender, _value);
        emit Minted(msg.sender, _amount);
    }
}
