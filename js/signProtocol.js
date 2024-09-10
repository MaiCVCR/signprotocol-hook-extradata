const { SignProtocolClient, SpMode, EvmChains } = require("@ethsign/sp-sdk");
const { privateKeyToAccount } =  require("viem/accounts");
const dotenv = require("dotenv");
dotenv.config();

const privateKey = process.env.PRIVATE_KEY;
const commitmentSchemaId = "0x2ae";

const client = new SignProtocolClient(SpMode.OnChain, {
    chain: EvmChains.baseSepolia,
    account: privateKeyToAccount(privateKey),
  }); 

async function createAttestation(attester, options) {
  
  const res = await client.createAttestation(
    {
    schemaId: commitmentSchemaId,
    data: {
      attester
    },
    indexingValue: attester.toLowerCase()
    },
    {
      extraData: options
    }
    );

  return res;

}

module.exports = {
  createAttestation
};