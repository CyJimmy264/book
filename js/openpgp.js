const openpgp = require('openpgp')

async function verify(text, detachedSignature, publicKeyArmored) {
  const publicKey = await openpgp.readKey({ armoredKey: publicKeyArmored })

  const message = await openpgp.createMessage({ text: text })

  const signature = await openpgp.readSignature({
    armoredSignature: detachedSignature
  })

  const verificationResult = await openpgp.verify({
    message,
    signature,
    verificationKeys: publicKey
  })

  const { verified, keyID } = verificationResult.signatures[0]
  try {
    await verified
    console.log('Signed by key id ' + keyID.toHex().toUpperCase())
  } catch (e) {
    throw new Error('Signature could not be verified: ' + e.message)
  }
}

async function main() {
  if (process.argv.length < 3) {
    console.log('Usage : node openpgp.js <command> [<arg1>] [<arg2>] [...]')
    process.exit(1)
  }

  const command = process.argv[2]

  switch (command) {
    case 'verify':
      await verify(process.argv[3], process.argv[4], process.argv[5])
      break;
  }
}

main()
