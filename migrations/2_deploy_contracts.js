var contract = artifacts.require("Users_op");

module.exports = function(deployer) {
  deployer.deploy(contract);
};