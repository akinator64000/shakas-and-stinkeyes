require("@nomiclabs/hardhat-waffle");


module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: process.env.NETWORK_URL,
      accounts: [process.env.NETWORK_ACCOUNT],

    }
  }
};
