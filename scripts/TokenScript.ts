import { ethers } from "hardhat";
const addr = "0xf18be8A5FcBD320fDe04843954c1c1A155b9Ae2b";

async function main() {
  const Token = await ethers.getContractFactory("TokenERC20");
  const token = await Token.deploy("Merkle Root", "MRT");

  await token.deployed();

  console.log(token.address);
  console.log("Token address", await token.balanceOf(token.address));
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
