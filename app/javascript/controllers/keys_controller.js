import { Controller } from "@hotwired/stimulus"
import { registerKey } from "models/crypto"
import * as openpgp from "openpgp"

export default class extends Controller {
    static targets = ["email", "privateKey", "publicKey"];

    async generate(event) {
        event.preventDefault();
        const key = await openpgp.generateKey({
            curve: "curve25519",
            userIDs: [{ name: "Anonymous", email: this.emailTarget.value }],
            passphrase: 'super long and hard to guess secret password',
            format: 'armored',
        });

        this.privateKeyTarget.value = key.privateKey;
        this.publicKeyTarget.value = key.publicKey;
    }

    async register() {
        const key = this.privateKeyTarget.value;
        if (key) {
            await registerKey(key);
        }
    }
}
