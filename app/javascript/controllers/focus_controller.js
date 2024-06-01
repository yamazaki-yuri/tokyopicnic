import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="focus"
export default class extends Controller {
  static targets = ["edit", "title"]

  connect() {
    this.editTarget.addEventListener('click', this.focusTitle.bind(this))
  }
  focusTitle(){
    this.titleTarget.focus();
  }
}
