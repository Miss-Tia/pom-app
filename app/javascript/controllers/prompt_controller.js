import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="prompt"
export default class extends Controller {
  static targets = ["output"]

  generate(event) {
    event.preventDefault()

    fetch("/generate_prompt", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": this.getMetaValue("csrf-token")
      }
    })
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`)
        }
        return response.json()
      })
      .then(data => {
        if (data.prompt) {
          this.outputTarget.value = data.prompt
        } else {
          this.outputTarget.value = "Sorry, no prompt could be generated."
        }
      })
      .catch(error => {
        console.error("Error generating prompt:", error)
        this.outputTarget.value = "Something went wrong. Try again later."
      })
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element && element.getAttribute("content")
  }
}
