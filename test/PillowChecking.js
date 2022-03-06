const PillowChecking = artifacts.require("PillowChecking");

describe("PillowChecking", function () {
	it("Should print statements when calling setThisAddress to console through consol.log", async function () {
		// let chx = await PillowChecking.new();
		// await chx.setThisAddress();
		// expect(await "Hello".to.equal("Hello"));

		const chx = await PillowChecking.new();
		await chx.setThisAddress();

		await chx.createAccount(500);
	});
});
