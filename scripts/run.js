const { ConstructorFragment } = require("@ethersproject/abi");

const main = async () => {
     
    const shakasAndStinkeyesContractFactory = await hre.ethers.getContractFactory("ShakasAndStinkeyes");
    const shakasAndStinkeyesContract = await shakasAndStinkeyesContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1'),
    });
    await shakasAndStinkeyesContract.deployed;

    console.log("Contract deployed to:", shakasAndStinkeyesContract.address);

    let contractBalance = await hre.ethers.provider.getBalance(shakasAndStinkeyesContract.address);
    console.log("Contract balance: ", contractBalance.toString());

    let shakaCount = await shakasAndStinkeyesContract.getTotalShakas();
    console.log("Total shakas: ", shakaCount);

    let stinkeyeCount = await shakasAndStinkeyesContract.getTotalStinkeyes();
    console.log("Total stinkeyes: ", stinkeyeCount);

    let shakaTxn = await shakasAndStinkeyesContract.shaka("Shaka!");
    await shakaTxn.wait();

    contractBalance = await hre.ethers.provider.getBalance(shakasAndStinkeyesContract.address);
    console.log("New contract balance: ", contractBalance.toString());

    const [_, randomPerson] = await hre.ethers.getSigners();
    let stinkeyeTxn = await shakasAndStinkeyesContract.stinkeye("Stinkeye!");
    await stinkeyeTxn.wait();

    contractBalance = await hre.ethers.provider.getBalance(shakasAndStinkeyesContract.address);
    console.log("New contract balance: ", contractBalance.toString());

    shakaCount = await shakasAndStinkeyesContract.getTotalShakas();
    console.log("Total shakas: ", shakaCount);

    stinkeyeCount = await shakasAndStinkeyesContract.getTotalStinkeyes();
    console.log("Total stinkeyes: ", stinkeyeCount);

    const allMessages = await shakasAndStinkeyesContract.getAllMessages();
    console.log(allMessages);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    }
    catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();