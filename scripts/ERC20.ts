import { ethers } from "hardhat";

async function main() {
  const Token = await ethers.getContractFactory("BRT");
  const token = await Token.deploy("BoredApeToken", "BRT");
  await token.deployed();
  console.log("contract adress is:", token.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
