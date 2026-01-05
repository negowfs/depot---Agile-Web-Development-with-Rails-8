import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selection", "check", "cc", "po"]

  connect() {
    this.showAdditionalFields()
  }

  showAdditionalFields() {
    const selected = this.selectionTarget.value

    this.checkTarget.style.display =
      selected === "Check" ? "block" : "none"

    this.ccTarget.style.display =
      selected === "Credit card" ? "block" : "none"

    this.poTarget.style.display =
      selected === "Purchase order" ? "block" : "none"
  }
}
