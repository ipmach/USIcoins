const usicoins = artifacts.require("Users_op");

contract("Users_op", (accounts) => {
    let contract;

    before(async () => {
        contract = await usicoins.deployed();
    });

     describe("Creating an account", async () => {
         it("There should be not people in the app", async () => {
             const value = await contract.get_count.call();
             assert.equal(value, 0, "We should get True value");
         });

         it("Creating an account for the first time", async () => {
           const value = await contract.addPerson.call("Jimmy", "Tobbias", "Msc");
           assert.equal(value, true, "We should get True value");
         });

         it("There should be people in the app", async () => {
            usicoins.deployed().then(instance => instance.addPerson.call("Jimmy", "Tobbias", "Msc"))
                .then(value => instance.get_count.call()).then(count => {
                assert.equal(count, 1, "It wasnt 1");})
         });

     });

     describe("Reservating a Room", async () => {
         it("Creating a room", async () =>{
             usicoins.deployed().then(instance => instance.add_class.call("Library", 12, 20,1)
                 .then(a => instance.get_count_room()).then(count_class => {
                     assert.equal(count_class, 1, "It wasnt 1");
                 }))
         });

     });
});