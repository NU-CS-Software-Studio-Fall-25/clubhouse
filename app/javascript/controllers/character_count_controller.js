import { Controller } from "@hotwired/stimulus"

// Adds a simple "current/max" counter to text inputs.
export default class extends Controller {
  static targets = ["input", "counter"]
  static values = { max: Number }

  connect() {
    this.boundUpdate = this.update.bind(this)
    this.inputTarget.addEventListener("input", this.boundUpdate)
    this.update()
  }

  disconnect() {
    this.inputTarget.removeEventListener("input", this.boundUpdate)
  }

  update() {
    const max = this.#maxCharacters()
    const current = this.inputTarget.value?.length || 0
    this.counterTarget.textContent = `${current}/${max} characters`
  }

  #maxCharacters() {
    if (this.hasMaxValue && this.maxValue) {
      return this.maxValue
    }

    return Number(this.inputTarget.getAttribute("maxlength")) || 0
  }
}
