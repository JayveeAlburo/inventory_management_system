
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "email",
    "password",
    "emailError",
    "passwordError"
  ]

  validate(event) {
    let isValid = true

    // Clear previous errors
    this.clearErrors()

    // Email validation
    if (this.emailTarget.value.trim() === "") {
      this.showError(
        this.emailTarget,
        this.emailErrorTarget,
        "Email is required"
      )

      isValid = false
    }

    // Password validation
    if (this.passwordTarget.value.trim() === "") {
      this.showError(
        this.passwordTarget,
        this.passwordErrorTarget,
        "Password is required"
      )

      isValid = false
    }

    // Stop form submission if validation fails
    if (!isValid) {
      event.preventDefault()
    }
  }

  showError(input, errorElement, message) {
    input.classList.remove("border-slate-300")
    input.classList.add("border-red-500", "focus:border-red-500", "focus:ring-red-500")

    errorElement.textContent = message
    errorElement.classList.remove("hidden")
  }

  clearError(event) {
    const input = event.currentTarget

    if (input.value.trim() !== "") {
      input.classList.remove(
        "border-red-500",
        "focus:border-red-500",
        "focus:ring-red-500"
      )

      input.classList.add("border-slate-300")

      if (input === this.emailTarget) {
        this.emailErrorTarget.textContent = ""
        this.emailErrorTarget.classList.add("hidden")
      }

      if (input === this.passwordTarget) {
        this.passwordErrorTarget.textContent = ""
        this.passwordErrorTarget.classList.add("hidden")
      }
    }
  }

  clearErrors() {
    this.emailErrorTarget.textContent = ""
    this.emailErrorTarget.classList.add("hidden")

    this.passwordErrorTarget.textContent = ""
    this.passwordErrorTarget.classList.add("hidden")

    this.emailTarget.classList.remove(
      "border-red-500",
      "focus:border-red-500",
      "focus:ring-red-500"
    )

    this.passwordTarget.classList.remove(
      "border-red-500",
      "focus:border-red-500",
      "focus:ring-red-500"
    )

    this.emailTarget.classList.add("border-slate-300")
    this.passwordTarget.classList.add("border-slate-300")
  }
}
