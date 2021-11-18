import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form" ]

  showForm(){
    this.formTarget.classList.toggle("hidden")
  }
}
