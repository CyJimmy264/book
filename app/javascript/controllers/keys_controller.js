import { Controller } from "@hotwired/stimulus"
import { registerKey } from "models/crypto"
import * as openpgp from "openpgp"

export default class extends Controller {
  static targets = ["username", "email", "passphrase", "privateKey", "publicKey", "fingerprint"]

  async connect() {
    if (this.publicKeyTarget.value) {
      this.fingerprintTarget.value = (
        await openpgp.readKey({ armoredKey: this.publicKeyTarget.value })
      ).getFingerprint().toUpperCase()
    }
  }

  async generate(event) {
    event.preventDefault();
    const key = await openpgp.generateKey({
      curve: "curve25519",
      userIDs: [{ name: this.usernameTarget.value, email: this.emailTarget.value }],
      passphrase: this.passphraseTarget.value,
      format: 'armored',
    });

    this.privateKeyTarget.value = key.privateKey;
    this.publicKeyTarget.value = key.publicKey;
    this.fingerprintTarget.value = (
      await openpgp.readKey({ armoredKey: key.publicKey })
    ).getFingerprint().toUpperCase()
  }

  async register() {
    const key = this.privateKeyTarget.value;
    if (key) {
      await registerKey(key);
    }
  }

  async publicKeyInput(event) {
    this.fingerprintTarget.value = (
      await openpgp.readKey({ armoredKey: this.publicKeyTarget.value })
    ).getFingerprint().toUpperCase()
  }

  async privateKeyInput(event) {
    const passphrase = prompt("Please enter your passphrase")
    const privateKey = await openpgp.decryptKey({
      privateKey: await openpgp.readPrivateKey({ armoredKey: this.privateKeyTarget.value }),
      passphrase
    })
    this.fingerprintTarget.value = privateKey.getFingerprint().toUpperCase()
    this.publicKeyTarget.value = privateKey.toPublic().armor()
  }
}
