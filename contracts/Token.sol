//SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract TokenERC20 is ERC20 {
    bytes32 public merkleRoot =
        0xed39c0625d3c34f2a942ec37043c55231822da379bb5ac5eac6bfd171a61e567;
    mapping(address => bool) public claimed;
    event Minted(address guy, uint256 value);

    constructor(string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
    {
        _mint(address(this), 100 * 10**18);
    }

    function claim(bytes32[] calldata _merkleProof) public {
        require(!claimed[msg.sender], "Already claimed token");
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(
            MerkleProof.verify(_merkleProof, merkleRoot, leaf),
            "Invalid proof."
        );

        // Change status of claimed.
        claimed[msg.sender] = true;
        // Mint the token.
        uint256 _value = 10 * 10**18;
        _mint(msg.sender, _value);
        emit Minted(msg.sender, _value);
    }
}
