const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
    'call never start elevator escape slender bridge parent alarm smile legend off',
    'https://rinkeby.infura.io/v3/2c227d97b26b4278ab1502601626e937'
    );

const web3 = new Web3(provider);
    // we use function to call async syntax , that is the only reason 
const deploy = async () =>  {
    const accounts = await web3.eth.getAccounts();
    
    console.log('Atemptinhg to deploy from account', accounts[0]);
    
    const result = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({ data: bytecode })
        .send({ gas: '1000000', from: accounts[0] });
    
    console.log(interface);
    console.log('Contract deploy to', result.options.address);
}; 
deploy();