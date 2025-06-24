import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timestamp"
export default class extends Controller {
  static targets = ["created", "updated"]

  connect() {
    if (this.hasCreatedTarget) {
      const createdUtc = this.createdTarget.dataset.utc;
      this.createdTarget.textContent = this.formatLocal(createdUtc);
    }

    if (this.hasUpdatedTarget) {
      const updatedUtc = this.updatedTarget.dataset.utc;
      this.updatedTarget.textContent = this.formatLocal(updatedUtc);
    }
  }

  formatLocal(utcString) {
    return new Date(utcString).toLocaleString(undefined, {
      dateStyle: "long",
      timeStyle: "short"
    });
  }
}
