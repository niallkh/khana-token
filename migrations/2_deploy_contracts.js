const ERC20 = artifacts.require("ERC20Implementation");
const TOTAL_AMOUNT_TOKENS = 1000;

module.exports = function(deployer) {
  deployer.deploy(ERC20, TOTAL_AMOUNT_TOKENS);
};
