import { Controller } from "@hotwired/stimulus"
import * as openpgp from "openpgp"

export default class extends Controller {
  static targets = ["content", "signature"]

  async sign(event) {
    event.preventDefault()

    const message = await openpgp.createMessage({
      text: this.contentTarget.innerText,
    })

    const passphrase = prompt("Please enter your passphrase")

    try {
      const privateKey = await openpgp.decryptKey({
        privateKey: await openpgp.readPrivateKey({ armoredKey: localStorage.keys }),
        passphrase,
       })

      const signature = await openpgp.sign({
        message,
        signingKeys: privateKey,
        detached: true,
      })

      this.signatureTarget.value = signature

      this.element.querySelector('form').submit()
    } catch(err) {
      alert(err.message)
    }
  }
}
