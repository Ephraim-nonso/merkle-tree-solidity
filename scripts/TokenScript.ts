import { ethers } from "hardhat";
const addr = "0xf18be8A5FcBD320fDe04843954c1c1A155b9Ae2b";

async function main() {
  //   const Token = await ethers.getContractFactory("TokenERC20");
  //   const token = await Token.deploy("Merkle Tree", "MT");
  //   const signer = await ethers.getSigner(addr);

  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());
  const Token = await ethers.getContractFactory("TokenERC20");
  const token = await Token.deploy("Merkle Root", "MRT");
  const signer = await ethers.getSigner(addr);

  await token.deployed();
  console.log("Token address is:", token.address);

  const claimed = await token.connect(signer).claim([]);
  console.log(claimed);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
