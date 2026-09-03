import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "overlay"]

  connect() {
    this.isOpen = false
  }

  toggle() {
    this.isOpen = !this.isOpen
    this.updateVisibility()
  }

  close() {
    this.isOpen = false
    this.updateVisibility()
  }

  updateVisibility() {
    // For mobile: sidebar slides in, overlay appears
    if (this.isOpen) {
      this.sidebarTarget.classList.remove("-translate-x-full")
      this.sidebarTarget.classList.add("translate-x-0")
      this.overlayTarget.classList.remove("hidden")
      this.overlayTarget.classList.add("block")
    } else {
      this.sidebarTarget.classList.add("-translate-x-full")
      this.sidebarTarget.classList.remove("translate-x-0")
      this.overlayTarget.classList.add("hidden")
      this.overlayTarget.classList.remove("block")
    }

    // For desktop: we don't use translate; the sidebar is always visible.
    // We handle this with Tailwind's responsive classes in the HTML.
  }
}