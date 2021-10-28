import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]
  static targets = [ "dropdown" ]

  hamburger(){
    this.dropdownTarget.classList.toggle("hidden")
  }
}
