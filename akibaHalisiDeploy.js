const ethers = require("ethers");
const fs = require("fs-extra");   // this enables us to get the abi and binary of our contract.


async function Main() {

    const provider = new ethers.providers.JsonRpcProvider("http://127.0.0.1:7545"); // the api address is from ganache that links our wallet with node
    const wallet = new ethers.wallet("75746e7cf5e75069f38ab34bfbbb95b637e48d0a47e32c1eb9ea51f225e477ee", provider); //ganache private key. Posting your private is never recommender, is just that this time we are using a fake account

    const abi = fs.readFileSync("./akibaHalisi_sol_akibaHalisi.abi", "utf8");
    const binary = fs.readFileSync("./akibaHalisi_sol_akibaHalisi.bin", "utf8");

    const contractHalisi = new ethers.contractHalisi(abi, binary, wallet);
    console.log("deploying pending,  please wait");
    const contract = await contractHalisi.deploy();
    console.log(contract);

}

Main()
.then(() => Process.exit(0))
.catch((error) => {
    console.error(error);
    ProcessingInstruction.exit(1);
})
