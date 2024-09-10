const { createAttestation } = require('./signProtocol');
const { ethers } = require('ethers');

const attester = "0x1F658AF12F5a0D72e4652f53399e556B9dB23904";
const options = ethers.AbiCoder.defaultAbiCoder().encode(
  ['string', 'string', 'string', 'string'],
  ["Parametro pA", "Parametro pB", "Parametro pC", "Parametro pD"]
);

async function main(){

  const resultAttestation = await createAttestation(attester, options)
  console.log(resultAttestation);

}

main();