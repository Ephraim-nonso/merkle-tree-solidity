import { ethers } from "hardhat";

async function main() {
  const Merkle = await ethers.getContractFactory("MerkleAirdrop");
  const merkle = await Merkle.deploy();
  await merkle.deployed();

  console.log("contract adress is:", merkle.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
