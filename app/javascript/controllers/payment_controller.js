import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selection", "additionalFields"]

  connect() {
    this.hideAll()
  }

  showAdditionalFields() {
    this.hideAll()

    const selected = this.selectionTarget.value

    this.additionalFieldsTargets.forEach(fieldset => {
      if (fieldset.dataset.type === selected) {
        fieldset.hidden = false
      }
    })
  }

  hideAll() {
    this.additionalFieldsTargets.forEach(fieldset => {
      fieldset.hidden = true
    })
  }
}
