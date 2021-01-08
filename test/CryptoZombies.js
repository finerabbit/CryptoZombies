const CryptoZombies = artifacts.require("CryptoZombies");
const utils = require("./helper/utils");
const zombieNames = ["fucking", "covid"];
contract("CryptoZombies", (accounts) => {
  let [alice, bob] = accounts;
  let contractInstance;
  let assert = require('assert');
  beforeEach(async () => {
    contractInstance = await CryptoZombies.new();
  });
  it("should be able to create a new zombie", async () => {
    const result = await contractInstance.createRandomZombie(zombieNames[0], {from: alice});
    assert.equal(result.receipt.status, true);
    assert.equal(result.logs[0].args.name, zombieNames[0]);
  });
  it("should not allow two zombies", async () => {
    await contractInstance.createRandomZombie(zombieNames[0], {from: alice});
    await utils.shouldThrow(contractInstance.createRandomZombie(zombieNames[1], {frome: alice}));
  });
  afterEach(async () => {
    await contractInstance.kill();
  });
})
