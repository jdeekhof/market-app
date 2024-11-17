import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "output"]
  static values = { showIf: String }
  connect() {
    console.log('connected')
    this.toggle()
  }

  toggle() {
    console.log('toggled')
    console.log(this.inputTarget.value)
    if (this.inputTarget.value === this.showIfValue) {
      this.outputTarget.hidden = false
    } else {
      this.outputTarget.hidden = true
    }
  }
}
