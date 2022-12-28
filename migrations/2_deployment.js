let IdentityContract = artifacts.require('./IdentityContract.sol');

module.exports = async function(deployer){
		await deployer.deploy(IdentityContract);
} 
