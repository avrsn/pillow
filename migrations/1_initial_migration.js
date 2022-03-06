const Migrations = artifacts.require("Migrations");

module.exports = function (deployer) {
  // deployer.deploy(Migrations);

  const migrations = await Migrations.new();
  Migrations.setAsDeployed(migrations);
};
