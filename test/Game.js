const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Game", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployOneYearLockFixture() {
    const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
    const ONE_GWEI = 1_000_000_000;

    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const Game = await ethers.getContractFactory("Game");
    const game = await Game.deploy();

    return { game, owner, otherAccount };
  }

  describe("Deployment", function () {

    it("bateau au bon endroit", async function () {
      const { game, owner } = await loadFixture(deployOneYearLockFixture);
      await game.placeBoat({name:0, kind:0, direction: 0, coord:{row:0, col:0},state:0});

      
      expect(await game.owner()).to.equal(owner.address);
    });
  });
});
