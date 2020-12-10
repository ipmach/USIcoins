var Web3 = require("web3");
App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
web3 = new Web3(App.web3Provider);

var adoptionInstance;

App.contracts.Adoption.deployed().then(instance => instance.addPerson.call("Jimmy", "Tobbias", "Msc"))
                .then(value => instance.get_count.call()).then(count => {
                document.getElementById("demo").innerHTML = count;
                })